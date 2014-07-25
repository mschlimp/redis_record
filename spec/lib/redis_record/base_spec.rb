require 'spec_helper'

describe RedisRecord::Base do
  
  describe '#properties' do
    it 'should have a method #name and #format' do
      network= Network.new
      network.methods.to_s.include?("Name=").should be_true
      network.methods.to_s.include?("Format=").should be_true
    end
    
    it 'must change the value of the name property' do
      network_name= "MyNetworkName"
      network= Network.new
      network.Name= network_name
      network.Name.should == network_name
    end
  end
  
  describe '#create' do
    it 'should should be true to create a entity' do
      network= Network.create({"Name" => "paul"})
      network.should be_true
      
    end
    
    it 'should be true to create a entity with empty key' do
      network= Network.create({"Name" => "paul", "Key" => ""})
      network.should be_true
    end
  end
  
  describe '#generate_key' do
    it 'should generate a new key' do
      key = Network.generate_key
      key.to_i.should > 0
    end
  end
  
  describe '#find' do
    it 'should find a existing entity' do
      Network.create({"Name" => "paul", "Key" => "1"})
      network= Network.find("1")
      network.Name.should == "paul"
    end
  end
  
  describe '#find_all' do
    it 'should find all entries for a key' do
      networks= Network.find_all
      networks.size.should > 1
    end
  end
  
  describe '#find_by_' do
    it 'must find a Entry with the given name' do
      name= "testNetwork"
      result= Network.find_by_Name("testNetwork")
      result.Name.should == name
    end
  end
  
  describe '#find_all_by_' do
    it 'must find all Entries for the given attribute' do
      Network.create({"Name" => "testNetwork", "Key" => "t1"})
      Network.create({"Name" => "testNetwork", "Key" => "tt1"})
      results= Network.find_all_by_Name("testNetwork")
      results.size.should == 2
    end
  end
  
  describe '#update' do
    it 'should update a existing model entity' do
      Network.create({"Name" => "paul", "Key" => "1234567890_for_update"})
      network= Network.find("1234567890_for_update")
      network.update({"name" => "updatedNetwork"})
    end
  end
  
  describe '#delete' do
    it 'should remove a existing entity' do
      Network.create({"Name" => "paul", "Key" => "1234567890_for_delete"})
      network= Network.find("1234567890_for_delete")
      network.delete.should be_true
    end
  end
end
