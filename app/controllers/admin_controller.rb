class AdminController < ApplicationController

	 before_action :signed_in_user
	 before_action :superadmin_user

  def index
  		@activos=Array.new
  	@baja=Array.new

  	# get all enterprises
  	@enterprises=Enterprise.where('empresa != ?','GesCalendar')
  	
  	@enterprises.each do |emp|
  		@activos[emp.id]=0
  		@baja[emp.id]=0
  		# departments
  		emp.departments.each do |dpto|
  			@activos[emp.id]+=dpto.employees.where(status: true).count
  			@baja[emp.id]+=dpto.employees.where(status: false).count
  		end
  	end

  end

  def resumen
  		#params
  		@year=!params[:date].blank? ?  params[:date][:year].to_i : Time.now.year 
  		@month=!params[:date].blank? ? params[:date][:month].to_i : Time.now.month
  		
  		@enterprises=Enterprise.where('extract(year from created_at) = ?',@year).where('extract(month from created_at) = ?',@month).group_by_day(:created_at).count
  		@employees=Employee.unscoped.where('extract(year from created_at) = ?',@year).where('extract(month from created_at) = ?',@month).group_by_day(:created_at).count
  		
  		ranges = Hash.new(0)
  		ranges['<10']=0
  		ranges['10-25']=0
  		ranges['26-50']=0
  		ranges['51-100']=0

  		Enterprise.with_range_stats.each do |enterprise|
  			ranges[enterprise.range_employees]+=1
  		end

  		@range_employees=ranges

  end
end
