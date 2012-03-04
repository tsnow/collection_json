# -*- encoding: utf-8 -*-
require File.expand_path('../lib/collection_json/gem_version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Mark Burns"]
  gem.email         = ["markthedeveloper@gmail.com"]
  gem.description   = %q{Help create Collection+JSON hypermedia APIs}
  gem.summary       = %q{As specified by: http://amundsen.com/media-types/collection/format/#objects}
  gem.homepage      = "https://github.com/markburns/collection_json"
  gem.add_dependency  'virtus'
  gem.add_dependency  'active_support'
  gem.add_dependency  'i18n'
  gem.add_dependency  'draper'
  gem.add_development_dependency 'guard-rspec'
  gem.add_development_dependency 'growl'
  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'ruby-debug19'
  gem.add_development_dependency 'ruby-debug-base19', '0.11.26'

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "collection_json"
  gem.require_paths = ["lib"]
  gem.version       = CollectionJson::GEM_VERSION
end
