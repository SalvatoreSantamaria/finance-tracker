class CreateFriendships < ActiveRecord::Migration[5.2]
  def change
    create_table :friendships do |t|
      t.belongs_to :user
      t.belongs_to :friend, class: 'User' #there is no friend model, it is actually User
      t.timestamps
    end
  end
end
