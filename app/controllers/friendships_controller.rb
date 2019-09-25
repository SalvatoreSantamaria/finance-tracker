class FriendshipsController < ApplicationController

    def destroy
        @friendship = current_user.friendships.where(friend_id: params[:id]).first #using first to grab the object (otherwise grabs the association)
        @friendship.destroy
        flash[:notice] = "Friend was successfully removed"
        redirect_to my_friends_path
    end

end