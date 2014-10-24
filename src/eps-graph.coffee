d3         = require 'd3'
Handlebars = require 'handlebars'
xmldom     = require 'xmldom'

module.exports = ->
  width = 960
  height = 480

  eps = []
  eps.push({year, eps: $}) for year, $ of @earningsPerShare

  x = d3.scale.ordinal().rangeRoundBands([0, width], .1)
  y = d3.scale.linear().range([height, 0])

  xAxis = d3.svg.axis().scale(x).orient("bottom")
  moneyFormat = d3.format('$s')
  yAxis = d3.svg.axis().scale(y).orient("right").ticks(10).tickFormat (amount) ->
    moneyFormat(amount).replace(/G/gi, 'B')

  svg = d3.select('body')
    .html('')
    .append('svg')
      .attr('viewBox', "0 0 #{width+40} #{height+20}")
    .append("g")

  x.domain(eps.map ({year}) -> year)
  y.domain([0, d3.max(eps, ({eps}) -> eps)])

  svg.append("g")
    .attr("class", "x axis")
    .attr("transform", "translate(0," + height + ")")
    .call(xAxis)

  svg.append("g")
    .attr("class", "y axis")
    .attr("transform", "translate(" + width + ",0)")
    .call(yAxis);

  svg.selectAll(".eps")
      .data(eps)
    .enter().append("rect")
      .attr("class", "bar eps")
      .attr("x", ({year}) -> x(year) )
      .attr("width", x.rangeBand())
      .attr("y", ({eps}) -> y(eps))
      .attr("height", ({eps}) -> height - y(eps))

  graph = d3.select('svg')
  graph.attr('xmlns', 'http://www.w3.org/2000/svg')
  serializer = new xmldom.XMLSerializer()
  new Handlebars.SafeString(serializer.serializeToString(graph[0][0]))
