module RedisRecord
  class Connection
    attr_accessor :connection
    
    def self.connect
      begin
        @@connection= nil
        host= RedisRecord::Connection::Host
        port= RedisRecord::Connection::Port
        db= RedisRecord::Connection::Db
        @@connection = Redis.new(:host => host, :port => port, :db => db)
        @@connection.Ping == "PONG"
      rescue
        @@connection= nil
      end
      @@connection
    end
    
    def self.isConnected?
      begin
        return @@connection &&  @@connection.client.connected? && @@connection.Ping == "PONG"
      rescue
        return false
      end
    end
    
    def self.connection
      @@connection
    end
    
  end
end
