require 'spec_helper'

describe RedisRecord::Fixture do
  
  class FixtureTestData < RedisRecord::Base
    #code
  end
  
  before(:all) do
    RedisRecord::Fixture::Fixture_Path= "./spec/fixtures/"
  end
  
  it 'should load a fixtures yaml' do
    fixture= RedisRecord::Fixture.new
    erg = fixture.load(RedisRecord::Fixture::Fixture_Path+"network")
    erg["one"]["Key"].should == "test_key"
  end
  
  it 'should save a fixtures yaml' do
    fixture= RedisRecord::Fixture.new
    erg= fixture.load(RedisRecord::Fixture::Fixture_Path+"network")
    fixture.save({:model => "Network", :data => erg.first.last})
  end
  
  it 'should update a redis hash key by a fixture' do
    redis_fixture= RedisRecord::Fixture.new
    redis_fixture.fixture "Network"
    Network.find_all.size.should == 2
  end
  
end