class StaticPagesController < ApplicationController
	include SessionsHelper 	# incluimos
  def home
  		if signed_in?	
  			redirect_to  current_user
  		end 
  end

  def help
  end

  def about
  end

  def contact

  end
end
