class StoreController < ApplicationController
	skip_before_filter :authorize
	
  def index
  	@products = Product.all
  	@cart = current_cart
  	@counter = session[:counter]
  	@counter.nil? ? @counter = 1 : @counter+=1
  	session[:counter] = @counter
  	if session[:counter] > 5
  		return session[:counter]
  	end
  end

end
