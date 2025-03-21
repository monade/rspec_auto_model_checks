# frozen_string_literal: true

$LOAD_PATH.push File.expand_path("lib", __dir__)

require_relative "lib/rspec/auto_model_checks/version"

Gem::Specification.new do |spec|
  spec.name          = "rspec_auto_model_checks"
  spec.version       = RSpec::AutoModelChecks::VERSION
  spec.authors       = ["Mònade"]
  spec.email         = ["team@monade.io"]

  spec.summary       = "A gem that helps runs some automated checks on models."
  spec.description   = "A gem that helps runs some automated checks on models."
  spec.homepage      = "https://github.com/monade/rspec_auto_model_checks"
  spec.license       = "MIT"
  spec.required_ruby_version = ">= 3.1"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "https://github.com/monade/rspec_auto_model_checks/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  spec.add_dependency "activesupport", [">= 6", "< 9"]
  spec.add_dependency "rspec", "~> 3"
  spec.add_development_dependency "rubocop"

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end
