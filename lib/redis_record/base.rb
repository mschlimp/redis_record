module RedisRecord
  class Base
    attr_accessor :hash_of_properties
    def initialize
      @hash_of_properties= Hash.new
    end
    
    def self.find
    end
    
    def self.update
    end
    
    def self.create
      #get properties
      #check id
      #set value if no id
      #properties to json (hash)
    end
    
    def self.delete
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
    
    def [](key)
      @hash_of_properties[key]
    end
    
    def []=(key,value)
      @hash_of_properties[key]=value
    end
  end
end
