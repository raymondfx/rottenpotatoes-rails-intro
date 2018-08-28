class Movie < ActiveRecord::Base
  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end
  def self.movies(filters,sort_field)
  	return self.order(sort_field) if not filters
  	self.where({:rating => filters.keys}).order(sort_field)
  end

  def self.ratings
  	self.pluck(:rating).uniq
  end

  def self.set_options(params, session)
  	setup = {}

  	setup[:ratings] = if params[:ratings]
  		params[:ratings]
  	elsif session[:ratings]
       session[:ratings]
  	else
  	  self.ratings     
   end

   setup[:order_by] = if params[:order_by]
  		params[:order_by]
  	elsif session[:order_by]
       session[:order_by]
  	else
  	  nil   
   end

   setup
  end
end