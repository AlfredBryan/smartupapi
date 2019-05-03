FactoryBot.define do
  factory :topic do
    name { "MyString" }
    course { nil }
    rank { 1 }
    active { false }
    description { "MyText" }
  end
end
