lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = 'page-toc-filter'
  spec.version       = '0.1.0'
  spec.authors       = ['Garen Torikian']
  spec.email         = ['gjtorikian@gmail.com']

  spec.summary       = 'Generates a table of contents for a single page, via HTML::Pipeline.'
  spec.homepage      = 'https://github.com/gjtorikian/page-toc-filter'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'html-pipeline', '~> 2.0'
  spec.add_development_dependency 'nokogiri', '~> 1.8.0'

  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'minitest', '~> 5.8'
  spec.add_development_dependency 'commonmarker'
end
