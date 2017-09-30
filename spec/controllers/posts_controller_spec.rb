require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let(:post) { create(:post) }
  describe 'GET #index' do
    let(:posts) { create_list(:post, 2) }

    before { get :index }
    it 'populates an array of all posts' do
      expect(assigns(:posts)).to match_array(posts)
    end
    it 'renders index view' do
      expect(response).to render_template :index
    end
  end

  # describe 'GET #show' do
  #   before { get :show, params: { id: post } }
  #
  #   it 'assigns requested post to @post' do
  #     expect(assigns(:post)).to eq post
  #   end
  #
  #   it 'renders show view' do
  #     expect(response).to render_template :show
  #   end
  # end
  #
  # describe 'GET #new' do
  #   sign_in_user
  #   before { get :new }
  #   it 'assigns a new Post to @post' do
  #     expect(assigns(:post)).to be_a_new(Post)
  #   end
  #
  #   it 'renders new view' do
  #     expect(response).to render_template :new
  #   end
  # end
  #
  # describe 'POST #create' do
  #   sign_in_user
  #   context 'with valid attributes' do
  #
  #     it 'associates post with the user' do
  #       expect { post :create, params: { post: attributes_for(:post) } }
  #         .to change(@user.posts, :count).by(1)
  #     end
  #
  #     it 'redirects to show view' do
  #       post :create, params: { post: attributes_for(:post) }
  #       expect(response).to redirect_to post_path(assigns(:post))
  #     end
  #   end
  #
  #   context 'with invalid attributes' do
  #     it 'does not save the post' do
  #       expect { post :create, params: { post: attributes_for(:invalid_post) } }
  #         .to_not change(Post, :count)
  #     end
  #
  #     it 're-renders new view' do
  #       post :create, params: { post: attributes_for(:invalid_post) }
  #       expect(response).to render_template :new
  #     end
  #   end
  # end
  #
  # describe 'PATCH #update' do
  #   sign_in_user
  #   let!(:users_post) { create(:post, user: @user) }
  #
  #   context 'with valid attributes' do
  #     it 'assigns the requested post to @post' do
  #       patch :update, params: { id: users_post,
  #         post: attributes_for(:post) }, format: :js
  #       expect(assigns(:post)).to eq users_post
  #     end
  #
  #     it 'change post attributes' do
  #       patch :update, params: { id: users_post,
  #         post: { title: 'new_title', body: 'new_body' } }, format: :js
  #       users_post.reload
  #       expect(users_post.title).to eq 'new_title'
  #       expect(users_post.body).to eq 'new_body'
  #     end
  #
  #     it 'redirects to updated @post' do
  #       patch :update, params: { id: users_post,
  #         post: attributes_for(:post) }, format: :js
  #       expect(response).to render_template :update
  #     end
  #   end
  #
  #   context 'with invalid attributes' do
  #     let(:title) { users_post.title }
  #     let(:body) { users_post.body }
  #     before do
  #       patch :update, params: { id: users_post,
  #         post: { title: 'new_title', body: nil } }, format: :js
  #     end
  #     it 'does not change @post attributes' do
  #       users_post.reload
  #       expect(users_post.title).to eq title
  #       expect(users_post.body).to eq body
  #     end
  #
  #     it 're-renders edit view' do
  #       expect(response).to render_template :update
  #     end
  #   end
  #
  #   context 'user tries to update post that does not belong to him' do
  #     let(:title) { post.title }
  #     let(:body) { post.body }
  #     before do
  #       patch :update, params: { id: post,
  #         post: { title: 'new_title', body: 'new_body' } }, format: :js
  #     end
  #     it 'does not update post attributes' do
  #       post.reload
  #       expect(post.title).to eq title
  #       expect(post.body).to eq body
  #     end
  #
  #     it 'returns 403 status' do
  #       expect(response).to have_http_status(403)
  #     end
  #   end
  # end
  #
  # describe 'DELETE #destroy' do
  #   sign_in_user
  #   let!(:users_post) { create(:post, user: @user) }
  #   before { post }
  #
  #   context 'author tries to delete post' do
  #     it 'deletes post' do
  #       expect { delete :destroy, params: { id: users_post } }
  #         .to change(Post, :count).by(-1)
  #     end
  #
  #     it 'redirects to index view' do
  #       delete :destroy, params: { id: users_post }
  #       expect(response).to redirect_to posts_path
  #     end
  #   end
  #
  #   context 'user tries to delete post that does not belongs to him' do
  #     it 'does not deletes post' do
  #       expect { delete :destroy, params: { id: post } }
  #         .to_not change(Post, :count)
  #     end
  #
  #     it 'redirects to posts index view' do
  #       delete :destroy, params: { id: post }
  #       expect(response).to redirect_to posts_path
  #     end
  #   end
  # end
end
