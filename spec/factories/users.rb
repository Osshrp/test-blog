FactoryGirl.define do
  sequence :email do |n|
    "user#{n}@test.com"
  end

  factory :user do
    email
    password '123456'
    password_confirmation '123456'

    factory :user_with_posts do
      transient do
        posts_count 2
      end

      after(:create) do |user, evaluator|
        create_list(:post, evaluator.posts_count, user: user)
      end
    end

    factory :user_with_comments do
      transient do
        comments_count 2
      end

      after(:create) do |user, evaluator|
        create_list(:comment, evaluator.comments_count, user: user)
      end
    end
  end
end
