
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "hyperender/version"

Gem::Specification.new do |spec|
  spec.name          = "hyperender"
  spec.version       = Hyperender::VERSION
  spec.authors       = ["Nguyễn Nhật Minh Tú"]
  spec.email         = ["tunnm@topica.edu.vn"]

  spec.summary       = "HATEOAS-like rendering layout for Rails Applications"
  spec.description   = "HATEOAS-like rendering layout for Rails Applications"
  spec.homepage      = "https://git.edumall.io/minhtu/hyperender"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = ""
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rails"
end
