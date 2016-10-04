FactoryGirl.define do
  factory :profile do
    
  end
  factory :category do
    
  end
  factory :user do
    email 'user@example.com'
    password 'secret'
  end

  factory :article do
    title 'From Russia with love'
    content 'Some content'
  end
end
