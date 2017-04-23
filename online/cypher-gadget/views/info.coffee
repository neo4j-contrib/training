define [], () ->

  class Info extends Backbone.View

    tpl: """
      <div class="info-msg"></div>
      <div class="icon-dismiss"><i class="fa-times-circle fa"></i></div>
    """

    events:
      'click .icon-dismiss': 'dismiss'

    initialize: (@$el) -> #

    render: (msg) ->
      if @$el.find(".info-msg").is(":visible")
        @dismiss()
      else
        @$el.html(@tpl)
        @$el.show()
        @$el.find('.info-msg').html(msg)

    dismiss: ->
      @$el.hide()