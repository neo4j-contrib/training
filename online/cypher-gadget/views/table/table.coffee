define ["./node", "./relationship", "./collection"], (Node, Relationship, Collection) ->

  class TableView extends Backbone.View
    tpl: """
      <div class="table-container">
        <table>
          <tr class="header">
            <div class="dismiss"><i class="icon-caret-right"></i><i class="icon-caret-right"></i></div>
            <td></td>
            <% _.each(columns, function(col) { print('<td>'+col+'</td>') }); %>
          </tr>
        </table>
      </div>
      <div class="table-hidden"><i class="icon-caret-left"></i><i class="icon-caret-left"></i></div>
    """
    events:
      'click .dismiss': 'dismiss'
      'click .table-hidden': 'undismiss'

    initialize: (@$el) -> #

    render: (data, queryEcho) ->
      @$el.html _.template @tpl, data

      @$el.find('.table-hidden').hide()

      @$el.find('.table-container').css("max-height", @maxHeight - 40)

      nodeOrRel = false # flag to hide expanders
      _.each data.rows, (row) =>
        tr = $("<tr>")
        @$el.find('table').append(tr)
        _.each row, (cell) ->
          if cell.type == "node"
            cellview = new Node(cell)
            tr.append cellview.render()
            nodeOrRel = true
          else if cell.type == "relationship"
            cellview = new Relationship(cell)
            tr.append cellview.render()
            nodeOrRel = true
          else if cell.type == "collection"
            cellview = new Collection(cell)
            tr.append cellview.render()
            nodeOrRel = true
          else
            tr.append $("<td>"+cell+"</td>")

        if nodeOrRel
          expander = $("<td><i class='icon-caret-right expand-properties'></i></td>")
          tr.prepend(expander)
          tr.find('.node-properties').hide()
          expander.on "click", ->
            i = $(@).find("i")
            if i.hasClass('icon-caret-right')
              i.addClass('icon-caret-down').removeClass('icon-caret-right')
              tr.find('.node-properties').show()
            else if i.hasClass('icon-caret-down')
              i.addClass('icon-caret-right').removeClass('icon-caret-down')
              tr.find('.node-properties').hide()
        else
          @$el.find(".header").children().first().hide()

    dismiss: ->
      @$el.find('.table-container').hide()
      @$el.find('.table-hidden').show()
      @trigger "dismissed"

    undismiss: ->
      @$el.find('.table-container').show()
      @$el.find('.table-hidden').hide()
      @trigger "undismissed"

    setMaxHeight: (@maxHeight) -> #