# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Doctor.create!(name:  "Example Doctor",
             date_of_birth: "1985/10/22",
             job_title: "Example Doctor",
             address: "40 Main Street",
             contact_number: "0851234567",
             email: "example@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar")

99.times do |n|
  name  = Faker::Name.name
  date_of_birth = rand(Date.civil(1950, 1, 1)..Date.civil(2000, 12, 31))
  job_title = "Example Doctor"
  address = "40 Main Street"
  contact_number = "0851234567"
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  Doctor.create!(name:  name,
               date_of_birth: date_of_birth,
               job_title: job_title,
               address: address,
               contact_number: contact_number,
               email: email,
               password:              password,
               password_confirmation: password)
end
