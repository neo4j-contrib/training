define [], () ->

  class Error extends Backbone.View

    tpl: """
      <div class="error-msg"></div>
      <div class="icon-dismiss"><i class="fa-times-circle fa"></i></div>
    """

    events:
      'click .icon-dismiss': 'dismiss'

    initialize: (@$el) -> #

    render: (errorMsg) ->
      @$el.html(@tpl)
      @$el.show()
      @$el.find('.error-msg').text(errorMsg)

    dismiss: ->
      @$el.hide()