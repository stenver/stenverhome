FactoryGirl.define do
  factory :user do
  	sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}
  	password "test123"
  	password_confirmation "test123"

  	factory :admin do
  		admin true
  	end
  end

  factory :article do
  	sequence(:title) { |n| "My test article" }
  	sequence(:text) { |n| "Lorem Ipsum" }
  	user
  end

  factory :comment do
    sequence(:text) { |n| "My Comment Text" }
    user
    article
  end
end
