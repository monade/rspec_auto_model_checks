# frozen_string_literal: true

require "active_support"
require "rspec"

module RSpec
  module AutoModelChecks
  end
end

require "rspec/auto_model_checks/validate_associations"
require "rspec/auto_model_checks/check_validations"
require "rspec/auto_model_checks/validate_scopes"

RSpec.configure do |config|
  config.extend RSpec::AutoModelChecks::ValidateAssociations, type: :model
  config.extend RSpec::AutoModelChecks::CheckValidations, type: :model
  config.extend RSpec::AutoModelChecks::ValidateScopes, type: :model
end
