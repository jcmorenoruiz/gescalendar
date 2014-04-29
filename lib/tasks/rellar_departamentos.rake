
namespace :db do

	desc "Rellenar base de datos con departamentos"
	task populate: :environment do
		Department.create!(nombre: "Central")

		3.times do |n|
			name= "departamento-#{n+1}"
		
			Department.create!(nombre: name
							)

		end
	end



end