FactoryBot.define do
  factory :answer do
    answer_option { nil }
    state { "MyString" }
    user { nil }
    question { nil }
    content { "MyText" }
    content_url { "MyString" }
  end
end
