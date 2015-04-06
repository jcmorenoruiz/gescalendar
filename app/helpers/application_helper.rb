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



  def link_to_remove_fields(name, f, options = {})
  	f.hidden_field(:_destroy) + link_to(name, "#", title: "", onclick: "remove_fields(this); return false;")
  end

  def link_to_add_fields(name, f, association, options = {})
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{ association }", :onsubmit => "return $(this.)validate();") do |builder|
      render(association.to_s.singularize + "_fields", :f => builder)
  end
		link_to name, "#", class: "", title: "", onclick: "add_fields_availability(this, \"#{ association }\", \"#{ escape_javascript(fields) }\"); return false;"
  end

  
end
