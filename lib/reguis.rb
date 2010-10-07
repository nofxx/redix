#!/usr/bin/env ruby
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__)))
require 'Qt4'
require 'redis'
App = Qt::Application.new(ARGV)

require 'reguis/logic'
require 'reguis/qtui'



module Reguis

  def self.boot!
    # window = Qt::Widget.new()
    # window.resize(200, 120)

    # quit = Qt::PushButton.new('Quit', window)
    # # quit.font = Qt::Font.new('Times', 18, Qt::Font::Bold)
    # quit.setGeometry(10, 40, 180, 40)
    # Qt::Object.connect(quit, SIGNAL('clicked()'), App, SLOT('quit()'))

    # window.show()
  #  about = KDE::AboutData.new("mainwindow", "MainWindow", KDE.ki18n(""), "0.1")
  #   KDE::CmdLineArgs.init(ARGV, about)
     a = App #.new
     u = Ui_MainWindow.new
     w = Qt::MainWindow.new
    u.setupUi(w)
    Logic.new.for(u)

     w.show
     a.exec

#    App.exec
  end


end

puts "Starting GUI"
Reguis.boot!
