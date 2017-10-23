class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user

  validates :body, presence: true

  def can_change?
    (created_at + 15.minutes) > Time.zone.now
  end
end
