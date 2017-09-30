require 'rails_helper'

feature 'Posts list', %q{
  In order to find the required answer,
  the user should have the opportunity
  to view the list of posts
} do
  given!(:posts) { create_list(:post, 2) }
  given(:user) { create(:user) }

  scenario 'Authenticated user views list of posts' do
    sign_in(user)
    visit_and_check_post
  end

  scenario 'Unauthenticated user views list of post' do
    visit_and_check_post
  end

  private

  def visit_and_check_post
    visit posts_path

    expect(page).to have_content posts.first.title
    expect(page).to have_content posts.last.title
  end
end
