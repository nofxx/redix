
module Redix


  module RedisD

    CONF = { :pid => "redis.pid", :file => "redis.conf" }

    def self.start
      unless running?
        system "redis server #{CONF[:file]}"
      end
    end

    def self.stop
      if running?
        system "kill #{File.read(CONF[:pid])}"
        File.delete(CONF[:pid])
      end
    end

    def self.running?
      File.exists? CONF[:pid]
    end

  end

end
