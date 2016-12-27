FactoryGirl.define do
  factory :photo do
    
  end
  factory :ad do
    before(:create) do |ad|
      category = FactoryGirl.create(:category)
      country  = FactoryGirl.create(:country)
      region   = FactoryGirl.create(:region, country_id: country.id)
      city     = FactoryGirl.create(:city, region_id: region.id)
      ad.category_id = category.id
      ad.city_id     = city.id
    end
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
    factory :user1 do
      email 'user@example.com'
      password 'secret'
      after(:create) do |user|
        create(:ad, user_id: user.id)
      end
    end
    factory :user2 do
      email 'user_with_ad@example.com'
      password 'secret'
      after(:create) do |user|
        create(:ad, user_id: user.id)
      end
    end
  end

  factory :article do
    title 'From Russia with love'
    content 'Some content'
  end
end
