
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = 'itamae-plugin-resource-snappy'
  spec.version       = '0.1.0'
  spec.authors       = ['Yuichi Takeuchi']
  spec.email         = ['yuichi.takeuchi@takeyuweb.co.jp']

  spec.summary       = %q{Install snap package in itamae provision.}
  spec.description   = %q{Install snap package in itamae provision.}
  spec.homepage      = %q{https://github.com/takeyuweb/itamae-plugin-resource-snappy}
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_dependency 'itamae'
end
