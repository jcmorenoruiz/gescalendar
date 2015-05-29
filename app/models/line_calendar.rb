class LineCalendar < ActiveRecord::Base

	belongs_to :calendar
	default_scope { order('fecha ASC') }

	validates :dia, presence: true
	
	validates_uniqueness_of  :fecha, scope: :calendar_id

  validate :fecha_on_calendar_year

  def fecha_on_calendar_year
    if calendar_id.present?
      calendar = Calendar.find(calendar_id)
      if Date.parse(fecha.to_s).year != calendar.anio
        errors.add(:fecha, "La linea de calendario debe pertenecer al año del calendario.")
      end
    end
  end
  #validates_date :fecha, :between => [Date.current.year.to_s+'-01-01', ((Date.current.year)+1).to_s+'-12-31']
end
