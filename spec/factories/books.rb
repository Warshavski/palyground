FactoryBot.define do
  factory :book do
    title { Faker::Book.title }
    published_in { Date.current }
    authors { create_list(:author, 1) }
    publisher { create(:publisher) }
    after(:build) do |book, evaluator|
      book.genres << evaluator.genres if evaluator.genres.present?
    end
  end
end
