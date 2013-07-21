class Quote
  include Cinch::Plugin

  match /^q$/i, method: :random_quote, prefix: ""

  def random_quote(m)
    f = open('quote.txt')
    r = f.read.split("\n")
    m.reply "#{r.shuffle[0]}"
  end
end