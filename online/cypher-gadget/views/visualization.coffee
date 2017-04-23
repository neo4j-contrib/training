#define ["../color_manager", "../libs/underscore", "../libs/d3.min"], (colorManager, _) ->
define ["../color_manager"], (colorManager) ->

  class Visualization

    constructor: (@$el) ->
      @width = 725
      @height = 400
      @svg = d3.select(@$el[0]).append("svg")
                .attr("width", @width)
                .attr("height", @height)
                #.attr("viewBox", "0 0 "+@width+" "+@height)
      @viz = @svg.append("g")

      # create markerheads
      @viz.append("defs").selectAll("marker")
            .data(["arrowhead", "faded-arrowhead"])
          .enter().append("marker")
            .attr("id", String)
            .attr("viewBox", "0 0 10 10")
            .attr("refX", 17)
            .attr("refY", 5)
            .attr("markerUnits", "strokeWidth")
            .attr("markerWidth", 4)
            .attr("markerHeight", 3.5)
            .attr("orient", "auto")
            .attr("preserveAspectRatio", "xMinYMin")
          .append("path")
            .attr("d", "M 0 0 L 10 5 L 0 10 z")

      # empty msg
      @emptyMsg = @svg.append("text").text("Graph database is empty.")
                   .attr("class", "emptyMsg")
                   .attr("x", 350)
                   .attr("y", 200)
                   .attr("opacity", 0)

      @force = d3.layout.force()
                        .charge(-1380)
                        .linkDistance(100)
                        .friction(0.3)
                        .gravity(0.5)
                        .size([@width, @height])

      @force.on "tick", => @tick()

    tick: ->
      @viz.selectAll("circle")
        .attr("cx", (d) => Math.min(@width, Math.max(0, d.x)))
        .attr("cy", (d) => Math.min(@height, Math.max(0, d.y)))

      @nodeTexts.selectAll("text")
        .attr("x", (d) => Math.min(@width, Math.max(0, d.x))+8)
        .attr("y", (d) => Math.min(@height, Math.max(0, d.y))+3)

      # straight lines
      @links.attr("x1", (d) => Math.min(@width, Math.max(0, d.source.x)))
          .attr("y1", (d) => Math.min(@height, Math.max(0, d.source.y)))
          .attr("x2", (d) => Math.min(@width, Math.max(0, d.target.x)))
          .attr("y2", (d) => Math.min(@height, Math.max(0, d.target.y)))
      ### in case different links between two nodes are ever needed
      # arcs
      @links.attr "d", (d) ->
        dx = d.target.x - d.source.x
        dy = d.target.y - d.source.y
        dr = Math.sqrt(dx * dx + dy * dy)
        return "M" + d.source.x + "," + d.source.y + "A" + dr + "," + dr + " 0 0,1 " + d.target.x + "," + d.target.y
      ###
      @pathTexts.attr "transform", (d) ->
        dx = ( d.target.x - d.source.x )
        dy = ( d.target.y - d.source.y )
        dr = Math.sqrt(dx * dx + dy * dy)
        sinus = dy / dr
        cosinus = dx / dr
        l = d.type.length * 4
        offset = ( 1 - ( (l+10) / dr ) ) / 2
        x = ( d.source.x + dx * offset )
        y = ( d.source.y + dy * offset )
        return "translate(" + x + "," + y + ") matrix(" + cosinus + ", " + sinus + ", " + -sinus + ", " + cosinus + ", 0 , 0)"

    create: (graph) ->
      if graph.nodes.length == 0 && graph.links.length == 0
        @emptyMsg.attr("opacity", 1)
        return
      else
        @emptyMsg.attr("opacity", 0)

      # dynamically sets link distances based on number of nodes in graph
      d = 2*(@width || 725) /graph.nodes.length
      @force.linkDistance(Math.min(200, d))

      # dynamically sets visualization height based on number of nodes
      if graph.nodes.length < 25
        @height = 400
      else if graph.nodes.length > 100
        @height = 600
      else
        @height = (graph.nodes.length - 25)*200/75+400
      @svg.attr("height", @height)
      @force.size([@width, @height])

      # store selected node/link ids so we can use them later (without updating all the data and forcing redraws)
      @selectedNodes = []
      @selectedLinks = []

      @viz.selectAll("g").remove()
      @selective = false
      @force.nodes(graph.nodes).links(graph.links).start()
      @links = @viz.append("g").selectAll("g")
      @pathTexts = @viz.append("g").selectAll("g")
      @nodes = @viz.append("g").selectAll("g")
      @nodeTexts = @viz.append("g").selectAll("g")

      @graphCreated = true
      @draw(graph)

    # sync graph with current nodes/links (so we can update without redrawing the graph)
    # there is probably a cleaner way to do this
    syncGraphData: (newData, oldData) ->
      toAdd = _.difference((_.map newData, (n) -> n.id), (_.map oldData, (n) -> n.id))
      _.each toAdd, (nta) => oldData.push _.findWhere newData, id:nta
      toRemove = _.difference((_.map oldData, (n) -> n.id), (_.map newData, (n) -> n.id))
      _.each oldData, (n, i) => oldData.splice(i, 1) if _.indexOf(toRemove, n.id) > -1

      return (toAdd.length || toRemove.length) # returns whether or not the set changed

    draw: (graph, forceUnselective) ->
      if graph.nodes.length == 0 && graph.links.length == 0
        @emptyMsg.attr("opacity", 1)
      else
        @emptyMsg.attr("opacity", 0)

      @create(graph) unless @graphCreated
      didChange1 = @syncGraphData(graph.nodes, @force.nodes())
      didChange2 = @syncGraphData(graph.links, @force.links())
      didChange = didChange1 || didChange2

      # syncs whether node/link is selected
      _.each graph.nodes, (n) => @selectedNodes[n.id] = if n.selected then true else false
      _.each graph.links, (n) => @selectedLinks[n.id] = if n.selected then true else false


      # checks to set a flag whether or not part of the graph will be presented highlighted or not
      if forceUnselective
        @selective = false
      else
        @selective = _.some graph, (g) -> _.some g, (d) -> d.selected

      # used later to tell if two nodes are connected to each other
      @indexLinkRef = _.map graph.links, (link) -> link.start+','+link.end

      @links = @links.data(@force.links())
      @links.enter().append("line")
      @links.exit().remove()
      @links.attr("marker-end", (d) => if @selective && @selectedLinks[d.id] then "url(#arrowhead)" else "url(#faded-arrowhead)")
            .attr("class", (d) => if @selective && @selectedLinks[d.id] then "relationship" else "faded-relationship")
            .filter((l) => @selective && @selectedLinks[l.id])
              .each((l) -> @parentNode.appendChild(@))

      @pathTexts = @pathTexts.data([])
      @pathTexts.exit().remove()

      @nodes = @nodes.data(@force.nodes())
      @nodes.enter().append("circle")
            .attr("r", 5)
            .call(@force.drag)
            .each((d) =>
              d.x = (Math.random()+0.5)*@width/2
              d.y = (Math.random()+0.5)*@height/2)
            .on("mouseover", (d) => @onNodeHover(d))
            .on("mouseout", => @onNodeUnhover())
      #@nodes.exit().remove()
      @nodes.attr("class", (d) => if @selective && @selectedNodes[d.id] then "node" else "faded-node")
            .style("fill", (d) =>
              color = colorManager.getColorForLabels(d.labels)
              if !@selective || @selectedNodes[d.id] then color.bright else color.dim)

      @nodeTexts = @nodeTexts.data(@force.nodes())
      gs = @nodeTexts.enter().append("g")
            .attr("class", "node-texts")

      # d3 is annoying me right now, remove two things binded to the data
      nt = @nodeTexts.exit()
      @nodes.exit().remove()
      nt.remove()

      # TODO check to make sure this isn't adding a ton of text for no reason
      gs.append("text")
          .attr("class", "shadow")
          .text (d) -> d.name || d.title
      @nodeTexts.attr("opacity", (d) => if @selective && @selectedNodes[d.id] then 1 else 0)

      gs.append("text").text (d) -> d.name || d.title

      @force.start() if didChange

      setTimeout (=> @frameOverTime(1000)), 300

    showDefault: ->
      @draw({nodes: @force.nodes(), links: @force.links()}, true)
      @rightPadding = 0 # this is so ugly, need to get rid of this @rightPadding
      @frame()

    empty: ->
      @viz.selectAll("g").remove()
      @links = @viz.append("g").selectAll("g")
      @nodes = @viz.append("g").selectAll("g")
      @nodeTexts = @viz.append("g").selectAll("g")
      @force.nodes([]).links([])
      @emptyMsg.attr("opacity", 1)

    onNodeHover: (d) ->
      @nodes.style("fill", (n) =>
        if _.indexOf(@indexLinkRef, d.id+","+n.id) > -1 ||
            _.indexOf(@indexLinkRef, n.id+","+d.id) > -1 ||
            n.id == d.id ||
            (@selective && @selectedNodes[n.id])
          return colorManager.getColorForLabels(n.labels).bright
        else return colorManager.getColorForLabels(n.labels).dim)
        .each (n) ->
          @parentNode.appendChild(@) if n.id == d.id

      filtered = @links.filter((l) -> l.start == d.id || l.end == d.id)
          .attr("class", "relationship")
          .attr("marker-end", "url(#arrowhead)")
          .each((l) -> @parentNode.appendChild(@)) # put elements on top of non-highlighted elements

      @nodeTexts.attr("opacity", (n) =>
        if _.indexOf(@indexLinkRef, d.id+","+n.id) > -1 ||
            _.indexOf(@indexLinkRef, n.id+","+d.id) > -1 ||
            n.id == d.id ||
            (@selective && @selectedNodes[n.id])
          return 0.5
        else return 0)
        .each (l) ->
          if l.id == d.id
            d3.select(@).attr("opacity", 1)
            @parentNode.appendChild(@)

      @pathTexts = @pathTexts.data(@force.links().filter((l) -> (l.start == d.id || l.end == d.id)))
      @pathTexts.enter().append("g")
            .attr("class", "path-texts")
      @pathTexts.append("text")
          .attr("class", "shadow")
          .text (n) -> n.type
      @pathTexts.append("text").text (n) -> n.type
      @tick() # ensure a tick to force label updates to happen (d3 won't tick if idle)

    onNodeUnhover: ->
      @nodes.style "fill", (d) =>
        col = colorManager.getColorForLabels(d.labels)
        if !@selective || @selectedNodes[d.id] then col.bright else col.dim
      @links.attr("class", (d) => if @selective && @selectedLinks[d.id] then "relationship" else "faded-relationship")
            .attr("marker-end", (d) => if @selective && @selectedLinks[d.id] then "url(#arrowhead)" else "url(#faded-arrowhead)")
      @nodeTexts.attr("opacity", (d) => if @selective && @selectedNodes[d.id] then 1 else 0)
      @pathTexts = @pathTexts.data([])
      @pathTexts.exit().remove()
      @tick()

    setTableDims: (@tableWidth, @tableHeight) ->
      # for now, will refine soon
      @rightPadding = 20+@tableWidth

    frameOverTime: (ms) ->
      i = 0
      step = =>
        @frame()
        setTimeout step, 100 if i++*100 < ms
      step()

    frame: ->
      nodes = if @selectove then @nodes.filter (n) => @selectedNodes[n.id] else @nodes
      xMax = 0
      xMin = Infinity
      yMax = 0
      yMin = Infinity
      nodes.each (n) =>
        xMax = n.x if n.x > xMax
        xMin = n.x if n.x < xMin
        yMax = n.y if n.y > yMax
        yMin = n.y if n.y < yMin

      @frameViz(xMin, xMax, yMin, yMax, 50, @rightPadding)

    frameViz: (x1, x2, y1, y2, padding, rightPadding) ->
      if padding
        x1 = x1-padding
        x2 = if rightPadding then x2+rightPadding else x2+padding
        y1 = y1-padding
        y2 = y2+padding
      if @height/(y2-y1) < @width/(x2-x1)
        scale = @height/(y2-y1)
        # some geometry to ensure the viz is centered (there's probably a cleaner way...)
        translate = (-x1+(((y2-y1)*@width/@height-(x2-x1))/2))+", "+(-y1)
      else
        scale = @width/(x2-x1)
        translate = (-x1)+", "+(-y1+(((x2-x1)*@height/@width-(y2-y1))/2))
      scale = Math.min(scale, 2)
      @viz.transition().attr("transform", "scale("+scale+")translate("+translate+")")
      @viz.selectAll("text").style("font", 10/scale+"px sans-serif")
                            .style("stroke-width", 0.3/scale+"px")
      @viz.selectAll(".shadow").style("stroke-width", 3/scale+"px")


