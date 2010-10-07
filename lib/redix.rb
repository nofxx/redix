#!/usr/bin/env ruby
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__)))
require 'Qt4'
require 'redis'
# APP
require 'redix/logic'
require 'redix/qtui'


module Redix

  App = Qt::Application.new(ARGV)

  def self.boot!
    u = Ui_MainWindow.new
    w = Qt::MainWindow.new
    u.setupUi(w)
    Logic.for(u)
    w.show
    App.exec
  end


end

puts "Starting GUI"
Redix.boot!
