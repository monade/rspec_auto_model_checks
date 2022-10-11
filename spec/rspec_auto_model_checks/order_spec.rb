# frozen_string_literal: true

RSpec.describe Order, type: :model do
  check_validations! exclusions: [:num_2]
  validate_associations!
end
