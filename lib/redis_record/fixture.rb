require 'yaml'

module RedisRecord
  class Fixture
    def fixture(*args)
      path= RedisRecord::Fixture::Fixture_Path
      args.each do |fixture|
        destroy(fixture)
        entries= load(path+fixture)
        entries.each do |key,entry|
          save({:model => fixture,:data => entry})
        end
      end
    end
    
    
    def load(path)
       YAML.load_file(path+".yml")
    end
    
    def destroy(model)
      elements= Object.const_get(model).find_all
      elements.each do |elem|
        elem.delete
      end
    end
    
    def save(args)
      klass= args[:model]
      data= args[:data]
      Object.const_get(klass).create(data)
    end
    
  end
end
