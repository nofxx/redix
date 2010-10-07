
module Reguis

  class Logic < Qt::Object

   # class << self

      def r(db = 0)
        @r ||= Redis.new(:db => db)
      end

    def for(u)
      @u = u

      u.listWidget.addItems(r.keys.sort)
      # Qt::ListWidgetItem.new(u.listWidget)
      # Qt::ListWidgetItem.new(u.listWidget)
      # u.listWidget.item(0).text = "foo"
      u.listWidget.connect(SIGNAL('itemClicked(QListWidgetItem *)')) do |i|
        zoom(i)
      end
    end

    def zoom(i)
      key = i.text
      @u.tableView.model = DataModel.new.for(key)
    end


  end

  class SimpleModel

  end

  class DataModel < Qt::AbstractListModel

    def for(key)
      r = Logic.new.r
      @type = r.type(key)
      @data = case @type
      when "string" then r.get(key)
      when "hash" then r.hgetall(key)
      when "set" then r.smembers(key)
      else r.sort(key)
      end
      if @data.respond_to?(:values)
        @rows = @data.values
        @header = @data.keys
      else
        @rows = [@data]
        @header = [@type]
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
      p "Sec -> #{sec} OO -> #{orient}"
      if role == Qt::DisplayRole
         Qt::Variant.new(orient == 2 ? @header[sec] : @type)
      else Qt::Variant.new
      end
    end

  end

end
