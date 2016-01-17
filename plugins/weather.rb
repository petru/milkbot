require 'open-uri'
require 'json'

class Weather
  include Cinch::Plugin
  match /weather (.*)$/i, prefix: ".", method: :weather
  
  def k_to_c(temp)
    return temp - 273.15
  end
  
  def weather(m,query)
    link = open(URI.escape("http://api.openweathermap.org/data/2.5/weather?q=#{query}&appid=2de143494c0b295cca9337e1e96b00e0"))
    current = link.read
    current = JSON.parse(current)
    location = current['name']
    current_condition = current['weather'].collect { |i| i['description'] }.join(', ')
    temperature = k_to_c(current['main']['temp']).to_i
    
    m.reply "#{Format(:bold,'Location:')} #{location} #{Format(:bold,'Current condition:')} #{current_condition}, #{temperature}C"
  end
end