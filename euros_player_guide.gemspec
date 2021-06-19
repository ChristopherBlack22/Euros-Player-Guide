# frozen_string_literal: true

require_relative "lib/euros_player_guide/version"

Gem::Specification.new do |spec|
  spec.name          = "euros_player_guide"
  spec.version       = EurosPlayerGuide::VERSION
  spec.authors       = ["Christopher Black"]
  spec.email         = ["christopher.black.2209@googlemail.com"]

  spec.summary       = "A guide to the players at Euro 2020"
  spec.description   = "A CLI that allows the user to search through the players of each team competing at Euro 2020 and find their key stats by scraping the official tournament webpage"
  spec.homepage      = "http://www.tbc.com"
  spec.license       = "MIT"
  spec.required_ruby_version = ">= 2.4.0"

  spec.metadata["allowed_push_host"] = "http://mygemserver.com"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "http://www.tbc.com."
  spec.metadata["changelog_uri"] = "http://www.tbc.com."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "pry"
  spec.add_dependency "nokogiri"

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end
