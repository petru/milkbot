require 'open-uri'
require 'uri'

class Liveleak
  include Cinch::Plugin

  match /.*liveleak.com\/view\?i=(.{3}_\d{10}).*/i, prefix: ""

  def execute(m,id)
    r = open(URI.escape("http://www.liveleak.com/view?i=#{id}&safe_mode=off"))
    contents = r.read
    title = contents.scan(/span.*section_title.*10px\">(.+?)<.*/ix)[0][0]
    m.reply "Title: #{title}"

  end
end