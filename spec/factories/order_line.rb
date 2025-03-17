# frozen_string_literal: true

FactoryBot.define do
  factory :order_line do
    sequence(:quantity) { |n| n }
  end
end
