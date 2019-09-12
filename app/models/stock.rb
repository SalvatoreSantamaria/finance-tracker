class Stock < ApplicationRecord #stock model
  has_many :user_stocks
  has_many :users, through: :user_stocks
  
  def self.find_by_ticker(ticker_symbol) #look up stock in the db from the stocks table
    where(ticker: ticker_symbol).first
  end
 
 
  def self.new_from_lookup(ticker_symbol)
    begin
      client = IEX::Api::Client.new(publishable_token: 'pk_731ed7a1fdad41a882811eb1b2b0e3ac')
      looked_up_stock = client.quote(ticker_symbol)
      new(name: looked_up_stock.company_name, #new stock object with stock name, stock ticker, and stock last price
        #is this working correctly? currenly, i can access in rails console with .company_name, .symbol, .latest_price
          ticker: looked_up_stock.symbol, last_price: looked_up_stock.latest_price)
    rescue Exception => e #catch exception - this method only works if something returns, otherwise returns nil
      return nil
    end
  end
end
