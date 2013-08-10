# coding: utf-8

Gem::Specification.new do |spec|
  spec.name          = "fluentd-plugin-dummydata-producer"
  spec.version       = "0.0.1"
  spec.authors       = ["TAGOMORI Satoshi"]
  spec.email         = ["tagomoris@gmail.com"]
  spec.description   = %q{Emits dummy data to do bench marks and other tests}
  spec.summary       = %q{Fluentd plugin to produce dummy data and emit it}
  spec.homepage      = "https://github.com/tagomoris/fluent-plugin-dummydata-producer"
  spec.license       = "APLv2"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "fluentd"#, ['~> 0.11.0']
  spec.add_runtime_dependency "fluent-mixin-config-placeholders"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
