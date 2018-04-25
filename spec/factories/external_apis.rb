FactoryBot.define do
  factory :data_portal do
    name "GovDataDE"
    sequence :url do |n|
      {"url#{n}" => "http://offenedaten-koeln.de/api/3/action"}
    end
    description "Das Datenportal für Deutschland"
  end
end
