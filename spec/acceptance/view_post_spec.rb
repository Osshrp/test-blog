require 'rails_helper'

feature 'View post', %q{
  In order to read the post
  I need to be able to view post
  and comments to that post
} do
  given(:user) { create(:user) }
  given(:another_user) { create(:user) }
  # given(:post) { create(:post_with_comments) }
  given(:authors_post) { create(:post, user: user, is_published: true) }
  given(:unpublished_post) { create(:post, user: user) }

  context 'Authenticated user' do
    scenario 'author sees the post and comments to that post' do
      sign_in(user)
      visit post_path(authors_post)

      expect(page).to have_content 'MyString'
      expect(page).to have_content 'MyText'
      # post.answers.each do |answer|
      #   expect(page).to have_content answer.body
      # end
    end

    scenario 'author sees his unpublished_post post and comments to that post' do
      sign_in(user)
      visit post_path(unpublished_post)

      expect(page).to have_content 'MyString'
      expect(page).to have_content 'MyText'
      # post.answers.each do |answer|
      #   expect(page).to have_content answer.body
      # end
    end

    scenario 'another user does not see unpublished post' do
      sign_in(another_user)
      visit post_path(unpublished_post)

      expect(page).to_not have_content 'MyString'
      expect(page).to_not have_content 'MyText'
    end
  end

  context 'Unauthenticated user' do
    scenario 'sees the posts and answers to that post' do
      visit post_path(authors_post)

      expect(page).to have_content 'MyString'
      expect(page).to have_content 'MyText'
      # post.answers.each do |answer|
      #   expect(page).to have_content answer.body
      # end
    end

    scenario 'does not view the unpublished post' do
      visit post_path(unpublished_post)

      expect(page).to_not have_content 'MyString'
      expect(page).to_not have_content 'MyText'
    end
  end
end
