class Monitor
  include Cinch::Plugin
  
  @@idents = %w(enter idents here)
  @@storage = 'monitor.txt'
  
  listen_to :catchall
  def listen(m)
    ident = m.user.user.delete "~"
    if @@idents.include? ident
      # we found what we wanted, write timestamped m.raw to the storage file
      File.open(@@storage, 'a:UTF-8') { |file| file.write("#{m.time} #{m.raw}\n") }
    end
  end
end