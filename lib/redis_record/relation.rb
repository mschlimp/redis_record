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
    
    def self.has_many(*elems)
      elems.each do |elem|
        name= elem.to_s
        make_has_many_relation(name)
      end
    end
    
    def self.make_has_many_relation(name)
      class_eval <<-EOD
        def #{name}
          #{name}.find_all_by_#{self.name}Key(self.Key)
        end
      EOD
    end
    
    def self.has_one(*elems)
      elems.each do |elem|
        name= elem.to_s
        make_has_one_relation(name)
      end
    end
    
    def self.make_has_one_relation(name)
      class_eval <<-EOD
        def #{name}
          #{name}.find_by_#{self.name}Key(self.Key)
        end
      EOD
    end
    
  end
end
