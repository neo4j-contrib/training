define [], () ->

  class Taskchecker

    checkOutputTasks: (task, json) ->
      outputTasks = _.filter task.tasks, (t) -> t.check == "output"
      results = _.map outputTasks, (task) =>
        if typeof task.results == "string"
          regexMatch = JSON.stringify(json.json).match(new RegExp(task.results, "i"))
          if regexMatch
            return true
          else
            return task.failMsg
        else if typeof task.test == "string"
          regexMatch = JSON.stringify(json).match(new RegExp(task.test, "i"))
          if regexMatch
            return true
          else
            return task.failMsg
        else if typeof task.test == "function"
          return task.test(query)
        else return true
      return _.reject results, (r) -> r == true

    # checks the input before it is being sent
    checkInputTasks: (task, query) ->
      inputTasks = _.filter task.tasks, (t) -> t.check == "input"
      results = _.map inputTasks, (task) =>
        if typeof task.test == "string"
          regexMatch = query.replace(/(\r\n|\n|\r)/gm,"").match(new RegExp(task.test, "i"))
          if regexMatch
            return true
          else
            return task.failMsg
        else if typeof task.test == "function"
          return task.test(query)
        else return true
      return _.reject results, (r) -> r == true

  new Taskchecker()
