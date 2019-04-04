FactoryBot.define do
  factory :event do
    title { 'Event title' }
    starts_at { Date.today }
    ends_at { Date.today + 3.days }
  end
end
