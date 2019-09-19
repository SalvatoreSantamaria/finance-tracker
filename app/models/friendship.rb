class Friendship < ApplicationRecord
    belongs_to :user
    belongs_to :friend, :class_name => 'User' #there is no class friend, it is just being called friend, we are actually using class User
end
