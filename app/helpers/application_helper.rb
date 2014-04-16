module ApplicationHelper

	# Mostrar el titulo de la pagina por defecto
	def full_title(page_title)
		base_title="Gestión de Calendarios Laborales"
		if page_title.empty?
			base_title
		else
			"#{base_title} | #{page_title}  "
		end
	end 

end
