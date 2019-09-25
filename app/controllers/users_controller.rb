class UsersController < ApplicationController
    def my_portfolio
        @user = current_user # have to provide access for my_portfolio view and for partial _list.html.erb
        @user_stocks = current_user.stocks
    end

    def my_friends
        @friendships = current_user.friends # can do this because we have many to many association
    end
    
    def search
        if params[:search_param].blank? #checking search is present
            flash.now[:danger] = "You have entered an empty search string"
        else
            @users = User.search(params[:search_param])#@user is the entered user search result
            #filter out the users own name from the search results
            #current_user calling the except_current_user method, therefore
            @users = current_user.except_current_user(@users) 
            flash.now[:danger] = "No users match this search criteria" if @users.blank? #no matching returns this error
            end
            respond_to do |format|
            format.js { render partial: 'friends/result' }
            end
        end

    def add_friend
        @friend = User.find(params[:friend])
        current_user.friendships.build(friend_id: @friend.id) #building an association

        if current_user.save
            flash[:success] = "Friend was successfully added"
            redirect_to my_friends_path
        else 
            flash[:danger] = "There was something wrong with the friend request"
            redirect_to my_friends_path
        end
    end
        
    end
