require 'rails_helper'

feature 'Create comment', %q{
  In order to clarify the issue,
  the user can create comments to post
} do

  given(:user) { create(:user) }
  given(:post) { create(:post, user: user, is_published: true) }
  given(:another_user) { create(:user) }
  given(:another_post) { create(:post, user: another_user, is_published: true) }

  context 'Authenticated user' do
    scenario 'tries to create comment to his post' do
      sign_in(user)
      visit post_path(post)
      within '.comments' do
        fill_in 'Comment', with: 'Text of comment'
        click_on 'New comment'
      end
      expect(page).to have_content 'Text of comment'
    end
    scenario "tries to create comment to another user's post" do
      visit post_path(another_post)
      within '.comments' do
        expect(page).to have_no_field('Comment')
        expect(page).to have_no_button 'New comment'
      end
    end
  end

  context 'Guest' do
    scenario 'tries to create comment to post' do
      visit post_path(post)
      within '.comments' do
        expect(page).to have_no_link 'New comment'
      end
    end
  end
end
