module RedisRecord
  class Connection
    attr_accessor :connection
    def self.connect
      host= RedisRecord::Connection::Host
      port= RedisRecord::Connection::Port
      db= RedisRecord::Connection::Db
      @@connection = Redis.new(:host => host, :port => port, :db => db)
    end
    
    def self.isConnected?
    end
    
  end
end
