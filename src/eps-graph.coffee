moneyGraph = require './money-graph'

module.exports = ->
  moneyGraph
    data: @earningsPerShare
    cssClass: 'eps'
