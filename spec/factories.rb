FactoryGirl.define do
  factory :photo do
  end

  factory :ad do
    category_id 1
    location_id 1
    title 'Продам комбайн т-800'
    content 'MyText'
    price 1200
  end

  factory :location do
    name 'Чита'
  end

  factory :profile do
    name nil
    user nil
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
