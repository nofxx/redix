#
#
#  Just to kickstart, no more designer hehe
#
#
#
class Ui_MainWindow < Qt::MainWindow
  attr_reader :actionNew, :actionOpen, :actionQuit, :actionReconnect, :actionConnect
  attr_reader :actionHomepage, :actionAbout, :centralwidget, :listWidget
  attr_reader :tableView, :lineEdit, :textBrowser
  attr_reader :menubar, :menuKey, :menuDB, :menuChange, :menuHelp
  attr_reader :statusbar, :mainWindow
  KEYS = (0..9)

  slots :reload, :help, :connect, :new_key
  eval(("slots " + (KEYS.map { |i| ":connect#{i}" }.join ", ")))

  def setupUi #(self)
    if self.objectName.nil?
      self.objectName = "mainWindow"
    end
    @mainWindow = self
    self.resize(799, 606)
    @actionNew = Qt::Action.new(self)
    @actionNew.objectName = "actionNew"
    @actionInfo = Qt::Action.new(self)
    @actionInfo.objectName = "actionInfo"
    @actionOpen = Qt::Action.new(self)
    @actionOpen.objectName = "actionOpen"
    @actionQuit = Qt::Action.new(self)
    @actionQuit.objectName = "actionQuit"

    @actionConnect = Qt::Action.new(self)
    @actionConnect.objectName = "actionConnect"
    @actionReconnect = Qt::Action.new(self)
    @actionReconnect.objectName = "actionReconnect"

    @actionHomepage = Qt::Action.new(self)
    @actionHomepage.objectName = "actionHomepage"
    @actionAbout = Qt::Action.new(self)
    @actionAbout.objectName = "actionAbout"

    @centralwidget = Qt::Widget.new(self)
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
    self.centralWidget = @centralwidget

    @menubar = Qt::MenuBar.new(self)
    @menubar.objectName = "menubar"
    @menubar.geometry = Qt::Rect.new(0, 0, 799, 26)
    @menuKey = Qt::Menu.new(@menubar)
    @menuKey.objectName = "menuKey"
    @menuDB = Qt::Menu.new(@menubar)
    @menuDB.objectName = "menuDB"
    @menuChange = Qt::Menu.new(@menuDB)
    @menuChange.objectName = "menuChange"
    @menuHelp = Qt::Menu.new(@menubar)
    @menuHelp.objectName = "menuHelp"
    self.setMenuBar(@menubar)
    @statusbar = Qt::StatusBar.new(self)
    @statusbar.objectName = "statusbar"
    self.statusBar = @statusbar

    @menubar.addAction(@menuDB.menuAction())
    @menubar.addAction(@menuKey.menuAction())
    @menubar.addAction(@menuHelp.menuAction())
    @menuDB.addAction(@actionOpen)
    @menuDB.addAction(@menuChange.menuAction())
    @menuDB.addAction(@actionConnect)
    @menuDB.addAction(@actionReconnect)
    @menuDB.addSeparator()
    @menuDB.addAction(@actionQuit)
    @menuKey.addAction(@actionNew)
    @menuKey.addAction(@actionInfo)
    @menuKey.addSeparator()
    @menuHelp.addAction(@actionHomepage)
    @menuHelp.addSeparator()
    @menuHelp.addAction(@actionAbout)


    retranslateUi

    # 0-9 Keys Shortcuts
    KEYS.each { |k| Qt::Shortcut.new(Qt::KeySequence.new(eval("Qt::Key_#{k}").to_i), self, SLOT("connect#{k}()")) }

    Qt::Shortcut.new(Qt::KeySequence.new(Qt::Key_C.to_i), self, SLOT('connect()'))
    Qt::Shortcut.new(Qt::KeySequence.new(Qt::Key_N.to_i), self, SLOT('new_key()'))
    Qt::Shortcut.new(Qt::KeySequence.new(Qt::Key_F1.to_i), self, SLOT('help()'))
    Qt::Shortcut.new(Qt::KeySequence.new(Qt::Key_F2.to_i), self, SLOT('new_key()'))
    Qt::Shortcut.new(Qt::KeySequence.new(Qt::Key_F5.to_i), self, SLOT('reload()'))

    Qt::MetaObject.connectSlotsByName(self)
  end # setupUi

  def connect(db = nil)
    Redix::Logic.connect
  end

  def new_key
    Redix::Logic.new_key
  end

  def method_missing(*args)
    if args.join =~ /^connect/
      Redix::Logic.reconnect(args.join.scan(/\d/)[0].to_i)
    else
      super
    end
  end

  def reload
    Redix::Logic.reconnect
  end

  def help
    Redix::Logic.help
  end

  def setup_ui
    setupUi
  end

  def retranslateUi
    self.windowTitle = Qt::Application.translate("MainWindow", "Redix", nil, Qt::Application::UnicodeUTF8)
    @actionNew.text = Qt::Application.translate("MainWindow", "New", nil, Qt::Application::UnicodeUTF8)
    @actionInfo.text = Qt::Application.translate("MainWindow", "Info", nil, Qt::Application::UnicodeUTF8)
    @actionOpen.text = Qt::Application.translate("MainWindow", "Open", nil, Qt::Application::UnicodeUTF8)
    @actionQuit.text = Qt::Application.translate("MainWindow", "Quit", nil, Qt::Application::UnicodeUTF8)
    @actionConnect.text = Qt::Application.translate("MainWindow", "Connect", nil, Qt::Application::UnicodeUTF8)
    @actionReconnect.text = Qt::Application.translate("MainWindow", "Reconnect", nil, Qt::Application::UnicodeUTF8)
    @actionHomepage.text = Qt::Application.translate("MainWindow", "Homepage", nil, Qt::Application::UnicodeUTF8)
    @actionAbout.text = Qt::Application.translate("MainWindow", "About", nil, Qt::Application::UnicodeUTF8)
    @lineEdit.toolTip = Qt::Application.translate("MainWindow", "Run commands", nil, Qt::Application::UnicodeUTF8)
    @menuKey.title = Qt::Application.translate("MainWindow", "Key", nil, Qt::Application::UnicodeUTF8)
    @menuDB.title = Qt::Application.translate("MainWindow", "DB", nil, Qt::Application::UnicodeUTF8)
    @menuChange.title = Qt::Application.translate("MainWindow", "Change", nil, Qt::Application::UnicodeUTF8)
    @menuHelp.title = Qt::Application.translate("MainWindow", "Help", nil, Qt::Application::UnicodeUTF8)
  end # retranslateUi

  def retranslate_ui
    retranslateUi
  end

