class Quote
  include Cinch::Plugin

  @@file = 'quote.txt'

  # common methods
  def db
    if File.exists?(@@file)
      f = open(@@file, "r:UTF-8")
      quotes = f.read.split("\n")
      f.close
      return quotes
    else return []
    end
  end

  match /^!?(?:quote|q)(:?\s?(\d*)|)$/i, method: :quote, prefix: ""
  match /^!?(?:findquote|fq)\s?(.+)$/i, method: :find_quote, prefix: ""
  match /(?:addquote|aq)\s(.*)$/i, method: :add_quote
  match /(?:delquote|dq)\s?(\d*)$/i, method: :delete_quote


  # q, !q or !quote [id]
  def quote(m,id)
    quotes = self.db
    quote = id.empty? ? Random.rand(quotes.size) : id.to_i
    if (0...quotes.size).include? quote
      m.reply "[#{quote}/#{quotes.size-1}] #{quotes[quote]}"
    else
      m.reply "No such quote. Valid range: 0-#{quotes.size-1}"
    end
  end

  # !fq or !findquote <query>
  def find_quote(m,query)
    quotes = self.db.shuffle
    quotes.select! { |q| q.downcase.include? query.downcase }
    if quotes.size > 1
      (quotes.size>3?3:quotes.size).times { |x| m.reply "[#{x+1}/#{quotes.size}] #{quotes[x]}"}
    else
      m.reply quotes.shuffle[0]
    end
  end

  # !aq  or !addquote <text>
  def add_quote(m,text)
    file = File.new(@@file, "a:UTF-8")
    file.write(text+"\n")
    file.close
    m.reply "Quote added."
  end

  # !dq or !delquote <id>
  def delete_quote(m,id)
    quotes = self.db
    id = id.to_i

    unless quotes.delete_at(id).nil?
      m.reply "Quote #{id} deleted."
    else
      m.reply "Quote #{id} not found."
    end

    file = File.new(@@file, "w:UTF-8")
    file.write(quotes.join("\n")+"\n")
    file.close
  end
end