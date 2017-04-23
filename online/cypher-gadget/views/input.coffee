define ["data/samples.js", "libs/codemirror", "libs/cm-cypher", "libs/cm-placeholder", "libs/bootstrap-dropdown.js"], (samples) ->

  class Input extends Backbone.View

    tpl: """
      <div class='input-field'>
        <ul class='top-input-controls'>
          <li class='execute'><div class='top-control run-button'>Run</div></li>
          <li class='description'><div class='top-control'>Description</div></li>
          <li class='solution'><div class='top-control'>Solution</div></li>
          <li class='clear'><div class='top-control'>Clear query</div></li>
          <li class='empty'><div class='top-control'>Revert to original dataset</div></li>
          <div style='clear:both;'></div>
        </ul>
        <div>
          <textarea class='query' placeholder='Type a query here!'></textarea>
        </div>
        <ul class='bottom-input-controls'>
          <li class='back disabled bottom-control'><i class='icon-caret-left'></i></li>
          <li class="history-dropdown disabled btn-group bottom-control">
            <a class="history-button dropdown-toggle" data-toggle="dropdown" href="#">
              History <i class="icon-caret-up"></i>
            </a>
            <ul class="history dropdown-menu">
            </ul>
          </li>
          <li class='forward disabled bottom-control'><i class='icon-caret-right'></i></li>
          <li class="samples-dropdown btn-group pull-right bottom-control">
            <a class="samples-button dropdown-toggle" data-toggle="dropdown" href="#">
              Code Samples <i class="icon-caret-up"></i>
            </a>
            <ul class="samples dropdown-menu">
              <span class="samples-label">Reading</span>
              <% _.each(samples.read, function(sample, index){ %>
                <li class="sample" data-value=<%= "read_"+index %>><%= sample.desc %></li>
              <% }); %>
              <span class="samples-label">Writing</span>
              <% _.each(samples.write, function(sample, index){ %>
                <li class="sample" data-value=<%= "write_"+index %>><%= sample.desc %></li>
              <% }); %>
            </ul>
          </li>
          <div style='clear:both;'></div>
        </div>
      </ul>
    """

    events:
      'click .execute': 'execute'
      'click .description': 'onDescriptionClick'
      'click .solution': 'onSolutionClick'
      'click .back': 'onBackClick'
      'click .forward': 'onForwardClick'
      'click .empty': 'onEmptyDBClick'
      'click .clear': 'onClearClick'
      'click .sample': 'onSampleSelect'
      'keyup .query': 'onQueryKeyup'
      'click .history-item': 'onHistoryItemSelect'
      'click .history-button': 'onHistoryClick'

    initialize: (@$el, @userState, @solution) ->
      _.bindAll @, "onQueryKeyup"
      @history = @userState.get("history") || []
      @currentIndex = @history.length

    render:  ->
      @$el.html _.template @tpl, samples:samples
      cmOptions =
        mode: "cypher"
        theme:"neo"
        lineNumbers:true
        lineWrapping:false
        fixedGutter:false
        viewportMargin: 20
      @cm = new CodeMirror.fromTextArea(@$el.find('.query')[0], cmOptions)
      @cm.on "keyup", @onQueryKeyup
      @cursorPos = @cm.getCursor()
      if @history.length > 0
        @enablePast()
      @delegateEvents()

    execute: ->
      console.log("execute",@cm.getValue())
      @trigger 'query', @cm.getValue()
      @$el.find('.run-button').css("visibility", "hidden")
#      @loading = new vs.ui.LoadingIndicator @$el.find('.execute')

    stopLoadingIndicator: ->
      @$el.find('.run-button').css("visibility", "visible")
#      @loading.stop()

    onEmptyDBClick: ->
      @trigger 'reset'

    onDescriptionClick: -> 
      @trigger 'description'

    onSolutionClick: ->
      @cm.setValue(@solution)

    onClearClick: ->
      @cm.setValue("")

    onBackClick: (e) ->
      @loadHistory()

    onForwardClick: (e) ->
      @loadFuture()

    onSampleSelect: (e) ->
      selected = $(e.target).data("value").split("_")
      presetText = samples[selected[0]][selected[1]].query
      @setQuery(presetText)

    onQueryKeyup: (cm, e) ->
      # codemirror lets you move cursor position before this event is fired so
      # pressing up puts cursor to 0 and then if we did getCursor() it'd be 0.
      cp = @cm.getCursor()
      if e.keyCode == 13 && (e.altKey || e.ctrlKey) # return
        @execute()
      else
      if e.keyCode == 38 # up
        if @cursorPos.line == 0 && @cursorPos.ch == 0 && cp.line == 0 && cp.ch == 0
          @loadHistory()
      else if e.keyCode == 40 # down
        lastLine = @cm.lastLine()
        lastLineLength = @cm.getLine(lastLine).length
        if @cursorPos.line == lastLine && @cursorPos.ch == lastLineLength && cp.line == lastLine && cp.ch == lastLineLength
          @loadFuture()
      @cursorPos = @cm.getCursor()

    clear: ->
      @cm.setValue("")

    setQuery: (query) ->
      @cm.setValue(query)

    onHistoryClick: ->
      @$el.find('.history').empty().html _.map @history.slice(Math.max(@history.length - 10,0), @history.length), (h, i) =>
        return "<li class='history-item' data-var='history_" + _.indexOf(@history, h) + "'>" + h + "</li>"

    onHistoryItemSelect: (e) ->
      @cm.setValue @history[$(e.target).data("var").split("_")[1]]

    loadHistory: () ->
      return if @currentIndex == 0
      @currentIndex--
      @setQuery(@history[@currentIndex])
      @enableFuture()
      if @currentIndex == 0
        @disablePast()

    loadFuture: () =>
      return if @currentIndex == @history.length
      if @currentIndex == @history.length-1
        @currentIndex++
        @enablePast()
        @disableFuture()
        @setQuery("")
      else
        @currentIndex++
        @setQuery(@history[@currentIndex])
        @enablePast() unless @currentIndex == 0
        if @currentIndex == @history.length-1
          @disableFuture()

    enableFuture: ->
      @$el.find('.forward').removeClass('disabled')

    enablePast: ->
      @$el.find('.history-dropdown').removeClass('disabled')
      @$el.find('.back').removeClass('disabled')

    disableFuture: ->
      @$el.find('.forward').addClass('disabled')

    disablePast: ->
      @$el.find('.back').addClass('disabled')

    # This is called by parent because parent dictates what queries were successful
    addToHistory: (query) ->
      @history.push(query)
      @userState.save history: @history
      @currentIndex = @history.length-1
      @enablePast() unless @currentIndex == 0
      @disableFuture()