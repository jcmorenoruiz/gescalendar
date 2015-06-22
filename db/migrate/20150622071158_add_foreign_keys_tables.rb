class AddForeignKeysTables < ActiveRecord::Migration
  def change
    add_foreign_key :employees, :departments
    add_foreign_key :calendars, :departments
    add_foreign_key :line_calendars, :calendars
    add_foreign_key :availabilities, :departments
    add_foreign_key :departments, :enterprises
    add_foreign_key :request_types, :enterprises
    add_foreign_key :default_line_calendars, :default_calendars
    add_foreign_key :departments_request_types, :departments
    add_foreign_key :departments_request_types, :request_types
  end
end
