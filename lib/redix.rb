#!/usr/bin/env ruby
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__)))
begin
  begin
    require 'Qt4'
  rescue LoadError
    require 'korundum4'
  end
rescue LoadError
  puts "QT Bindings not found, try `gem install qtbindings`."
  exit
end
require 'redis'
# APP
require 'redix/logic'
require 'redix/qtui'


module Redix

  App = Qt::Application.new(ARGV)

  if ARGV[0]
    REDIS_HOST, REDIS_PORT = ARGV[0] =~ /:/ ? ARGV[0].split(":") : [ARGV[0], 6379]
  else
    REDIS_HOST, REDIS_PORT = ['localhost', 6379]
  end

  def self.boot!
    u = Ui_MainWindow.new
    # w = Qt::MainWindow.new
    u.setupUi
    Logic.for(u)
    u.show
    App.exec
  end


end

puts "Starting GUI"
Redix.boot!
