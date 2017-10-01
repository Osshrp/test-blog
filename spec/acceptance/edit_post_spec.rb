require 'rails_helper'

feature 'Post editing', %q{
  In order to fix mistake
  as an author of post
  I'd like to be able to edit post
} do

  given(:user) { create(:user) }
  given(:another_user) { create(:user) }
  given!(:post) { create(:post, user: user) }

  scenario 'Unuthenticated user tries to edit post' do
    visit post_path(post)

    expect(page).to_not have_link 'Edit'
  end

  describe 'Authenticated user' do
    before do
      sign_in(user)
      visit post_path(post)
    end
    scenario 'sees post edit link' do
      within '.post' do
        expect(page).to have_link 'Edit post'
      end
    end
    scenario 'tries to edit his post' do

      click_on 'Edit post'
      fill_in 'Title', with: 'edited post title'
      fill_in 'Body', with: 'edited post body'
      check 'publicate'
      click_on 'Save'

      expect(page).to_not have_content post.body
      expect(page).to have_content 'edited post body'
      expect(page).to have_content 'published'
      expect(page).to_not have_selector 'text_field'
      expect(page).to_not have_selector 'textarea'
      expect(page).to have_link 'Edit post'
      within '.panel-heading' do
        expect(page).to_not have_content post.title
        expect(page).to have_content 'edited post title'
      end
    end

    scenario "tries to edit other user's post" do
      click_on 'Sign out'
      sign_in(another_user)
      visit post_path(post)

      expect(page).to_not have_link 'Edit'
    end
  end
end
