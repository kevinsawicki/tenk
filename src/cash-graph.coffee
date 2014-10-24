moneyGraph = require './money-graph'

module.exports = ->
  moneyGraph
    data: @cash
    cssClass: 'cash'
