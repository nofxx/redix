
module Redix

  class Logic < Qt::Object # =/
    slots :reload, :help, :connect

    class << self

      def r(db = 0, host = REDIS_HOST, port = REDIS_PORT)
        @r ||= Redis.new(:host => host, :db => db)
      rescue
        failure("Can't find redis on #{host}:#{port}")
      end

      def reconnect(db = @db)
        puts "Reconnecting to DB ##{db}"
        params = db =~ /\./ ? { :url => "redis://#{db}" } : { :db => db }
        @r = Redis.connect(params.merge(:host => REDIS_HOST, :port => REDIS_PORT))
        build_keys
      rescue
        failure("Failure connecting to #{params}")
      end

      def failure(f)
        @u.statusbar.showMessage(f)
      end
      alias :message :failure

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
        all = r.keys.sort
        @u.listWidget.clear
        @u.listWidget.addItems(all)
        puts r.info
        message "DB Loaded #{all.size} keys. Used memory #{r.info['used_memory_human']}"
      rescue
        failure  "Could not conect to redis"
      end

      def connect
        c = ConnectDialog.new
        c.setupUi
        redis = "#{r.client.host}:#{r.client.port}/#{r.client.db}"
        redis = "#{r.client.password}@" + redis if r.client.password
        c.lineEdit.setText(redis)
        c.buttonBox.connect(SIGNAL('accepted()')) { reconnect(c.lineEdit.text) }
        c.show
      end

      def help
        a = AboutDialog.new
        a.setupUi
        # a.title.setText("RediX")
        a.textBrowser.setHtml("About <a href='http://github.com/nofxx/redix'>Redix</a><p>Marcos Piccinini</p>")
        a.show
      end

      def new_key
        k = NewKeyDialog.new
        k.setupUi
        k.buttonBox.connect(SIGNAL('accepted()')) { create_key(k) }
        k.show
      end

      def create_key(k, type = nil, v = nil)

        unless type
          type = k.input_type.current_text
          v = k.input_value.text
          k = k.input_name.text
        end
        case type
        when 'string' then r.set(k, v)
        when 'hash' then r.hmset(k, v)
        when 'list' then r.add(k, v)
        when 'set' then  r.sadd(k, v)
        end
      end

      def for(u)
        @u = u
        build_keys
        build_dbs
        u.actionNew.connect(SIGNAL('triggered()')) { new_key }
        u.actionConnect.connect(SIGNAL('triggered()')) { connect }
        u.actionReconnect.connect(SIGNAL('triggered()')) { reconnect }
        u.actionAbout.connect(SIGNAL('triggered()')) { help }
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
        @u.textBrowser.setHtml("=> #{res}")# += res

      rescue Exception => e
        @u.textBrowser.setHtml e.to_s
      end

      def zoom(i)
        key = i.text
        model = DataModel.new.for(key)
        @u.tableView.model = model
        @u.tableView.setColumnWidth(0, 400)
      end
    end

  end

  class SimpleModel

  end

  class DataModel < Qt::AbstractTableModel

    def for(key)
      r = Logic.r
      @key = key
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

    def flags(arg=nil)
      Qt::ItemIsEditable|Qt::ItemIsEnabled
    end

    def rowCount idx=nil
      @rows.size
    end

    def columnCount idx=nil
      1
    end

    def data idx, role = Qt::DisplayRole
      if role == Qt::DisplayRole then Qt::Variant.new @rows[idx.row]
      else Qt::Variant.new
      end
    end

    def setData(mid, var, *args)
      r = Logic.r
      v = var.toString
      case @type
      when 'string' then r.set(@key, v)
      when 'hash' then r.hset(@key, @header[mid.row], v)
      when 'list' then r.lset(@key, mid.row, v)
      when 'set'
        r.srem(@key, @rows[mid.row])
        r.sadd(@key, v)
      end
      self.for(@key)
    end

    def setHeaderData(*args)
      p "Set Header -> #{args}"
    end

    def headerData sec, orient, role = Qt::DisplayRole
      if role == Qt::DisplayRole
         Qt::Variant.new(orient == 2 ? @header[sec] : @type)
      else Qt::Variant.new
      end
    end

  end

end
