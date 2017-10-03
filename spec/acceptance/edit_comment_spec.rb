require 'rails_helper'

feature 'Comment editing', %q{
  In order to fix mistake
  as an author of comment
  I'd like to be able to edit comment
} do

  given(:user) { create(:user) }
  given(:another_user) { create(:user) }
  given!(:post) { create(:post, user: user, is_published: true) }
  given!(:comment) { create(:comment, post: post, user: user) }

  scenario 'Unuthenticated user tries to edit comment' do
    visit post_path(post)

    within "#comment-#{comment.id}" do
      expect(page).to_not have_link 'Edit'
    end
  end

  describe 'Authenticated user' do
    before do
      sign_in(user)
      visit post_path(post)
    end
    scenario 'sees comment edit link' do
      within "#comment-#{comment.id}" do
        expect(page).to have_link 'Edit'
      end
    end
    scenario 'tries to edit his comment' do

      click_on 'Edit'
      fill_in 'Body', with: 'edited comment body'
      click_on 'Save'

      within "#comment-#{comment.id}" do
        expect(page).to_not have_content comment.body
        expect(page).to have_content 'edited comment body'
        expect(page).to have_link 'Edit'
      end
    end

    scenario "tries to edit other user's comment" do
      click_on 'Sign out'
      sign_in(another_user)
      visit post_path(post)

      within "#comment-#{comment.id}" do
        expect(page).to_not have_link 'Edit'
      end
    end
  end
end
