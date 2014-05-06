module ApplicationHelper

	# Mostrar el titulo de la pagina por defecto
	def full_title(page_title)
		base_title="Gestor de Vacaciones y Ausencias"
		if page_title.empty?
			base_title
		else
			"#{base_title} | #{page_title}  "
		end
	end 

	def bool_to_s(boolean)
    	boolean ? 'Activo' : 'Inactivo'
	end

end
