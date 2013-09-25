module RedisRecord
  class Connection
    attr_accessor :connection
    def self.connect
      @@connection = Redis.new()
    end
    
  end
end
