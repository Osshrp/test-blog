require 'rails_helper'

RSpec.describe Comment, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:post) }

  it { should validate_presence_of :body }

  let(:comment) { create(:comment) }
  let(:comment2) { create(:comment, created_at: Time.now - 1.day) }

  describe '#can_change?' do
    it 'should returns true' do
      expect(comment.can_change?).to be_truthy
    end

    it 'should returns false if comment too old' do
      expect(comment2.can_change?).to be_falsey
    end
  end
end
