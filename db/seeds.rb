# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
r = Random.new

for i in 0..20
    User.create(email:"user#{i}@test.com",password: "123456",name:"user#{i}",contact: "#{i}233289",dob: "Thu, #{i} Mar 2001 18:23:00.000000000 UTC +00:00",department_id: r.rand(5..8))
    puts "user#{i} created"
end