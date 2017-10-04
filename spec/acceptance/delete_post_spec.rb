require 'rails_helper'

feature 'Author deletes post', %q{
  Author can delete his post
  but could not delete someone else's post
} do

  given(:user) { create(:user) }
  given(:author) { create(:user) }
  given(:post) { create(:post, user: author) }

  scenario 'Author tries to delete his post' do
    sign_in(author)

    visit post_path(post)
    click_on 'Delete post'

    expect(page).to have_no_content post.title
  end

  scenario 'User tries to delete post that does not belongs to him' do
    sign_in(user)

    visit post_path(post)
    expect(page).to have_no_content 'Delete post'
  end

  scenario 'Unauthenticated user tries to delete post' do
    visit post_path(post)

    expect(page).to have_no_content 'Delete post'
  end
end
