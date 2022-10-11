# frozen_string_literal: true

require "active_support"
require "rails"
require "rspec"
require "active_record"
require "factory_bot_rails"
require "rspec/auto_model_checks"

Dir[File.expand_path("../support/*.rb", __FILE__)].each { |f| require f }
Dir[File.expand_path('../factories/*.rb', __FILE__)].each { |f| require f }

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  Schema.create

  config.around(:each) do |example|
    ActiveRecord::Base.transaction do
      example.run
      raise ActiveRecord::Rollback
    end
  end
end
