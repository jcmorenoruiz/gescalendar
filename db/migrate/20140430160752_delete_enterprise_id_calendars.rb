class DeleteEnterpriseIdCalendars < ActiveRecord::Migration
  def change
  	rename_column :calendars, :enterprise_id, :department_id
  end
end
