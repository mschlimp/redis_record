require 'spec_helper'

describe RedisRecord::Connection do
  before(:all) do
    @host = "127.0.0.1"
    RedisRecord::Connection::Host= @host
    @port = "6379"
    RedisRecord::Connection::Port= @port
    @db = 0
    RedisRecord::Connection::Db= @db
    
  end
  it 'must set a host for a connection' do
    
    RedisRecord::Connection::Host.should == @host
  end
  
  it 'must set a port for a connection' do
    RedisRecord::Connection::Port.should == @port
  end
  
  it 'must set a db for a connection' do
    RedisRecord::Connection::Db.should == @db
  end
  
  describe '#connect' do
    it 'has to connect to a given redis db' do
      redis = RedisRecord::Connection.connect
      RedisRecord::Connection.isConnected?.should be_true
    end
    
    it 'has to reconnect to a given redis db' do
      redis = RedisRecord::Connection.connect
      redis.client.disconnect
      redis = RedisRecord::Connection.connect
      RedisRecord::Connection.isConnected?.should be_true
    end
    
    it 'should be false to check a failed redis connection' do
      redis = RedisRecord::Connection.connect
      redis.client.disconnect
      RedisRecord::Connection.isConnected?.should be_false
    end
  end
  
end


