FactoryBot.define do
  factory :assessment_result do
    user { nil }
    assessment { nil }
    score { "9.99" }
    status { "MyString" }
  end
end
