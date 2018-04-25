FactoryBot.define do
  factory :federal_state do
    sequence :name do |n|
      "FederalState#{n}"
    end
  end
end
