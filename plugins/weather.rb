require 'barometer'

class Weather
    include Cinch::Plugin
    match /weather (.*)$/i, prefix: ".", method: :weather
    
    def weather(m,query)
        barometer = Barometer.new(query)
        w = barometer.measure
        m.reply "Weather for #{query}: #{w.current.condition}, #{w.current.temperature.c}"
    end
end