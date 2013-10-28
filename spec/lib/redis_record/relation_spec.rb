require 'spec_helper'

class Network < RedisRecord::Base
  properties :Key, :Name
end

class Site < RedisRecord::Base
  properties :Key, :Name, :NetworkKey
  belongs_to :Network
end

describe RedisRecord::Base do
  before(:all) do
    @host = "127.0.0.1"
    RedisRecord::Connection::Host= @host
    @port = "6379"
    RedisRecord::Connection::Port= @port
    @db = 0
    RedisRecord::Connection::Db= @db
    RedisRecord::Connection.connect
  end
  
  it 'Network must have a Site' do
    network= Network.create({:Name => "paul", :Key => "1234567890"})
    site= Site.create({:Name => "paul", :Key => "1234567890", :NetworkKey=>"1234567890"})
    site= Site.find("1234567890")
    site.Network.Name.should=="paul"
  end
end
