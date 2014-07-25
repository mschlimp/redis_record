require 'spec_helper'

class Network < RedisRecord::Base
  properties :Key, :Name
  has_many :Site
end

class Site < RedisRecord::Base
  properties :Key, :Name, :NetworkKey
  belongs_to :Network
end

describe RedisRecord::Base do
  
  it 'Site must have a Network' do
    network= Network.create({:Name => "paul", :Key => "1234567890"})
    site= Site.create({:Name => "paul", :Key => "1234567890", :NetworkKey=>"1234567890"})
    site= Site.find("1234567890")
    site.Network.Name.should=="paul"
  end
  it 'Network must have a Site' do
    network= Network.find("1234567890")
    network.Site.first.Name.should=="paul"
  end
end
