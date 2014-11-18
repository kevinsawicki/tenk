Handlebars = require 'handlebars'

module.exports = ->
  url = "https://maps.googleapis.com/maps/api/staticmap"
  key = 'AIzaSyCCqr8B1aob1jObVpkEHyg0aLFTd3t337k'
  zoom = 8
  q = @address.street1
  q += " #{@address.street2}" if @address.street2
  q += " #{@address.city}"
  q += " #{@address.state}"
  q += " #{@address.zip}" if @address.zip
  q = encodeURIComponent(q)

  new Handlebars.SafeString """
    <img class="google-map" src="https://maps.googleapis.com/maps/api/staticmap?markers=#{q}&zoom=#{zoom}&size=350x300&scale=2&key=#{key}">
  """
