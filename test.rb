class MegaAnfitrion

	attr_accessor :nombres

	# build object
	def initialize(nombres ="Mundo")
		@nombres=nombres
	end

	# say Hello
	def decir_hola
		if  @nombres.nil?
			puts "nothing...."
		elsif @nombres.respond_to?("each")
							
							@nombres.each do |nombre|
								puts "Hola #{nombre}"
							end
		else
			puts "Hola #{@nombres}"
		end
	end


	# say bye
	def decir_adios
		if @nombres.nil?
			puts "nothing..."
		elsif @nombres.respond_to?("join")
			puts "Adiós #{@nombres.join(", ")}. Vuelvan pronto." 
		else 
			puts "Adiós #{@nombres}. Vuelve pronto."
		end
	end
end

if __FILE__==$0

	ma=MegaAnfitrion.new
	ma.decir_hola
	ma.decir_adios

	ma.nombres="Diego"
	ma.decir_hola
	ma.decir_adios

	ma.nombres= ["Alberto","Beatriz","Carlos","David","Ernesto"]
	ma.decir_hola
	ma.decir_adios

	ma.nombres=nil
	ma.decir_hola
	ma.decir_adios

end