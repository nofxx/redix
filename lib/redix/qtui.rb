#
#
#  Just to kickstart, no more designer hehe
#
#
#
class Ui_MainWindow
  attr_reader :actionNew
  attr_reader :actionOpen
  attr_reader :actionQuit
  attr_reader :actionReconnect
  attr_reader :actionConnect
  attr_reader :actionHomepage
  attr_reader :actionAbout
  attr_reader :centralwidget
  attr_reader :listWidget
  attr_reader :tableView
  attr_reader :lineEdit
  attr_reader :textBrowser
  attr_reader :menubar
  attr_reader :menuFile
  attr_reader :menuDB
  attr_reader :menuChange
  attr_reader :menuHelp
  attr_reader :statusbar
  attr_reader :mainWindow

  def setupUi(mainWindow)
    if mainWindow.objectName.nil?
      mainWindow.objectName = "mainWindow"
    end
    @mainWindow = mainWindow
    mainWindow.resize(799, 606)
    @actionNew = Qt::Action.new(mainWindow)
    @actionNew.objectName = "actionNew"
    @actionOpen = Qt::Action.new(mainWindow)
    @actionOpen.objectName = "actionOpen"
    @actionQuit = Qt::Action.new(mainWindow)
    @actionQuit.objectName = "actionQuit"

    @actionConnect = Qt::Action.new(mainWindow)
    @actionConnect.objectName = "actionConnect"
    @actionReconnect = Qt::Action.new(mainWindow)
    @actionReconnect.objectName = "actionReconnect"

    @actionHomepage = Qt::Action.new(mainWindow)
    @actionHomepage.objectName = "actionHomepage"
    @actionAbout = Qt::Action.new(mainWindow)
    @actionAbout.objectName = "actionAbout"

    @centralwidget = Qt::Widget.new(mainWindow)
    @centralwidget.objectName = "centralwidget"
    @listWidget = Qt::ListWidget.new(@centralwidget)
    @listWidget.objectName = "listWidget"
    @listWidget.geometry = Qt::Rect.new(5, 11, 241, 531)
    @tableView = Qt::TableView.new(@centralwidget)
    @tableView.objectName = "tableView"
    @tableView.geometry = Qt::Rect.new(260, 10, 531, 441)
    @tableView.gridStyle = Qt::DotLine
    @lineEdit = Qt::LineEdit.new(@centralwidget)
    @lineEdit.objectName = "lineEdit"
    @lineEdit.geometry = Qt::Rect.new(260, 510, 531, 31)
    @textBrowser = Qt::TextBrowser.new(@centralwidget)
    @textBrowser.objectName = "textBrowser"
    @textBrowser.geometry = Qt::Rect.new(260, 460, 531, 41)
    mainWindow.centralWidget = @centralwidget
    @menubar = Qt::MenuBar.new(mainWindow)
    @menubar.objectName = "menubar"
    @menubar.geometry = Qt::Rect.new(0, 0, 799, 26)
    @menuFile = Qt::Menu.new(@menubar)
    @menuFile.objectName = "menuFile"
    @menuDB = Qt::Menu.new(@menubar)
    @menuDB.objectName = "menuDB"
    @menuChange = Qt::Menu.new(@menuDB)
    @menuChange.objectName = "menuChange"
    @menuHelp = Qt::Menu.new(@menubar)
    @menuHelp.objectName = "menuHelp"
    mainWindow.setMenuBar(@menubar)
    @statusbar = Qt::StatusBar.new(mainWindow)
    @statusbar.objectName = "statusbar"
    mainWindow.statusBar = @statusbar

    @menubar.addAction(@menuFile.menuAction())
    @menubar.addAction(@menuDB.menuAction())
    @menubar.addAction(@menuHelp.menuAction())
    @menuFile.addAction(@actionNew)
    @menuFile.addAction(@actionOpen)
    @menuFile.addSeparator()
    @menuFile.addAction(@actionQuit)
    @menuDB.addAction(@menuChange.menuAction())
    @menuDB.addAction(@actionConnect)
    @menuDB.addAction(@actionReconnect)
    @menuDB.addSeparator()
    @menuHelp.addAction(@actionHomepage)
    @menuHelp.addSeparator()
    @menuHelp.addAction(@actionAbout)

    retranslateUi(mainWindow)

    Qt::MetaObject.connectSlotsByName(mainWindow)
  end # setupUi

  def setup_ui(mainWindow)
    setupUi(mainWindow)
  end

  def retranslateUi(mainWindow)
    mainWindow.windowTitle = Qt::Application.translate("MainWindow", "Redix", nil, Qt::Application::UnicodeUTF8)
    @actionNew.text = Qt::Application.translate("MainWindow", "New", nil, Qt::Application::UnicodeUTF8)
    @actionOpen.text = Qt::Application.translate("MainWindow", "Open", nil, Qt::Application::UnicodeUTF8)
    @actionQuit.text = Qt::Application.translate("MainWindow", "Quit", nil, Qt::Application::UnicodeUTF8)
    @actionConnect.text = Qt::Application.translate("MainWindow", "Connect", nil, Qt::Application::UnicodeUTF8)
    @actionReconnect.text = Qt::Application.translate("MainWindow", "Reconnect", nil, Qt::Application::UnicodeUTF8)
    @actionHomepage.text = Qt::Application.translate("MainWindow", "Homepage", nil, Qt::Application::UnicodeUTF8)
    @actionAbout.text = Qt::Application.translate("MainWindow", "About", nil, Qt::Application::UnicodeUTF8)
    @lineEdit.toolTip = Qt::Application.translate("MainWindow", "Run commands", nil, Qt::Application::UnicodeUTF8)
    @menuFile.title = Qt::Application.translate("MainWindow", "File", nil, Qt::Application::UnicodeUTF8)
    @menuDB.title = Qt::Application.translate("MainWindow", "DB", nil, Qt::Application::UnicodeUTF8)
    @menuChange.title = Qt::Application.translate("MainWindow", "Change", nil, Qt::Application::UnicodeUTF8)
    @menuHelp.title = Qt::Application.translate("MainWindow", "Help", nil, Qt::Application::UnicodeUTF8)
  end # retranslateUi

  def retranslate_ui(mainWindow)
    retranslateUi(mainWindow)
  end

