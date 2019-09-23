class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :user_stocks
  has_many :stocks, through: :user_stocks

  #many to many association, there is no friend model (it does not exist)
  has_many :friendships
  has_many :friends, through: :friendships

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
  def full_name
    return "#{first_name} #{last_name}".strip if (first_name || last_name) #return this if true
    "Anonymous" #return if false
  end

  def self.search(param) #seeing if anything matches the below, will return multiple answers due to 'like' in self.matches db query- but only 
    #unique ones due to the .uniq below
    param.strip! #to get ride of any extra spaces
    param.downcase!
    to_send_back = (first_name_matches(param) + last_name_matches(param) + email_matches(param)).uniq #.uniq is to eliminate any duplicates
    return nil unless to_send_back
    to_send_back
  end

  def self.first_name_matches(param)
    matches('first_name', param)
  end

  def self.last_name_matches(param)
    matches('last_name', param)
  end

  def self.email_matches(param)
    matches('email', param)
  end

  def self.matches(field_name, param)
    User.where("#{field_name} like ?", "%#{param}%") 
  end

end
