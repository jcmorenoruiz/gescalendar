class StaticPagesController < ApplicationController
	include SessionsHelper 	# incluimos
  def home
  		if signed_in?	
        if superadmin_user?
          redirect_to  admin_path
        else
          redirect_to current_user
        end
  			
  		end 
  end

  def help
  end

  def about
  end

  def contact

  end
end
