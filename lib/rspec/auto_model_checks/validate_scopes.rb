# frozen_string_literal: true

module RSpec
  module AutoModelChecks
    module ValidateScopes
      def validate_scopes!(except: [])
        methods = (described_class.public_methods - described_class.superclass.public_methods - except).map do |m|
          described_class.method(m)
        end
        methods.select { |m| m.source_location.first.include?("scoping/") }.each do |scope|
          it "validate scope #{described_class.name}##{scope.name}" do
            scope.call
          rescue ArgumentError
            skip "can't infer default parameters for #{scope.name}"
          end
        end
      end
    end
  end
end
