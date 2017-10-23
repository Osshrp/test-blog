require 'rails_helper'

feature 'Create post', %q{
  In order to publish post
  as an authenticated user
  I need to be able to create posts
} do

  given(:user) { create(:user) }

  scenario 'Authenticated user create post' do
    sign_in(user)

    click_new_post_link
    fill_in 'Title', with: 'Question title'
    fill_in 'Body', with: 'text text'
    click_on 'Save'

    # expect(page).to have_content 'Your post successfully created'
    expect(page).to have_content 'Question title'
    expect(page).to have_content 'text text'
  end

  scenario 'Authenticated user tries to create post with blank fields' do
    sign_in(user)

    click_new_post_link
    click_on 'Save'

    expect(page).to have_content "Title can't be blank"
    expect(page).to have_content "Body can't be blank"
  end

  scenario 'Unauthenticated user create post' do
    click_new_post_link
    expect(page).to have_content 'You need to sign in or sign up before continuing'
  end

  private

  def click_new_post_link
    visit posts_path
    click_on 'New post'
  end
end
