d3         = require 'd3'
Handlebars = require 'handlebars'
xmldom     = require 'xmldom'

module.exports = ({data, cssClass}) ->
  width = 450
  widthPadding = 50
  height = 300
  heightPadding = 50

  values = []
  values.push({year, value}) for year, value of data

  x = d3.scale.ordinal().rangeRoundBands([0, width], .1)
  y = d3.scale.linear().range([height, 0])

  xAxis = d3.svg.axis().scale(x).orient("bottom")
  moneyFormat = d3.format('$s')
  subOneMoneyFormat = d3.format('$g')
  yAxis = d3.svg.axis().scale(y).orient("right").ticks(10).tickFormat (amount) ->
    if -1 < amount < 1
      subOneMoneyFormat(amount)
    else
      moneyFormat(amount).replace(/G/gi, 'B')

  svg = d3.select('body')
    .html('')
    .append('svg')
      .attr('class', 'money-graph')
      .attr('viewBox', "0 0 #{width+widthPadding} #{height+heightPadding}")
    .append("g")

  x.domain(values.map ({year}) -> year)
  y.domain([0, d3.max(values, ({value}) -> value)])

  svg.append("g")
    .attr("class", "x axis")
    .attr("transform", "translate(0,#{height})")
    .call(xAxis)

  svg.append("g")
    .attr("class", "y axis")
    .attr("transform", "translate(#{width},0)")
    .call(yAxis);

  svg.selectAll(cssClass)
      .data(values)
    .enter().append("rect")
      .attr("class", "bar #{cssClass}")
      .attr("x", ({year}) -> x(year) )
      .attr("width", x.rangeBand())
      .attr("y", ({value}) -> y(value))
      .attr("height", ({value}) -> height - y(value))

  graph = d3.select('svg')
  graph.attr('xmlns', 'http://www.w3.org/2000/svg')
  serializer = new xmldom.XMLSerializer()
  new Handlebars.SafeString(serializer.serializeToString(graph[0][0]))
