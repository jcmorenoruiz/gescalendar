module RequestsHelper

  def weekdays_in_date_range(range,calendar)
      # You could modify the select block to also check for holidays
      range.select { |d| (week_working_days(calendar)).include?(d.wday) && working_day(d,calendar) }.size
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

  def week_working_days(calendar)
        return [calendar.d1 ? 1:0,calendar.d2 ? 2:0,calendar.d3 ? 3:0,calendar.d4 ? 4:0,calendar.d5 ? 5:0,calendar.d6 ? 6:0,calendar.d7 ? 7:0]
  end

  def pending_requests

  	if chief_user?
        pending_requests=Request.where(:status => 1,:employee_id=> current_user.department.employees)
          .where.not(employee_id: current_user.id).count
    else admin_user?
        pending_requests=Request.where(:status => 1,:employee_id =>Employee.where(:department_id => current_emp.departments)).count
    end

  end
end
