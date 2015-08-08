require 'open-uri'
require 'uri'

class Tv
  include Cinch::Plugin

  match /tv (.*)/

  def execute(m,query)
    r = open(URI.escape("http://services.tvrage.com/tools/quickinfo.php?show=#{query}"))
    contents = r.read
    contents = Hash[contents.scan(/(.+?)@(.+)/)]
    m.reply "Name: #{contents['Show Name']} | Next episode: #{contents['Next Episode'].gsub('^',' ')}"
  end
end