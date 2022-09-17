# frozen_string_literal: true

require "rspec/auto_model_checks"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  # If you need to load a schema in the tests:
  # config.before(:suite) do
  #   Schema.create
  # end

  # config.around(:each) do |example|
  #   ActiveRecord::Base.transaction do
  #     example.run
  #     raise ActiveRecord::Rollback
  #   end
  # end
end