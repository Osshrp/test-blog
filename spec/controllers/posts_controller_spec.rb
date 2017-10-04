require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let(:published_post) { create(:post, is_published: true) }
  let(:unpublished_post) { create(:post) }
  describe 'GET #index' do
    let(:unpublished_posts) { create_list(:post, 2) }
    let(:published_posts) { create_list(:post, 2, is_published: true) }

    before { get :index }

    it 'populates an array of published posts' do
      expect(assigns(:posts)).to match_array(published_posts)
    end

    it 'does not populate an array with unpublished_posts' do
      expect(assigns(:posts)).to_not match_array(unpublished_posts)
    end

    it 'renders index view' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    context 'guest tries to see publish post' do
      before { get :show, params: { id: published_post } }

      it 'assigns requested post to @post' do
        expect(assigns(:post)).to eq published_post
      end

      it 'renders show view' do
        expect(response).to render_template :show
      end
    end

    context 'author tries to see unpublish post' do
      sign_in_user
      let(:authors_unpublished_post) { create(:post, user: @user) }
      before { get :show, params: { id: authors_unpublished_post } }

      it 'assigns requested post to @post' do
        expect(assigns(:post)).to eq authors_unpublished_post
      end

      it 'renders show view' do
        expect(response).to render_template :show
      end
    end

    context 'guest tries to see unpublished post' do
      before { get :show, params: { id: unpublished_post } }

      it 'assigns requested post to @post' do
        expect(assigns(:post)).to eq unpublished_post
      end

      it 'redirects to root path' do
        expect(response).to redirect_to root_path
      end
    end

    context 'another user tries to see unpublished post' do
      sign_in_user
      before { get :show, params: { id: unpublished_post } }

      it 'assigns requested post to @post' do
        expect(assigns(:post)).to eq unpublished_post
      end

      it 'redirects to root path' do
        expect(response).to redirect_to root_path
      end
    end
  end

  describe 'GET #new' do
    sign_in_user
    before { get :new }
    it 'assigns a new Post to @post' do
      expect(assigns(:post)).to be_a_new(Post)
    end

    it 'renders new view' do
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    sign_in_user
    context 'with valid attributes' do

      it 'associates post with the user' do
        expect { post :create, params: { post: attributes_for(:post) } }
          .to change(@user.posts, :count).by(1)
      end

      it 'redirects to show view' do
        post :create, params: { post: attributes_for(:post) }
        expect(response).to redirect_to post_path(assigns(:post))
      end
    end

    context 'with invalid attributes' do
      it 'does not save the post' do
        expect { post :create, params: { post: attributes_for(:invalid_post) } }
          .to_not change(Post, :count)
      end

      it 're-renders new view' do
        post :create, params: { post: attributes_for(:invalid_post) }
        expect(response).to render_template :new
      end
    end
  end

  describe 'PATCH #update' do
    sign_in_user
    let!(:users_post) { create(:post, user: @user) }

    context 'with valid attributes' do
      it 'assigns the requested post to @post' do
        patch :update, params: { id: users_post,
          post: attributes_for(:post) }
        expect(assigns(:post)).to eq users_post
      end

      it 'change post attributes' do
        patch :update, params: { id: users_post,
          post: { title: 'new_title', body: 'new_body' } }
        users_post.reload
        expect(users_post.title).to eq 'new_title'
        expect(users_post.body).to eq 'new_body'
      end

      it 'redirects to updated @post' do
        patch :update, params: { id: users_post,
          post: attributes_for(:post) }
        expect(response).to redirect_to post_path(users_post)
      end
    end

    context 'with invalid attributes' do
      let(:title) { users_post.title }
      let(:body) { users_post.body }
      before do
        patch :update, params: { id: users_post,
          post: { title: 'new_title', body: nil } }
      end
      it 'does not change @post attributes' do
        users_post.reload
        expect(users_post.title).to eq title
        expect(users_post.body).to eq body
      end

      it 're-renders edit view' do
        expect(response).to render_template :edit
      end
    end

    context 'user tries to update post that does not belong to him' do
      let(:title) { unpublished_post.title }
      let(:body) { unpublished_post.body }
      before do
        patch :update, params: { id: unpublished_post,
          post: { title: 'new_title', body: 'new_body' } }
      end
      it 'does not update post attributes' do
        unpublished_post.reload
        expect(unpublished_post.title).to eq title
        expect(unpublished_post.body).to eq body
      end
    end
  end

  describe 'DELETE #destroy' do
    sign_in_user
    let!(:users_post) { create(:post, user: @user) }
    before { users_post }

    context 'author tries to delete post' do
      it 'deletes post' do
        expect { delete :destroy, params: { id: users_post } }
          .to change(Post, :count).by(-1)
      end

      it 'redirects to index view' do
        delete :destroy, params: { id: users_post }
        expect(response).to redirect_to posts_path
      end
    end

    context 'user tries to delete post that does not belongs to him' do
      it 'does not deletes post' do
        expect { delete :destroy, params: { id: published_post } }
          .to_not change(Post, :count)
      end

      it 'redirects to posts index view' do
        delete :destroy, params: { id: published_post }
        expect(response).to redirect_to posts_path
      end
    end
  end
end
