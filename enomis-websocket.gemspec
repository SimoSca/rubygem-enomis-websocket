# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'enomis/websocket/version'

Gem::Specification.new do |spec|
  spec.name          = "enomis-websocket"
  spec.version       = Enomis::Websocket::VERSION
  spec.authors       = ["Enomis"]
  spec.email         = ["inodracs.enomis@gmail.com"]

  spec.summary       = %q{Simple WebSocket Server-Client.}
  spec.description   = %q{Simple WebSocket Server-Client emproved for personalusage, i.e. for autoreload in SPA (single page application).}
  spec.homepage      = "TODO: Put your gem's website or public repo URL here."
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"

  ### added by me

  # development
  spec.add_development_dependency "rspec-nc" # provides native notifications on Mac OS X (not essential)
  spec.add_development_dependency "guard"
  spec.add_development_dependency "guard-rspec"

  # user gem dep
  # spec.add_dependency "event_emitter"
  spec.add_dependency "websocket-eventmachine-client"
  spec.add_dependency "websocket-eventmachine-server"
  # to exchange HASH <=> JSON passing messages
  spec.add_dependency "json"
  # to manage command line
  spec.add_dependency "commander"
  spec.executables   <<  "bin/enomis-websocket"

end
