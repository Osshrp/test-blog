FactoryGirl.define do
  sequence :title do |n|
    "MyString#{n}"
  end

  factory :post do
    title
    body 'MyText'
    user

    factory :post_with_comments do
      transient do
        comments_count 5
      end

      after(:create) do |post, evaluator|
        create_list(:comment, evaluator.answers_count, post: post, user: post.user)
      end
    end
  end

  factory :invalid_post, class: 'Post' do
    title nil
    body nil
  end
end
