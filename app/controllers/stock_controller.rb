class Stock < ActionRecord::Base
    def self.new_from_lookup(ticker_symbol)
        looked_up_stock = StockQuote::Stock.new(api_key: pk_731ed7a1fdad41a882811eb1b2b0e3ac)
        new(name: lookup_up_stock)
    end
end
