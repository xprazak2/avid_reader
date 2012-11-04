FactoryGirl.define do 
  factory :user do
    sequence(:name) { |n| "Unknown Soldier #{n}"}
    sequence(:email){ |n| "bloody#{n}@hell.com"}
    password "foobar"
    password_confirmation "foobar"

    factory :admin do
      admin true
    end
  end

  factory :book do
    sequence(:author) {|n| "Anonymous#{n}"}
    sequence(:title) {|n| "Forgotten memories#{n}"}
  end
end


