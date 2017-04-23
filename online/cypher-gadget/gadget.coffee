define ["views/input", "views/table/table", "views/visualization", "views/error","views/info", "models/cypher", "./taskchecker",
  "data/tasks"],
  (Input, Table, Visualization, Error, Info, Cypher, taskchecker, taskslib) ->
    class CypherGadget
      tpl: """
      <div class="cypherGadget">
        <div class="task" style="display:none;">
          <div class="task-bg"></div>
          <div class="task-msg"></div>
        </div>
        <div class="not-task">
          <div class="visualization"></div>
          <div class="input"></div>
          <div class="query-table"></div>
          <div class="error-container"></div>
          <div class="info-container"></div>
        </div>
      </div>
    """

      constructor: (options) ->
        @$el = options.$el
        #      @player = options.player
        #      @player.on "domReady", @render, @
        @config = options.config
        debounced = _.debounce((=> @createCypher()), 2000)
        #      @config.on "change:cypherTask", @setTaskMsg, @
        #      @config.on "change:cypherSetup", debounced, @
        #      @config.on "change:cypherTaskJSON", @readTaskJSON, @
        @userstate = options.userState
        @userstateDfd = if @userstate.gadget.get("id") then @userstate.fetch() else new $.Deferred().resolve()

#      options.propertySheetSchema.set('cypherSetup', { type:'Text', title:"DB setup key" })
#      options.propertySheetSchema.set('cypherTask', {type:'Select', title:"Predefined Task", options:["None"].concat(_.keys(taskslib))})
#      options.propertySheetSchema.set('cypherTaskJSON', {type:'TextArea', title:"Custom Task JSON"})

      render: ->
        @$el.html(@tpl)

        @viz = new Visualization(@$el.find('.visualization'))

        _.bindAll @, "onQuery"

        @table = new Table(@$el.find('.query-table'))
        @error = new Error(@$el.find('.error-container'))
        @info = new Info(@$el.find('.info-container'))

        @setTaskMsg()

        @table.on "dismissed", =>
          @viz.showDefault()

        @table.on "undismissed", =>
          @viz.draw(@lastViz)

        if @config.get("cypherTaskJSON")
          @readTaskJSON()

        @userstateDfd.done =>
          unless @userstate.get("uuid")
            s4 = -> Math.floor((1 + Math.random()) * 0x10000).toString(16).substring(1)
            uuid = s4() + s4() + s4() + s4() + s4()
            @userstate.set({uuid: uuid})
            @userstate.save()
          @createCypher() if @config.get("cypherSetup")

          if @userstate.get("successful")
            @setSuccessful()

          @input = new Input(@$el.find('.input'), @userstate, @solution)
          @input.render()
          @input.on 'description', => @showDescription()
          @input.on 'query', @onQuery
          @input.on 'reset', =>
            @viz.empty()
            @cypher.empty()
            @table.dismiss()
            @setUnsuccessful()
            @userstate.save("successful", false)
            @createCypher()

      createCypher: ->
        @cypher = new Cypher(@userstate.get("uuid"), @config.get("cypherSetup"), @config.get("host"))
        @cypher.init().done((res) =>
          @viz.create(JSON.parse(res).visualization)
          @table.setMaxHeight @viz.height
        ).fail((xhr, err, msg) => @error.render(msg))

      setTaskMsg: ->
        taskDiv = @$el.find('.task')
        task = taskslib[@config.get("cypherTask")] || @customTask
        if task
          taskDiv.show()
          taskDiv.find('.task-msg').text(task.message)
        else
          taskDiv.hide()

      showDescription: ->
        if @description
          @info.render @description

      onQuery: (query) ->
        if cypherTask = taskslib[@config.get("cypherTask")] || @customTask
          @errors = taskchecker.checkInputTasks cypherTask, query
          if @errors.length > 0
            @error.render @errors[0]
        @submitQuery(query)

      setSuccessful: ->
        @$el.find('.task-bg').addClass("successful")

      setUnsuccessful: ->
        @$el.find('.task-bg').removeClass("successful")

      submitQuery: (query) ->
        @cypher.submitQuery(query).done((res) =>
          @error.dismiss()
          @input.stopLoadingIndicator()
          json = JSON.parse(res)
          if json.error
            @error.render json.error
          else
            @input.addToHistory query
            interpreted = @cypher.interpret(json)
            @viz.draw(json.visualization)
            @lastViz = json.visualization # store reference for when table is undismissed
            if interpreted.rows.length > 0
              @table.render @cypher.interpret(json), query
              @viz.setTableDims(@table.$el.width(), @table.$el.height())
            else
              @table.dismiss()
            if cypherTask = taskslib[@config.get("cypherTask")] || @customTask
              @errors = @errors.concat taskchecker.checkOutputTasks cypherTask, json
              if @errors.length > 0
                @error.render @errors[0]
              else
                @setSuccessful()
                @userstate.save("successful", true)
        ).fail((xhr, err, msg) =>
          @input.stopLoadingIndicator()
          @error.render(msg)
        )

      readTaskJSON: ->
        if @config.get("cypherTaskJSON") == ""
          @customTask = null
          return
        json = JSON.parse decodeURIComponent @config.get("cypherTaskJSON")
        if json.solution
          @solution = json.solution
        if json.description
          @description = json.description
        if json.message && json.tasks
          @customTask = json
        else
          @customTask = null
        @setTaskMsg()
