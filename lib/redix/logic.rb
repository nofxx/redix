
module Redix

  class Logic

    class << self

      def r(db = 0)
        @r ||= Redis.new(:db => db)
      rescue
        failure("Can't find redis on localhost:6379")
      end

      def reconnect(db = @db)
        puts "Reconnecting to DB ##{db}"
        params = db =~ /\./ ? { :url => "redis://#{db}" } : { :db => db }
        @r = Redis.connect(params)
        build_keys
      rescue
        failure("Failure connecting to #{params}")
      end

      def failure(f)
        @u.statusbar.showMessage(f)
      end

      def build_dbs
        0.upto(15) do |i|
          a = Qt::Action.new(@u.mainWindow)
          a.connect(SIGNAL('triggered()')) { reconnect(@db = i) }
          # a.objectName("action#{i}")
          @u.menuChange.addAction(a)
          a.text = Qt::Application.translate("MainWindow", "##{i}", nil, Qt::Application::UnicodeUTF8)
        end
      end

      def build_keys
        @u.listWidget.clear
        @u.listWidget.addItems(r.keys.sort)
        rescue
        failure  "Could not conect to redis"

      end

      def connect_dialog
        c = ConnectDialog.new
        c.setupUi
        redis = "#{r.client.host}:#{r.client.port}/#{r.client.db}"
        redis = "#{r.client.password}@" + redis if r.client.password
        c.lineEdit.setText(redis)
        c.buttonBox.connect(SIGNAL('accepted()')) { reconnect(c.lineEdit.text) }
        c.show
      end

      def about_dialog
        a = AboutDialog.new
        a.setupUi
        # a.title.setText("RediX")
        a.textBrowser.setHtml("About <a href='http://github.com/nofxx/redix'>Redix</a>....")
        a.show
      end

      def for(u)
        @u = u
        build_keys
        build_dbs
        u.actionConnect.connect(SIGNAL('triggered()')) { connect_dialog }
        u.actionReconnect.connect(SIGNAL('triggered()')) { reconnect }
        u.actionAbout.connect(SIGNAL('triggered()')) { about_dialog }
        u.actionQuit.connect(SIGNAL('triggered()'), App, SLOT('quit()'))

        # Qt::ListWidgetItem.new(u.listWidget)
        # Qt::ListWidgetItem.new(u.listWidget)
        # u.listWidget.item(0).text = "foo"
        u.listWidget.connect(SIGNAL('itemClicked(QListWidgetItem *)')) do |i|
          zoom(i)
        end
        u.lineEdit.connect(SIGNAL('returnPressed()')) { command }
      end

      def command
        comm = @u.lineEdit.text
        @u.lineEdit.clear
        puts "Exec #{comm}"
        res = eval("r.#{comm}") rescue "FAIL"
        @u.textBrowser.setHtml(res)# += res

      rescue Exception => e
        @u.textBrowser.setHtml e.to_s
      end

      def zoom(i)
        key = i.text
        @u.tableView.model = DataModel.new.for(key)
        @u.tableView.setColumnWidth(0, 400)

      end
    end

  end

  class SimpleModel

  end

  class DataModel < Qt::AbstractListModel

    def for(key)
      r = Logic.r
      @type = r.type(key)
      @data = case @type
      when "string" then r.get(key)
      when "hash" then r.hgetall(key)
      when "set" then r.smembers(key)
      else r.sort(key)
      end
      if @data.kind_of?(Hash)
        @rows = @data.values
        @header = @data.keys
      else
        @rows = @data.kind_of?(Array) ? @data : [@data]
        @header = (0..@rows.size).to_a
      end

      self
    end

    def rowCount idx
      @rows.size
    end

    def data idx, role = Qt::DisplayRole
      if role == Qt::DisplayRole then Qt::Variant.new @rows[idx.row]
      else Qt::Variant.new
      end
    end

    def headerData sec, orient, role = Qt::DisplayRole
      if role == Qt::DisplayRole
         Qt::Variant.new(orient == 2 ? @header[sec] : @type)
      else Qt::Variant.new
      end
    end

  end

end
