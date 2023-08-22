# frozen_string_literal: true

require_relative "lib/bridgetown_linkchecker/version"

Gem::Specification.new do |spec|
  spec.name = "bridgetown_linkchecker"
  spec.version = BridgetownLinkchecker::VERSION
  spec.author = "Lars Peters"
  spec.email = "lp@itpeters.com"
  spec.summary = "Checks for broken links in your Bridgetown site."
  spec.homepage = "https://github.com/lape/bridgetown_linkchecker"
  spec.license = "MIT"

  spec.files = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|script|spec|features|frontend)/}) }
  spec.require_paths = ["lib"]
  # Uncomment this if you wish to supply a companion NPM package:
  # spec.metadata      = { "yarn-add" => "bridgetown_linkchecker@#{BridgetownLinkchecker::VERSION}" }

  spec.required_ruby_version = ">= 2.7.0"

  spec.add_dependency "bridgetown", ">= 1.2.0", "< 2.0"
  spec.add_dependency "nokogiri"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake", ">= 13.0"
  spec.add_development_dependency "rubocop-bridgetown", "~> 0.3"
end
