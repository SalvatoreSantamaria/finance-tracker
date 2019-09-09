class StocksController < ApplicationController
    def search
        @stock = Stock.new_from_lookup(params[:stock]) #storing in stock object, stock class is returning object back
        #render json: @stock #this will render in json on page! 
        render 'users/my_portfolio'
    end
# from text directions
#   def search
#     @stock = Stock.new_from_lookup(params[:stock])
#     render 'users/my_portfolio'
#   end

end