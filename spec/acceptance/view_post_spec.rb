require 'rails_helper'

feature 'View post', %q{
  In order to read the post
  I need to be able to view post
  and comments to that post
} do
  given(:user) { create(:user) }
  # given(:post) { create(:post_with_comments) }
  given(:authors_post) { create(:post, user: user, is_published: true) }
  given(:unpublished_post) { create(:post, user: user) }

  context 'Authenticated user' do
    before { sign_in(user) }
    scenario 'sees the post and comments to that post' do
      visit post_path(authors_post)

      expect(page).to have_content 'MyString'
      expect(page).to have_content 'MyText'
      # post.answers.each do |answer|
      #   expect(page).to have_content answer.body
      # end
    end

    # scenario 'author sees publish link' do
    #   visit post_path(authors_post)
    #
    #   expect(page).to have_link 'Publish'
    #   expect(page).to_not have_link 'Unpublish'
    # end

    # scenario 'if post has been published, he see unbublish link' do
    #   visit post_path(authors_post)
    #
    #   click_on 'Publish'
    #   expect(page).to have_link 'Unpublish'
    #   expect(page).to_not have_link 'Publish'
    # end
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

    # scenario 'does not see publish link' do
    #   visit post_path(authors_post)
    #
    #   expect(page).to_not have_link 'Publish'
    # end

    scenario 'does not view the unpublished post' do
      visit post_path(unpublished_post)

      expect(page).to_not have_content 'MyString'
      expect(page).to_not have_content 'MyText'
    end
  end
end
