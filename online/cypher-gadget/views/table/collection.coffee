define ["../../color_manager"], (colorManager) ->

  class CollectionTableView extends Backbone.View

    tpl: """
      <td>
        <div class="collection-title"><%= label %></div>
        <div class="node-properties">
          <ul>
            <% _.each(data, function(datum) { %>
            <li>
              <% if (_.has(datum, "_type")) { %>
                <span class="table-relationship"><%= datum._type %></span>
              <% } else if (_.has(datum, "_id")) { %>
                <div class="table-node" style="background-color:<%= datum.color %>;"></div>
                <div><%= datum.name || datum.title || _.keys(_.omit(datum, "_id"))[0] || '' %></div>
              <% } else { %>
                <%= datum %>
              <% } %>
            </li>
            <% }); %>
          </ul>
        </div>
      </td>
    """

    constructor: (cell) ->
      @data = cell

    render: ->
      # Attach colors onto the data
      label = []
      _.each @data.collection, (datum) ->
        if _.has(datum, "_type")
          label.push(datum._type)
        else if _.has(datum, "_id")
          label.push(datum.name || datum.title || _.keys(_.omit(datum, "_id"))[0] || '')
        else
          label.push datum
        if datum.properties?._labels?
          datum.color = colorManager.getColorForLabels(@data.properties._labels).bright
      _.template @tpl, data: @data.collection, label: JSON.stringify(label)