end

#
#
#  New Key
#
#
#
class NewKeyDialog < Qt::Dialog
  attr_reader :data
  attr_reader :buttonBox
  attr_reader :input_name
  attr_reader :input_type
  attr_reader :input_value


  def updateData(new)
    @data = new
  end

  def setupUi(dialog = self)

    @buttonBox = Qt::DialogButtonBox.new(dialog)
    @buttonBox.objectName = "buttonBox"
    @buttonBox.geometry = Qt::Rect.new(30, 130, 341, 32)
    @buttonBox.orientation = Qt::Horizontal
    @buttonBox.standardButtons = Qt::DialogButtonBox::Cancel|Qt::DialogButtonBox::Ok

    @input_type = Qt::ComboBox.new(dialog)
    @input_type.objectName = "input_type"
    @input_type.geometry = Qt::Rect.new(70, 20, 311, 22)
    @input_type.addItems(["string", "list", "set", "zset", "hash", "channel"])
    @label_type = Qt::Label.new(dialog)
    @label_type.objectName = "label_type"
    @label_type.geometry = Qt::Rect.new(20, 23, 61, 21)


    @input_name = Qt::LineEdit.new(dialog)
    @input_name.objectName = "input_name"
    @input_name.geometry = Qt::Rect.new(70, 50, 311, 22)
    @label = Qt::Label.new(dialog)
    @label.objectName = "label"
    @label.geometry = Qt::Rect.new(20, 53, 61, 21)

    @input_value = Qt::LineEdit.new(dialog)
    @input_value.objectName = "input_value"
    @input_value.geometry = Qt::Rect.new(70, 80, 311, 22)
    @label_value = Qt::Label.new(dialog)
    @label_value.objectName = "label_value"
    @label_value.geometry = Qt::Rect.new(20, 83, 61, 21)


    retranslateUi(dialog)
    Qt::Object.connect(@buttonBox, SIGNAL('accepted()'), dialog, SLOT('accept()'))
    Qt::Object.connect(@buttonBox, SIGNAL('rejected()'), dialog, SLOT('reject()'))

    Qt::MetaObject.connectSlotsByName(dialog)
  end # setupUi

  def setup_ui(dialog)
    setupUi(dialog)
  end

  def retranslateUi(dialog)
    dialog.windowTitle = Qt::Application.translate("Dialog", "New Key", nil, Qt::Application::UnicodeUTF8)
    @label.text = Qt::Application.translate("Dialog", "Key", nil, Qt::Application::UnicodeUTF8)
    @label_type.text = Qt::Application.translate("Dialog", "Type", nil, Qt::Application::UnicodeUTF8)
    @label_value.text = Qt::Application.translate("Dialog", "Value", nil, Qt::Application::UnicodeUTF8)
  end # retranslateUi

  def retranslate_ui(dialog)
    retranslateUi(dialog)
  end

end

#
#
#  Connect
#
#
#
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

#
#
#  About
#
#
#
class AboutDialog < Qt::Dialog
  attr_reader :data
  attr_reader :title
  attr_reader :textBrowser


  def updateData(new)
    @data = new
  end

  def setupUi(dialog = self)
    dialog.resize(400, 300)
    @pushButton = Qt::PushButton.new(dialog)
    @pushButton.objectName = "pushButton"
    @pushButton.geometry = Qt::Rect.new(290, 260, 89, 27)
    @title = Qt::Label.new(dialog)
    @title.objectName = "title"
    @title.geometry = Qt::Rect.new(40, 20, 311, 31)
    @font = Qt::Font.new
    @font.family = "Verdana"
    @font.pointSize = 26
    @title.font = @font
    @title.alignment = Qt::AlignCenter
    @textBrowser = Qt::TextBrowser.new(dialog)
    @textBrowser.objectName = "textBrowser"
    @textBrowser.geometry = Qt::Rect.new(20, 80, 361, 151)


    retranslateUi(dialog)
    Qt::Object.connect(@pushButton, SIGNAL('clicked()'), dialog, SLOT('accept()'))

    Qt::MetaObject.connectSlotsByName(dialog)
  end # setupUi

  def setup_ui(dialog)
    setupUi(dialog)
  end

  def retranslateUi(dialog)
    dialog.windowTitle = Qt::Application.translate("Dialog", "About", nil, Qt::Application::UnicodeUTF8)
    @pushButton.text = Qt::Application.translate("Dialog", "Close", nil, Qt::Application::UnicodeUTF8)
    @title.text = Qt::Application.translate("Dialog", "RediX v0.0.1", nil, Qt::Application::UnicodeUTF8)
  end # retranslateUi

  def retranslate_ui(dialog)
    retranslateUi(dialog)
  end

end

module Ui
  class MainWindow < Ui_MainWindow
  end
end  # module Ui
