define [], () ->

  class Cypher

    constructor: (@uuid, @datasetKey, @host) -> #

    interpret: (data) ->
      results =
        columns: data.columns
        rows: []

      results.rows = _.map data.json, (row) ->
        _.map row, (datum) ->
          if _.has(datum, "_type") # it is a relationship
            return { type: "relationship", properties: datum }
          else if _.has(datum, "_id") # it is a node
            return { type: "node", properties: datum }
          else if _.isArray(datum) # it is a collection
            return { type: "collection", collection: datum }
          else # it is likely a string
            return datum

      return results

    init: ->
      $.ajax
        type: "POST"
        url: @host + "/backend/cypher/"+@datasetKey
        #data: JSON.stringify({id:@datasetKey})
        #dataType: "json"
        #contentType: "application/json;charset=utf-8"
        headers: { "X-Session": @uuid }
        xhrFields: { withCredentials: true }

    submitQuery: (query) ->
      $.ajax
        type: "POST"
        url: @host + "/backend/cypher/"+@datasetKey
        data: query
        dataType: 'text'
        headers: { "X-Session": @uuid }
        xhrFields: { withCredentials: true }

    empty: ->
      $.ajax
        type: "DELETE"
        url: @host + "/backend/graph/"+@uuid
        headers: { "X-Session": @uuid }
        xhrFields: { withCredentials: true }