# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'redis_record/version'

Gem::Specification.new do |spec|
  spec.name          = "redisrecord"
  spec.version       = RedisRecord::VERSION
  spec.authors       = ["Marcel Schlimper"]
  spec.email         = ["mschlimp@googlemail.com"]
  spec.description   = %q{a redis orm mapper for rails}
  spec.summary       = %q{a redis orm mapper}
  spec.homepage      = "http://redisrecord.storiesboard.de"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "redis","3.0.4" 
  
  
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
