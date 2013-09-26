module RedisRecord
  class Connection
    attr_accessor :connection
    
    def self.connect
      host= RedisRecord::Connection::Host
      port= RedisRecord::Connection::Port
      db= RedisRecord::Connection::Db
      @@connection = Redis.new(:host => host, :port => port, :db => db)
      @@connection.Ping == "PONG"
      @@connection
    end
    
    def self.isConnected?
      @@connection &&  @@connection.client.connected?
    end
    
    def self.connection
      @@connection
    end
    
  end
end
