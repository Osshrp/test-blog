require 'rails_helper'

feature 'Author deletes comment', %q{
  Author can delete his comment
  but could not delete someone else's comment
} do

  given(:user) { create(:user) }
  given(:post) { create(:post, is_published: true) }
  given!(:comment) { create(:comment, user: user, post: post, body: 'comment body') }
  given(:another_post) { create(:post) }
  given(:another_comment) { create(:comment, post: another_post) }

  scenario 'Author tries to delete his comment' do
    sign_in(user)

    visit post_path(post)
    within '.comments' do
      click_on 'Delete'
    end
    expect(page).to have_no_content 'comment body'
  end

  scenario 'Author tries to delete comment that does not belongs to him' do
    sign_in(user)

    visit post_path(another_post)
    expect(page).to have_no_content 'Delete comment'
  end

  scenario 'Unauthenticated user tries to delete comment' do
    visit post_path(comment.post)

    expect(page).to have_no_content 'Delete comment'
  end
end
