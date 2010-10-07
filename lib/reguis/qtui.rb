=begin
** Form generated from reading ui file 'reguis.ui'
**
** Created: Thu Oct 7 07:29:58 2010
**      by: Qt User Interface Compiler version 4.7.0
**
** WARNING! All changes made in this file will be lost when recompiling ui file!
=end

#require 'korundum4'

class Ui_MainWindow
    attr_reader :actionNew
    attr_reader :actionOpen
    attr_reader :actionQuit
    attr_reader :actionChange
    attr_reader :actionReconnect
    attr_reader :centralwidget
    attr_reader :listWidget
    attr_reader :plainTextEdit
    attr_reader :tableView
    attr_reader :menubar
    attr_reader :menuFile
    attr_reader :menuDB
    attr_reader :statusbar

    def setupUi(mainWindow)
    if mainWindow.objectName.nil?
        mainWindow.objectName = "mainWindow"
    end
    mainWindow.resize(800, 600)
    @actionNew = Qt::Action.new(mainWindow)
    @actionNew.objectName = "actionNew"
    @actionOpen = Qt::Action.new(mainWindow)
    @actionOpen.objectName = "actionOpen"
    @actionQuit = Qt::Action.new(mainWindow)
    @actionQuit.objectName = "actionQuit"
    @actionChange = Qt::Action.new(mainWindow)
    @actionChange.objectName = "actionChange"
    @actionReconnect = Qt::Action.new(mainWindow)
    @actionReconnect.objectName = "actionReconnect"
    @centralwidget = Qt::Widget.new(mainWindow)
    @centralwidget.objectName = "centralwidget"
    @listWidget = Qt::ListWidget.new(@centralwidget)
    @listWidget.objectName = "listWidget"
    @listWidget.geometry = Qt::Rect.new(5, 11, 241, 531)
    @plainTextEdit = Qt::PlainTextEdit.new(@centralwidget)
    @plainTextEdit.objectName = "plainTextEdit"
    @plainTextEdit.geometry = Qt::Rect.new(260, 510, 531, 31)

    @tableView = Qt::TableView.new(@centralwidget)
    @tableView.objectName = "tableView"
      @tableView.geometry = Qt::Rect.new(260, 10, 531, 491)

    mainWindow.centralWidget = @centralwidget
    @menubar = Qt::MenuBar.new(mainWindow)
    @menubar.objectName = "menubar"
    @menubar.geometry = Qt::Rect.new(0, 0, 800, 26)
    @menuFile = Qt::Menu.new(@menubar)
    @menuFile.objectName = "menuFile"
    @menuDB = Qt::Menu.new(@menubar)
    @menuDB.objectName = "menuDB"
    mainWindow.setMenuBar(@menubar)
    @statusbar = Qt::StatusBar.new(mainWindow)
    @statusbar.objectName = "statusbar"
    mainWindow.statusBar = @statusbar

    @menubar.addAction(@menuFile.menuAction())
    @menubar.addAction(@menuDB.menuAction())
    @menuFile.addAction(@actionNew)
    @menuFile.addAction(@actionOpen)
    @menuFile.addSeparator()
    @menuFile.addAction(@actionQuit)
    @menuDB.addAction(@actionChange)
    @menuDB.addAction(@actionReconnect)
    @menuDB.addSeparator()

    retranslateUi(mainWindow)

    Qt::MetaObject.connectSlotsByName(mainWindow)
    end # setupUi

    def setup_ui(mainWindow)
        setupUi(mainWindow)
    end

    def retranslateUi(mainWindow)
    mainWindow.windowTitle = Qt::Application.translate("MainWindow", "MainWindow", nil, Qt::Application::UnicodeUTF8)
    @actionNew.text = Qt::Application.translate("MainWindow", "New", nil, Qt::Application::UnicodeUTF8)
    @actionOpen.text = Qt::Application.translate("MainWindow", "Open", nil, Qt::Application::UnicodeUTF8)
    @actionQuit.text = Qt::Application.translate("MainWindow", "Quit", nil, Qt::Application::UnicodeUTF8)
    @actionChange.text = Qt::Application.translate("MainWindow", "Change", nil, Qt::Application::UnicodeUTF8)
    @actionReconnect.text = Qt::Application.translate("MainWindow", "Reconnect", nil, Qt::Application::UnicodeUTF8)
    @menuFile.title = Qt::Application.translate("MainWindow", "File", nil, Qt::Application::UnicodeUTF8)
    @menuDB.title = Qt::Application.translate("MainWindow", "DB", nil, Qt::Application::UnicodeUTF8)
    end # retranslateUi

    def retranslate_ui(mainWindow)
        retranslateUi(mainWindow)
    end

end

module Ui
    class MainWindow < Ui_MainWindow
    end
end  # module Ui

if $0 == __FILE__
    about = KDE::AboutData.new("mainwindow", "MainWindow", KDE.ki18n(""), "0.1")
    KDE::CmdLineArgs.init(ARGV, about)
    a = KDE::Application.new
    u = Ui_MainWindow.new
    w = Qt::MainWindow.new
    u.setupUi(w)
    a.topWidget = w
    w.show
    a.exec
end
