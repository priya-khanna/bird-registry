FactoryGirl.define do
  factory :bird do
    sequence(:name) { |i| "Bird#{i}" }
    sequence(:family) { |i| "Family#{i}" }
    added { Time.now.strftime("%Y-%m-%d") }
    visible true
    continents ['foo', 'bar']
  end
end
