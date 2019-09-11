class StocksController < ApplicationController
    def search
        if params[:stock].present? #if stock exists
            @stock = Stock.new_from_lookup(params[:stock]) #storing in stock object, stock class is returning object back
            #render json: @stock #this will render in json on page! 
            if @stock    
                respond_to do |format| #responds to js format - this is for using ajax
                format.js {render partial: 'users/result'}
            end
        else
            respond_to do |format|
                flash.now[:danger] = "You have entered an incorrect ticker symbol" #.now keeps flash limited to 1 request cycle
                format.js { render partial: 'users/result' }
            end
        end       
        else
            respond_to do |format|
                flash.now[:danger] = "Cannot enter an empty search string"
            format.js { render partial: 'users/result' }
            end    
        end
    end
# from text directions
#   def search
#     @stock = Stock.new_from_lookup(params[:stock])
#     render 'users/my_portfolio'
#   end
end