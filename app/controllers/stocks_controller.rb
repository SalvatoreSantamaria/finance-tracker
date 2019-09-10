class StocksController < ApplicationController
    def search
        if params[:stock].present? #if stock exists
            @stock = Stock.new_from_lookup(params[:stock]) #storing in stock object, stock class is returning object back
            #render json: @stock #this will render in json on page! 
        if @stock    
            render 'users/my_portfolio'
        else
            flash[:danger] = "You have entered an incorrect ticker symbol"
            redirect_to my_portfolio_path
        end       
        else 
            flash[:danger] = "Cannot enter an empty search string"
            redirect_to my_portfolio_path
        end
    end
# from text directions
#   def search
#     @stock = Stock.new_from_lookup(params[:stock])
#     render 'users/my_portfolio'
#   end

end