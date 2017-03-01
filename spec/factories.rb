FactoryGirl.define do
  factory :photo do
  end

  factory :ad do
    category_id 1
    city_id 1
    title 'MyString'
    content 'MyText'
    price 1200
  end

  factory :city do
    name 'Чита'
  end

  factory :region do
    name 'Забайкальский край'
  end

  factory :country do
    name 'Россия'
    short_name 'RU'
  end

  factory :profile do
    name nil
    user nil
    city nil
  end

  factory :category do
    name 'Сельскохозяйственная техника'
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
