require 'json'

module RedisRecord
  class Base
    
    attr_accessor :hash_of_properties
    def initialize
      @hash_of_properties= Hash.new
    end
    
    def self.find(key)
      name=  self.name
      RedisRecord::Connection.connect unless RedisRecord::Connection.isConnected?
      result= RedisRecord::Connection.connection.hget(name,key)
      if result
        model = self.new
        model.hash_of_properties= JSON.parse(result)
      else
        return nil
      end
      model
    end
    
    def self.find_all
      models = Array.new
      name=  self.name
      RedisRecord::Connection.connect unless RedisRecord::Connection.isConnected?
      results= RedisRecord::Connection.connection.hgetall(name)
      if results
        results.each do |result|
          model = self.new
          begin
            model.hash_of_properties= JSON.parse(result[1])
            models << model
          rescue JSON::ParserError
          end
        end
      else
        return nil
      end
      models
    end
    
    def update(attributes)
      @hash_of_properties.merge!(attributes)
      name=  self.class
      key= @hash_of_properties["Key"]
      value= @hash_of_properties
      
      RedisRecord::Connection.connect unless RedisRecord::Connection.isConnected?
      result= RedisRecord::Connection.connection.hset(name,key,value.to_json)
      !result
       
    end
    
    #TODO: returns entitiy or nil if failed
    def self.create(opts)
      @hash_of_properties= opts
      @hash_of_properties["Key"]= generate_key if (@hash_of_properties["Key"].nil? || @hash_of_properties["Key"].empty?)
                                         
      name=  self.name
      key= @hash_of_properties["Key"]
      value= @hash_of_properties
      
      RedisRecord::Connection.connect unless RedisRecord::Connection.isConnected?
      result= RedisRecord::Connection.connection.hset(name,key,value.to_json)
      
      #TODO: type of result
      result
    end
    
    def delete
      name= self.class
      key= @hash_of_properties["Key"]
      RedisRecord::Connection.connect unless RedisRecord::Connection.isConnected?
      result= RedisRecord::Connection.connection.hdel(name,key)
      result
    end
    
    def self.properties(*elems)
      elems.each do |elem|
        name= elem.to_s
        make_accessor(name)
        make_single_selectors(name)
        make_all_selectors(name)
      end
    end
    
    def self.make_accessor(name)
      class_eval <<-EOD
        def #{name}=(value)
          @hash_of_properties['#{name}']=value 
        end
        def #{name}
          @hash_of_properties['#{name}']
        end
      EOD
    end
    
    def self.make_single_selectors(name)
      class_eval <<-EOD
        def self.find_by_#{name}(value)
          results= self.find_all
          results.each do |result|
            return result if result.#{name}==value
          end
          return nil
        end
      EOD
    end
    
    def self.make_all_selectors(name)
      class_eval <<-EOD
        def self.find_all_by_#{name}(value)
          models= Array.new
          results= self.find_all
          results.each do |result|
            models << result if result.#{name}==value
          end
          models
        end
      EOD
    end
    
    def self.generate_key
      name= self.name
      key= (rand(899999999999)+100000000000).to_s
      if self.find(key)
        self.generate_key
      else
        key
      end
    end
    
    def [](key)
      @hash_of_properties[key]
    end
    
    def []=(key,value)
      @hash_of_properties[key]=value
    end
  end
end
