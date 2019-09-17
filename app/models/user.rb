class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :user_stocks
  has_many :stocks, through: :user_stocks

  def stock_already_added?(ticker_symbol) #checking to see if ticker symbol is already in users portfolio
    stock = Stock.find_by_ticker(ticker_symbol) #from Stock class
    return false unless stock #if stock isn't being tracked (no association)
    user_stocks.where(stock_id: stock.id).exists? #if it does exists, look for association where this stock.id is matched
  end

  def under_stock_limit? 
    (user_stocks.count < 10)
  end

  def can_add_stock?(ticker_symbol)
    under_stock_limit? && !stock_already_added?(ticker_symbol) #stock isn't already added to users portfolio, and stock is under the limit of 10
  end

  #adding method to return full name
  def fullname
    return "#{first_name} #{last_name}".strip if (first_name || last_name) #return this if true
    "Anonymous" #return if false
  end


end
