FactoryGirl.define do
  factory :user do
    email 'user@example.com'
    password 'secret'
  end

  factory :article do
    title 'Hello World'
    content 'Some content'
  end
end
