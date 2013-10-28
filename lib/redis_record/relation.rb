module RedisRecord
  class Base
    def self.belongs_to(*elems)
      elems.each do |elem|
        name= elem.to_s
        make_belongs_to_relation(name)
      end
    end
    
    def self.make_belongs_to_relation(name)
      class_eval <<-EOD
        def #{name}
          #{name}.find(self.#{name}Key) 
        end
      EOD
    end
  end
end
