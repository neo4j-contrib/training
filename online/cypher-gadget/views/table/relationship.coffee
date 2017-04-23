define [], () ->

  class RelationshipTableView extends Backbone.View

    tpl: """
      <td>
        <span class="table-relationship"><%= props._type %></span>
        <div class="node-properties">
          <ul>
            <% _.each(_.omit(props, "_id"), function(value, key){ %>
              <li>
                <span class="node-key"><%= key %>:</span>
                <span class="node-value"><%= value %></span>
              </li>
            <% }); %>
          </ul>
        </div>
      </td>
    """

    constructor: (cell) ->
      @data = cell

    render: ->
      _.template @tpl, props: @data.properties