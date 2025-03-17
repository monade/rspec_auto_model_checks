# frozen_string_literal: true

source "https://rubygems.org"

# Specify your gem's dependencies in rspec_match_structure.gemspec
gemspec

rails_version = ENV["CI_RAILS_VERSION"] || ">= 0.0"

gem "factory_bot_rails"
gem "rails", rails_version
gem "rake"
gem "rspec"
gem "rspec-collection_matchers"
gem "rubocop"
gem "simplecov"
if ["~> 8.0.0", ">= 0", ">= 0.0"].include?(rails_version)
  gem "sqlite3", "~> 2"
else
  gem "sqlite3", "~> 1.7.3"
end
gem "base64"
gem "benchmark"
gem "bigdecimal"
gem "logger"
gem "mutex_m"
