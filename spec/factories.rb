FactoryBot.define do
  factory :user do
    email "test@example.com"
    password "qwerty"
  end

  factory :post do |p|
    p.sequence(:title) { |p| "Post title #{p}" }
    p.sequence(:body) { |p| "Post body #{p}" }
  end

  factory :comment do
    name "Comment name"
    body "Comment body"
  end
end