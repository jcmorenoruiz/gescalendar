module RequestsHelper

  def weekdays_in_date_range(range,calendar)
      

      # You could modify the select block to also check for holidays
      range.select { |d| (1..5).include?(d.wday) && working_day(d,calendar) }.size
  end

  def working_day(d,calendar)

      if calendar.line_calendars.nil?
        return true
      else
           calendar.line_calendars.each do |line|
            if(line.fecha==d)
                  return false
            end
           end 
      end
      return true
  end

  def pending_requests

  	if chief_user?      
        pending_requests=Request.where(:status => 1,:request_type_id => Department.find(current_user.department_id).request_types).paginate(page: params[:page])
    else admin_user?        
        pending_requests=Request.where(:status => 1,:employee_id => 
        					Employee.where(:department_id => Department.where(:enterprise_id => current_emp))
        				).count
    end

  end
end
