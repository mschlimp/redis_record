require 'spec_helper'

describe RedisRecord::Connection do
  it 'must set a host for a connection' do
    host = "127.0.0.1"
    RedisRecord::Connection::Host= host
    RedisRecord::Connection::Host.should == host
  end
  
  it 'must set a port for a connection' do
    port = "1234"
    RedisRecord::Connection::Port= port
    RedisRecord::Connection::Port.should == port
  end
  
  it 'must set a db for a connection' do
    db = 0
    RedisRecord::Connection::Db= db
    RedisRecord::Connection::Db.should == db
  end
end
