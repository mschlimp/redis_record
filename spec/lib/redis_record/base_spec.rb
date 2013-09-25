require 'spec_helper'

class Network < RedisRecord::Base
  properties :name, :format
end

describe RedisRecord::Base do
  describe '#properties' do
    it 'should have a method #name and #format' do
      network= Network.new
      network.methods.to_s.include?("name=").should be_true
      network.methods.to_s.include?("format=").should be_true
    end
  end
end
