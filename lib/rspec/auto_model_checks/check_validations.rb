# frozen_string_literal: true

module RSpec
  module AutoModelChecks
    module CheckValidations
      def check_validations!(exclusions: [])
        it 'has correct "presence" validations' do
          model = create(:"#{described_class.to_s.underscore}")

          described_class.attribute_names.each do |attribute|
            model.restore_attributes
            next if attribute.in?(%w[id updated_at created_at] + exclusions)

            expect { model.update!(attribute.to_sym => nil) }.not_to raise_error ActiveRecord::StatementInvalid
          end

          described_class.reflect_on_all_associations.each do |association|
            next if exclusions.include?(association.name.to_sym)

            model.restore_attributes
            next unless association.is_a?(ActiveRecord::Reflection::BelongsToReflection) ||
                        association.is_a?(ActiveRecord::Reflection::HasOneReflection)

            next if association.class_name == "ActiveStorage::Attachment"

            model.send("#{association.name}=", nil)
            expect { model.save! }.not_to raise_error ActiveRecord::StatementInvalid
          end
        end

        it 'has correct "uniqueness" validations' do
          model = create(:"#{described_class.to_s.underscore}")
          expect { model.dup.save }.not_to raise_error ActiveRecord::RecordNotUnique
        end

        it 'has correct "numericality" validations' do
          numericality_columns = described_class.columns.select do |column|
            column.sql_type_metadata.precision&.nonzero?
          end
          numericality_validators = described_class.validators.select do |validator|
            validator.is_a? ActiveModel::Validations::NumericalityValidator
          end

          numericality_columns.each do |column|
            attribute_sym = column.name.to_sym # TODO: Don't assume that the attribute name is the same as the column name

            next if (exclusions.include? column.name) || (exclusions.include? attribute_sym)

            validator = numericality_validators.detect { |validator| validator.attributes.include? attribute_sym }

            expect(validator).to be_truthy

            precision = column.sql_type_metadata.precision

            expect(precision).to be_truthy
            expect(precision).to be_positive

            scale = column.sql_type_metadata.scale || 0
            integer_digits = precision - scale
            max = 10**integer_digits
            options = validator.options

            expect(options).to have_key(:less_than)
            expect(options[:less_than]).to be <= max
            expect(options).to have_key(:greater_than)
            expect(options[:greater_than]).to be >= -max
          end
        end
      end
    end
  end
end
