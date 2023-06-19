require 'net/http'
require 'uri'
require 'rexml/document'

URL = "https://xml.meteoservice.ru/export/gismeteo/point/35.xml".freeze

response = Net::HTTP.get_response(URL.parse(URL))

doc = REXML::Document.new(response.body)

city_name = URI.uniscape(doc.root.elements['REPORT/TOWN'].attributes['sname'])

forecast_nodes = doc.root.elements['REPORT/TOWN']

current_forecast = doc.root.elements['REPORT/TOWN'].elements.to_a[0]
puts current_forecast.attributes['day']
#a = current_forecast.root.elements.to_a
#puts a.attributes['day']
min_temp = current_forecast.elements['TEMPERATURE'].attributes['min']
max_temp = current_forecast.elements['TEMPERATURE'].attributes['max']

max_wind = current_forecast.elements['WIND'].attributes['max']

cloud_index = current_forecast.elements['PHENOMENA'].attributes['cloudiness'].to_i
clouds = CLOUDINESS[cloud_index]

#day = current_forecast.elements['FORECAST'].tod

puts city_name
#puts day
puts "Temperature: from #{min_temp} to #{max_temp}"
puts "Wind is: #{max_wind} m/s"
puts clouds


                        
