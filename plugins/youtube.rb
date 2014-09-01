require 'youtube_it'

class Youtube
  include Cinch::Plugin

  match /.*(?:youtube(?:-nocookie)?\.com\/(?:[^\/\n\s]+\/\S+\/|(?:v|e(?:mbed)?)\/|\S*?[?&]v=)|youtu\.be\/)([a-zA-Z0-9_-]{11}).*/ix, prefix:""

  def execute(m,id)
    client = YouTubeIt::Client.new
    video = client.video_by(id)
    m.reply "Title: #{video.title} Uploaded at: #{video.uploaded_at} Views: #{video.view_count} Duration: #{video.duration}"
  end
end
