FactoryBot.define do
  factory :api_request do
    sequence :url do |n|
      {"url#{n}" => "http://offenedaten-koeln.de/api/3/action"}
    end
  end
end
