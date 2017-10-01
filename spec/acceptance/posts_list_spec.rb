require 'rails_helper'

feature 'Posts list', %q{
  In order to find the required post,
  the user should have the opportunity
  to view the list of posts
} do
  given!(:unpublished_posts) { create_list(:post, 2) }
  given!(:published_posts) { create_list(:post, 2, is_published: true) }
  given(:user) { create(:user) }
  given!(:users_posts) { create_list(:post, 2, user: user) }

  scenario 'Authenticated user views list of posts' do
    sign_in(user)
    visit_and_check_post
  end

  scenario 'Unauthenticated user views list of post' do
    visit_and_check_post
  end

  scenario 'Author sees list of all his posts' do
    sign_in(user)
    visit root_path

    click_on 'My posts'

    expect(page).to have_content users_posts.first.title
    expect(page).to have_content users_posts.last.title
  end

  private

  def visit_and_check_post
    visit posts_path

    expect(page).to have_content published_posts.first.title
    expect(page).to have_content published_posts.last.title
    expect(page).to_not have_content unpublished_posts.first.title
    expect(page).to_not have_content unpublished_posts.last.title
  end
end
