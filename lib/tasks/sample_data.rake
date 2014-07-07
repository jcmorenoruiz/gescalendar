namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do

    users = Employee.all(limit: 6)
    50.times do
      content = Faker::Lorem.sentence(5)
      users.each { |user| user.requests.create!(desde: '2014-05-05', hasta: '2014-05-02',motivo: content) }
    end
  end
end
