class AddUserIdToPosts < ActiveRecord::Migration[5.0]
  def change
    add_belongs_to :posts, :user
  end
end
