define ["../../color_manager"], (colorManager) ->

  class NodeTableView extends Backbone.View

    tpl: """
      <td>
        <div class="table-node" style="background-color:<%= color %>;"></div>
        <div class="node-title"><%= props.name || props.title || _.keys(_.omit(props, "_id"))[0] || '' %></div>
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
      _.template @tpl, props: @data.properties, color: colorManager.getColorForLabels(@data.properties._labels).bright