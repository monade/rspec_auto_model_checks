FactoryBot.define do
  factory :order do
    num { 999.99 }
    association(:user, factory: :user)
  end
end
