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
    
    def update(attributes)
      @hash_of_properties.merge!(attributes)
      name=  self.class
      key= @hash_of_properties["key"]
      value= @hash_of_properties
      
      RedisRecord::Connection.connect unless RedisRecord::Connection.isConnected?
      result= RedisRecord::Connection.connection.hset(name,key,value.to_json)
      puts @hash_of_properties.inspect
      #TODO: type of result
      puts name
      result
       
    end
    
    def self.create(opts)
      @hash_of_properties= opts
      @hash_of_properties["key"]= generate_key unless @hash_of_properties["key"]
                                         
      name=  self.name
      key= @hash_of_properties["key"]
      value= @hash_of_properties
      
      RedisRecord::Connection.connect unless RedisRecord::Connection.isConnected?
      result= RedisRecord::Connection.connection.hset(name,key,value.to_json)
      
      #TODO: type of result
      result
    end
    
    def delete
    end
    
    def self.properties(*elems)
      elems.each do |elem|
        name= elem.to_s
        class_eval <<-EOD
          def #{name}=(value)
            @hash_of_properties['#{name}']=value 
          end
          def #{name}
            @hash_of_properties['#{name}']
          end
        EOD
      end
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
