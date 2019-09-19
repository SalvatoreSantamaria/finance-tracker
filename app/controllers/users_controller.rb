class UsersController < ApplicationController
    def my_portfolio
        @user = current_user # have to provide access for my_portfolio view and for partial _list.html.erb
        @user_stocks = current_user.stocks
    end

    def my_friends
        
    end
end