Handlebars = require 'handlebars'

module.exports = ->
  url = "https://www.google.com/maps/embed/v1/place"
  key = 'AIzaSyD4GWPKpSy_j68tCxxTjIhtxURnRwmdCdw'
  zoom = 10
  q = @address.street1
  q += " #{@address.street2}" if @address.street2
  q += " #{@address.city}"
  q += " #{@address.state}"
  q += " #{@address.zip}" if @address.zip
  q = encodeURIComponent(q)

  new Handlebars.SafeString """
    <iframe frameborder="0" class="google-map" src="#{url}?q=#{q}&key=#{key}&zoom=#{zoom}"></iframe>
  """
