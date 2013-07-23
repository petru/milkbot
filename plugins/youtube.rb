require 'youtube_it'

class Youtube
  include Cinch::Plugin

  match /.*(?:https?:\/\/)?(?:www\.)?youtu(?:\.be|be\.com)\/(?:watch\?v=)?(\S{10,}).*/ix, prefix:""

  def execute(m,id)
    client = YouTubeIt::Client.new
    video = client.video_by(id)
    m.reply "Title: #{video.title} Uploaded at: #{video.uploaded_at} Views: #{video.view_count} Duration: #{video.duration}"
  end
end