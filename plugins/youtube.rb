require 'open-uri'
require 'uri'

class Youtube
  include Cinch::Plugin

  match /.*(?:youtube(?:-nocookie)?\.com\/(?:[^\/\n\s]+\/\S+\/|(?:v|e(?:mbed)?)\/|\S*?[?&]v=)|youtu\.be\/)([a-zA-Z0-9_-]{11}).*/ix, prefix:""

  def execute(m,id)
    r = open(URI.escape("https://youtube.com/watch?v=#{id}"))
    contents = r.read
    title = contents.scan(/<title>(.*) - YouTube<\/title>/)
    views = contents.scan(/<div class="watch-view-count">(.*)<\/div>/)
    duration = contents.scan(/<meta itemprop="duration" content="PT(\d*)M(.\d*)S">/)
    date = contents.scan(/<meta itemprop="datePublished" content="(\d{4}-\d{2}-\d{2})">/)
    author = contents.scan(/<span itemprop="author".*\s*<link itemprop="url" href=".*www\.youtube.com\/user\/(.*)".\s*<\/span>/)
    m.reply "Title: #{Format(:bold, title[0][0])} | Duration: #{Format(:bold, duration[0][0])}m#{Format(:bold, duration[0][1])}s | Views: #{Format(:bold, views[0][0])} | Published: #{Format(:bold, date[0][0])} | Author: #{Format(:bold, author[0][0])}"
  end
end
