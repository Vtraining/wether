require 'net/http'
require 'uri'
require 'rexml/document'
require_relative 'lib/meteo_data'
URL = "https://xml.meteoservice.ru/export/gismeteo/point/35.xml".freeze

response = Net::HTTP.get_response(URI.parse(URL))

doc = REXML::Document.new(response.body)

city_name = URI.decode_www_form(doc.root.elements['REPORT/TOWN'].attributes['sname'])

forecast_nodes = doc.root.elements['REPORT/TOWN'].elements.to_a

puts city_name
puts

forecast_nodes.each do |node|
  puts MeteoData.from_xml(node)
  puts
end
