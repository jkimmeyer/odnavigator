FactoryBot.define do
  factory :city do
    sequence :name do |n|
      "Stadt#{n}"
    end
  end
end
