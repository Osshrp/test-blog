require 'rails_helper'

RSpec.describe CommentsController, type: :controller do

  let(:new_post) { create(:post) }
  let(:comment) { create(:comment, post: new_post) }
  let(:users_comment) { create(:comment, post: new_post, user: @user) }

  describe 'POST #create' do
    context 'with valid attributes' do
      sign_in_user
      it 'associates comment with the user' do
        expect { post :create, params: { post_id: new_post,
                comment: { body: 'Test body' } }}
                .to change(new_post.comments, :count).by(1)
      end

      it 'associates comment with the @comment' do
        expect { post :create, params: { post_id: new_post,
                 comment: { body: 'Test body' } }}
                 .to change(@user.comments, :count).by(1)
      end
    end

    context 'with invalid attributes' do
      it 'does not save the comment' do
        expect { post :create, params: { post_id: new_post,
          comment: { body: nil } } }
          .to_not change(Comment, :count)
      end
    end
  end

  context 'unauthenticated user tries to create comment' do
    it 'does not creates comment' do
      expect { post :create, params: { post_id: new_post,
               comment: { body: 'Test body' } } }
               .to change(new_post.comments, :count).by(0)
    end
  end

  describe 'DELETE #destroy' do
    context 'author user tries to delete comment' do
      sign_in_user
      it 'deletes comment' do
        users_comment
        expect { delete :destroy, params: { id: users_comment } }
          .to change(Comment, :count).by(-1)
      end
    end
    context 'user tries to delete another_users comment' do
      sign_in_user
      it ' does not delete comment' do
        comment
        expect { delete :destroy, params: { id: comment } }
          .to change(Comment, :count).by(0)
      end
    end

    context 'guest tries to delete comment' do
      it ' does not delete comment' do
        comment
        expect { delete :destroy, params: { id: comment } }
          .to change(Comment, :count).by(0)
      end
    end
  end
end
