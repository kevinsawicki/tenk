moneyGraph = require './money-graph'

module.exports = ->
  moneyGraph
    data: @profit
    cssClass: 'profit'
