FactoryBot.define do
  factory :genre do
    name { Faker::Book.genre }
    description { Faker::Lorem.sentence(word_count: 10) }

    trait :with_books do
      after(:create) do |genre|
        create_list(:book, 3, genres: [genre])
      end
    end
  end
end
