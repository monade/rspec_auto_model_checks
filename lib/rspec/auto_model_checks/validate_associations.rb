# frozen_string_literal: true

module RSpec
  module AutoModelChecks
    module ValidateAssociations
      def validate_associations!(check_dependent: true)
        is_read_only = described_class.new.readonly?
        described_class.reflect_on_all_associations.each do |association|
          it "validate #{described_class.name}##{association.name}" do
            if association.is_a?(ActiveRecord::Reflection::HasManyReflection) ||
              (association.is_a?(ActiveRecord::Reflection::ThroughReflection) &&
                association.instance_variable_get(:@delegate_reflection).is_a?(ActiveRecord::Reflection::HasManyReflection)) ||
              association.is_a?(ActiveRecord::Reflection::HasAndBelongsToManyReflection)
              expect(subject.send(association.name)).to eq([])
            else
              expect { subject.send(association.name) }.not_to raise_error
            end
            unless association.options[:polymorphic]
              expect do
                described_class.joins(association.name).where('1 = 0').to_a
              end.not_to raise_error
            end
          end

          if association.is_a?(ActiveRecord::Reflection::HasManyReflection) || association.is_a?(ActiveRecord::Reflection::BelongsToReflection)
            it "validate that #{described_class.name}##{association.name} has an inverse" do
              next if association.polymorphic?

              inverse = case association
                        when ActiveRecord::Reflection::HasManyReflection
                          association.inverse_of
                        when ActiveRecord::Reflection::BelongsToReflection
                          inverse_name = ActiveSupport::Inflector.underscore(association.active_record.name.demodulize).pluralize.to_sym
                          reflection = begin
                                         association.klass._reflect_on_association(inverse_name)
                                       rescue StandardError
                                         false
                                       end
                          if reflection && association.klass <= reflection.active_record
                            reflection
                          else
                            association.inverse_of
                          end
                        end

              skip "Missing inverse: #{described_class.name}##{association.name}" unless inverse
            end
          end

          next unless check_dependent && association.is_a?(ActiveRecord::Reflection::HasManyReflection) && !is_read_only

          it "validate that #{described_class.name}##{association.name} has dependent: :something" do
            expect(association.options[:dependent]).not_to be_nil, 'Please define a dependent option!'

            inverse = association.inverse_of
            expect(association.options[:dependent]).not_to be(:nullify) if inverse && !inverse.options[:optional]
          end
        end
      end
    end
  end
end
