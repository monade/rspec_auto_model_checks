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

            next if association.class_name == 'ActiveStorage::Attachment'

            model.send("#{association.name}=", nil)
            expect { model.save! }.not_to raise_error ActiveRecord::StatementInvalid
          end
        end

        it 'has correct "uniqueness" validations' do
          model = create(:"#{described_class.to_s.underscore}")
          expect { model.dup.save }.not_to raise_error ActiveRecord::RecordNotUnique
        end
      end
    end
  end
end
