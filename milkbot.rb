require 'cinch'
require 'rubygems'

# plugins
require './plugins/youtube'
require './plugins/tv'
require './plugins/quote'
require './plugins/liveleak'

bot = Cinch::Bot.new do 
  configure do |c|
    c.server = "chat.itarea.net"
    c.channels = ["#rendez-vous"]
    c.nick = "milkbot"
    c.realname = "mILKbot 0.1 beta!"
    c.plugins.plugins = [Youtube, Tv, Quote, Liveleak]
  end

  on :message, "test" do |m|
    m.reply "Test passed, #{m.user.nick}!"
  end

  on :message, "die" do |m|
    exit
  end
end
bot.start