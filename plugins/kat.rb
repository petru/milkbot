require 'open-uri'
require 'uri'

class Kat
  include Cinch::Plugin

  match /tv (.*) S?(\d{1,2})\DE?(\d{1,2})/i, prefix:".", method: :tv # .tv <showname> S<season>E<episode> OR .tv <showname> <season><episode>
  match /kat (.*)/i, prefix:".", method: :kat # .kat <anything>

  def tv(m,name,season,episode)
    season = "0" + season if season.length == 1
    episode = "0" + episode if episode.length == 1
    link = URI.escape("https://kat.cr/usearch/#{name} S#{season}E#{episode} 720p/?field=seeders&sorder=desc")
    m.reply "#{Format(:bold, "Link:")} #{link}"
    r = open(link)
    contents = r.read
    magnet = contents.scan(/href="(magnet\:\?.*)" class="/)    
    torrent = contents.scan(/<a data-download title="Download torrent file" href="(.*)" class=/)
    m.reply "#{Format(:bold, "Magnet:")} #{magnet[0][0]}"
    m.reply "#{Format(:bold, "Torrent:")} #{torrent[0][0]}"
  end

  def kat(m,query)
    link = URI.escape("https://kat.cr/usearch/#{query}/?field=seeders&sorder=desc")
    m.reply "#{Format(:bold, "Link:")} #{link}"
    r = open(link)
    contents = r.read
    magnet = contents.scan(/href="(magnet\:\?.*)" class="/)
    torrent = contents.scan(/<a data-download title="Download torrent file" href="(.*)" class=/)
    m.reply "#{Format(:bold, "Magnet:")} #{magnet[0][0]}"
    m.reply "#{Format(:bold, "Torrent:")} #{torrent[0][0]}"
  end
end