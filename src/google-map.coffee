Handlebars  = require 'handlebars'
querystring = require 'querystring'

module.exports = ->
  marker = @address.street1
  marker += " #{@address.street2}" if @address.street2
  marker += " #{@address.city}"
  marker += " #{@address.state}"
  marker += " #{@address.zip}" if @address.zip

  query = querystring.stringify
    key: 'AIzaSyCCqr8B1aob1jObVpkEHyg0aLFTd3t337k'
    markers: marker
    scale: 2
    size: '350x300'
    zoom: 8

  new Handlebars.SafeString """
    <img class="google-map" src="https://maps.googleapis.com/maps/api/staticmap?#{query}">
  """
