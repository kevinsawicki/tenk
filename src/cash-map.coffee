d3         = require 'd3'
Handlebars = require 'handlebars'
topojson   = require 'topojson'
us         = require '../maps/us.json'
xmldom     = require 'xmldom'

module.exports = ->
  width = 960
  widthPadding = 50
  height = 500
  heightPadding = 50

  projection = d3.geo.albersUsa().scale(1000).translate([width / 2, height / 2]);

  path = d3.geo.path().projection(projection)

  svg = d3.select('body')
    .html('')
    .append('svg')
      .attr('viewBox', "0 0 #{width+widthPadding} #{height+heightPadding}")

  svg.insert("path", ".graticule")
      .datum(topojson.feature(us, us.objects.land))
      .attr("class", "land")
      .attr("d", path);

  svg.insert("path", ".graticule")
      .datum(topojson.mesh(us, us.objects.counties, (a, b) -> a isnt b and !(a.id / 1000 ^ b.id / 1000)))
      .attr("class", "county-boundary")
      .attr("d", path)

  svg.insert("path", ".graticule")
      .datum(topojson.mesh(us, us.objects.states, (a, b) -> a isnt b))
      .attr("class", "state-boundary")
      .attr("d", path)

  graph = d3.select('svg')
  graph.attr('xmlns', 'http://www.w3.org/2000/svg')
  serializer = new xmldom.XMLSerializer()
  new Handlebars.SafeString(serializer.serializeToString(graph[0][0]))
