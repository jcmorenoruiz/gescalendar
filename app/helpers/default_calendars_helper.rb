module DefaultCalendarsHelper
	
	def show_status(status)
		if status==true
			return 'Activo'
		else
			return 'No Activo'
		end
	end

end
