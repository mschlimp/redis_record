require 'spec_helper'

class Network < RedisRecord::Base
  properties :name, :format
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
  
  describe '#properties' do
    it 'should have a method #name and #format' do
      network= Network.new
      network.methods.to_s.include?("name=").should be_true
      network.methods.to_s.include?("format=").should be_true
    end
    
    it 'must change the value of the name property' do
      network_name= "MyNetworkName"
      network= Network.new
      network.name= network_name
      network.name.should == network_name
    end
  end
  
  describe '#create' do
    it 'should play arround' do
      network= Network.create({:name => "paul"})
    end
  end
  
  describe '#generate_key' do
    it 'should generate a new key' do
      key = Network.generate_key
      key.to_i.should > 0
    end
  end
  
  describe '#find' do
    it 'should find a existing model' do
      network= Network.find("1")
    end
  end
end
