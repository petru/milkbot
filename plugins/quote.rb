class Quote
  include Cinch::Plugin
  @@file = 'quote.txt'
  @@last_quote = ""

  # common methods
  def db
    f = open(@@file)
    quotes = f.read.split("\n")
    f.close
    return quotes
  end

  match /^!?(?:quote|q)(:?\s?(\d*)|)$/i, method: :quote, prefix: ""
  match /^!?(?:findquote|fq)\s?(.*)$/i, method: :find_quote, prefix: ""
  match /(?:addquote|aq)\s(.*)$/i, method: :add_quote


  # q, !q or !quote [id]
  def quote(m,id)
    quotes = self.db
    quote = id.empty? ? Random.rand(quotes.size-1) : id.to_i
    if quotes[quote]
      m.reply "[#{quote}/#{quotes.size-1}] #{quotes[quote]}"
    else
      m.reply "No such quote. Valid range: 0-#{quotes.size-1}"
    end
  end

  # !fq or !findquote <query>
  def find_quote(m,query)
    quotes = self.db
    quotes.select! { |q| q.include? query }
    if quotes.size > 1
      3.times { |x| m.reply "[#{x+1}/#{quotes.size}] #{quotes[x]}"}
    else
      m.reply quotes[0]
    end
  end

  # !aq  or !addquote <text>
  def add_quote(m,text)
    file = File.new(@@file, "a")
    file.write("\n"+text)
    file.close
    m.reply "Quote added: #{text}"
  end

  # !dq or !delquote <id>

end