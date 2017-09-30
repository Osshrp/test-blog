require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:posts) }

  it { should validate_presence_of :email }
  it { should validate_presence_of :password }

  let(:user_with_posts) { create(:user_with_posts) }
  let(:user) { create(:user) }

  describe '#author_of' do
    it 'should return true so as user is author of the entity' do
      expect(user_with_posts).to be_author_of(user_with_posts.posts.first)
    end

    it '#author_of should return false so as user is not author of the entity' do
      expect(user).to_not be_author_of(user_with_posts.posts.first)
    end
  end
end
