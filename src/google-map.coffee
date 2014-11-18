Handlebars = require 'handlebars'

module.exports = ->
  url = "https://maps.googleapis.com/maps/api/staticmap"
  key = 'AIzaSyCCqr8B1aob1jObVpkEHyg0aLFTd3t337k'
  zoom = 8
  height = 300
  width = 350
  markers = @address.street1
  markers += " #{@address.street2}" if @address.street2
  markers += " #{@address.city}"
  markers += " #{@address.state}"
  markers += " #{@address.zip}" if @address.zip
  markers = encodeURIComponent(q)

  new Handlebars.SafeString """
    <img class="google-map" src="#{url}?markers=#{markers}&zoom=#{zoom}&size=#{width}x#{height}&scale=2&key=#{key}">
  """
