require 'rails_helper'

feature 'View post', %q{
  In order to read the post
  I need to be able to view post
  and comments to that post
} do
  given(:user) { create(:user) }
  # given(:post) { create(:post_with_comments) }
  given(:authors_post) { create(:post, user: user) }

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

    # scenario 'sees subscribe link' do
    #   visit post_path(post)
    #
    #   expect(page).to have_link 'Subscribe'
    # end

    # scenario 'author does not see subscribe link' do
    #   visit post_path(authors_post)
    #
    #   expect(page).to_not have_link 'Subscribe'
    #   expect(page).to have_link 'Unsubscribe'
    # end

    # scenario 'if user has been unsubscribed, he see subscribe link' do
    #   visit post_path(authors_post)
    #
    #   click_on 'Unsubscribe'
    #   expect(page).to have_link 'Subscribe'
    #   expect(page).to_not have_link 'Unsubscribe'
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

    # scenario 'does not see subscribe link' do
    #   visit post_path(post)
    #
    #   expect(page).to_not have_link 'Subscribe'
    # end
  end
end
