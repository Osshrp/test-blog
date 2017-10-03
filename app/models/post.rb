class Post < ApplicationRecord
  belongs_to :user
  has_many :comments

  validates :title, :body, presence: true

  acts_as_taggable_on :tags

  self.per_page = 5
end
