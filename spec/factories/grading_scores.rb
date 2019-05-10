FactoryBot.define do
  factory :grading_score do
    grading_system { nil }
    name { "MyString" }
    score { 1 }
  end
end
