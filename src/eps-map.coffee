d3         = require 'd3'
Handlebars = require 'handlebars'
topojson   = require 'topojson'
us         = require '../maps/us.json'
stateCodes = require '../maps/state-codes.json'
xmldom     = require 'xmldom'

module.exports = ->
  width = 960
  height = 500

  projection = d3.geo.albersUsa()
    .scale(1000).translate([width / 2, height / 2])

  path = d3.geo.path().projection(projection)

  svg = d3.select('body')
    .html('')
    .append('svg')
      .attr('class', 'map-graph cash-graph')
      .attr('viewBox', "0 0 #{width} #{height}")

  states = {}
  @states.forEach (state) -> states[state.state] = state

  svg.append('g')
      .attr('class', 'states')
    .selectAll('path')
      .data(topojson.feature(us, us.objects.states).features)
    .enter().append('path')
      .attr 'class', ({id}) =>
        state = stateCodes[id]
        eps = (states[state]?.earningsPerShare ? 0) / (states[state]?.companies ? 1)
        if eps > 5
          'state eps-five'
        else if eps > 2
          'state eps-two'
        else if eps > 1
          'state eps-one'
        else if eps > 0
          'state eps'
        else if eps < -5
          'state eps-loss-five'
        else if eps < -2
          'state eps-loss-two'
        else if eps < -1
          'state eps-loss-one'
        else if eps < 0
          'state eps-loss'
        else
          'state'
      .attr('d', path)

  graph = d3.select('svg')
  graph.attr('xmlns', 'http://www.w3.org/2000/svg')
  serializer = new xmldom.XMLSerializer()
  new Handlebars.SafeString(serializer.serializeToString(graph[0][0]))
