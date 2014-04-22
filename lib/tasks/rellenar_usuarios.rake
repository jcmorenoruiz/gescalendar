
namespace :db do

	desc "Rellenar base de datos con usuarios de ejemplo"
	task populate: :environment do
		Employee.create!(name:" Empleado",
						 email: "ejemplo@gmail.com",
						 password: "testpass",
						 password_confirmation: "testpass")

		99.times do |n|

			name= Faker::Name.name
			email = "example-#{n+1}@gmail.com"
			password ="password"
			Employee.create(name: name,
							email: email,
							password: password,
							password_confirmation: password)
	
		end
	end



end