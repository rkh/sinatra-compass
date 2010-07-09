SPEC = Gem::Specification.new do |s|

  # Get the facts.
  s.name             = "sinatra-compass"
  s.version          = "0.5.0"
  s.description      = "Better Compass integration for Sinatra (part of BigBand)."

  # BigBand depedencies
  s.add_dependency "monkey-lib", "~> #{s.version}"
  s.add_dependency "sinatra-sugar", "~> #{s.version}"
  s.add_dependency "haml-more", "~> #{s.version}"
  s.add_development_dependency "sinatra-test-helper", "~> #{s.version}"

  # External dependencies
  s.add_dependency "sinatra", "~> 1.0"
  s.add_dependency "compass", ">= 0.8.17"
  s.add_development_dependency "rspec", ">= 1.3.0"

  # Those should be about the same in any BigBand extension.
  s.authors          = ["Konstantin Haase"]
  s.email            = "konstantin.mailinglists@googlemail.com"
  s.files            = Dir["**/*.{rb,md}"] << "LICENSE"
  s.has_rdoc         = 'yard'
  s.homepage         = "http://github.com/rkh/#{s.name}"
  s.require_paths    = ["lib"]
  s.summary          = s.description
  
end
