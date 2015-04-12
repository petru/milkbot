# encoding: utf-8
require 'cinch'
require 'rubygems'

# plugins
require './plugins/youtube'
require './plugins/tv'
require './plugins/quote'
require './plugins/liveleak'
require './plugins/monitor'

bot = Cinch::Bot.new do 
  configure do |c|
    c.server = "irc.carnique.nl"
    c.channels = ["#ankeborg"]
    c.nick = "laptic"
    c.realname = "mILKbot 0.2"
    c.plugins.plugins = [Youtube, Tv, Quote, Liveleak, Monitor]
  end

  on :message, "test" do |m|
    m.reply "Test passed, #{m.user.nick}!"
  end

  on :message, "die" do |m|
    exit
  end
end
bot.start
