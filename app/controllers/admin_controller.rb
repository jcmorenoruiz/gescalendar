class AdminController < ApplicationController

	 before_action :signed_in_user
	 before_action :superadmin_user

  def index
    # employess active
    @total_users=Employee.count
    enterprise_on = Enterprise.where(:status => 't').pluck(:id)
    department_on = Department.where(:status => 't', :enterprise_id => enterprise_on).pluck(:id)

    @active_user=Employee.where(:status =>'t',:department_id => department_on).count
    @percent_users = ((@active_user.to_f / @total_users) * 100).round(0)

    # enterprise active
    @total_emp=Enterprise.count
    @active_emp = enterprise_on.count
    @percent_emp = ((@active_emp.to_f / @total_emp) * 100).round(0)

    # new employees last 30 days
    @last_users = Employee.where('created_at >= ?',Time.now.beginning_of_month).count
    # new enterprises last 30 days
    @last_emp = Enterprise.where('created_at >= ? ',Time.now.beginning_of_month).count

    # total requests.
    @last_requests = Request.where('created_at >= ?',Time.now.beginning_of_month).count
    # requests last 24h
    @total_requests = Request.all.count

    # enterprise with activity reciente

    # last calendar.
    @last_calendar = DefaultCalendar.where(:status => 't').order(:anio).first

  end



  def summarize

    @request= Array.new
    @availabilities= Array.new
    @calendars = Array.new
    @employees = Array.new
  	# get all enterprises
  	@enterprises=Enterprise.where('empresa != ?','GesCalendar')

  	@enterprises.each do |emp|
      @employees[emp.id] = 0
      @request[emp.id]=0
      @availabilities[emp.id]=0
      @calendars[emp.id] = 0

      @request[emp.id]+=Request.where(:employee_id => Employee.where(:department_id => Enterprise.find(emp.id).departments.pluck(:id))).count
  		# departments
  		emp.departments.each do |dpto|
  			@employees[emp.id]+=dpto.employees.count
        @availabilities[emp.id]+=dpto.availabilities.count
        @calendars[emp.id]+=dpto.calendars.count
      end
  	end

  end

  def stats
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
