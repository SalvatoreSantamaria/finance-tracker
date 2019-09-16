class UserStocksController < ApplicationController
    def create
        #create table row for user_stock and enter it
        stock = Stock.find_by_ticker(params[:stock_ticker]) #grabbing stock symbol
        if stock.blank? #if couldnt find it in the table
            stock = Stock.new_from_lookup(params[:stock_ticker]) #method in stock.rb
            stock.save
        end
        @user_stock = UserStock.create(user: current_user, stock: stock) #create UserStock instance variable
        flash[:success] = "Stock #{@user_stock.stock.name} was successfully added to your portfolio" 
        redirect_to my_portfolio_path
    end

    def destroy
        stock = Stock.find(params[:id]) #based in this stock we have to find the associate, so we can delete the association
        @user_stock = UserStock.where(user_id: current_user.id, stock_id: stock.id).first #without .first, it just returns association, we need the object, which is was .first is doing
        @user_stock.destroy
        flash[:notice] = "Stock was successfully removed from portfolio"
        redirect_to my_portfolio_path
    end

end
