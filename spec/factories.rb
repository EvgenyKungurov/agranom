FactoryGirl.define do
  factory :phone do
    number "MyText"
    profile nil
  end
  factory :ad do
    name "MyString"
    content "MyText"
    user nil
    category nil
  end
  factory :city do
    name "MyString"
  end
  factory :region do
    name "MyString"
  end
  factory :contry do
    name ""
  end
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