end

class ConnectDialog < Qt::Dialog
  attr_reader :data
  attr_reader :buttonBox
  attr_reader :lineEdit


  def updateData(new)
    @data = new
  end
  def setupUi(dialog = self)

    @buttonBox = Qt::DialogButtonBox.new(dialog)
    @buttonBox.objectName = "buttonBox"
    @buttonBox.geometry = Qt::Rect.new(30, 60, 341, 32)
    @buttonBox.orientation = Qt::Horizontal
    @buttonBox.standardButtons = Qt::DialogButtonBox::Cancel|Qt::DialogButtonBox::Ok
    @lineEdit = Qt::LineEdit.new(dialog)
    @lineEdit.objectName = "lineEdit"
    @lineEdit.geometry = Qt::Rect.new(70, 20, 311, 22)
    @label = Qt::Label.new(dialog)
    @label.objectName = "label"
    @label.geometry = Qt::Rect.new(20, 23, 61, 21)

    retranslateUi(dialog)
    Qt::Object.connect(@buttonBox, SIGNAL('accepted()'), dialog, SLOT('accept()'))
    Qt::Object.connect(@buttonBox, SIGNAL('rejected()'), dialog, SLOT('reject()'))

    Qt::MetaObject.connectSlotsByName(dialog)
  end # setupUi

  def setup_ui(dialog)
    setupUi(dialog)
  end

  def retranslateUi(dialog)
    dialog.windowTitle = Qt::Application.translate("Dialog", "Connect", nil, Qt::Application::UnicodeUTF8)
    @label.text = Qt::Application.translate("Dialog", "redis://", nil, Qt::Application::UnicodeUTF8)
  end # retranslateUi

  def retranslate_ui(dialog)
    retranslateUi(dialog)
  end




  # if dialog.objectName.nil?
  #   dialog.objectName = "dialog"
  # end
  # @dialog = dialog
  # dialog.resize(400, 100)
  # @lineEdit = Qt::LineEdit.new(@centralwidget)
  # @lineEdit.objectName = "lineEdit"
  # @lineEdit.geometry = Qt::Rect.new(260, 510, 531, 31)

end


class AboutDialog < Qt::Dialog
  attr_reader :data
  attr_reader :title
  attr_reader :text


  def updateData(new)
    @data = new
  end
  def setupUi(dialog = self)

    @title = Qt::Label.new(dialog)
    @title.objectName = "title"
    @title.geometry = Qt::Rect.new(20, 23, 61, 21)

    retranslateUi(dialog)
    Qt::MetaObject.connectSlotsByName(dialog)
  end # setupUi

  def setup_ui(dialog)
    setupUi(dialog)
  end

  def retranslateUi(dialog)
    dialog.windowTitle = Qt::Application.translate("Dialog", "About", nil, Qt::Application::UnicodeUTF8)
  end # retranslateUi

  def retranslate_ui(dialog)
    retranslateUi(dialog)
  end

end

module Ui
  class MainWindow < Ui_MainWindow
  end
end  # module Ui
