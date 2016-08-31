FactoryGirl.define do
  factory :user do
    email 'user@example.com'
    password 'secret'
  end

  factory :article do
    title 'From Russia with love'
    content 'Some content'
  end
end
