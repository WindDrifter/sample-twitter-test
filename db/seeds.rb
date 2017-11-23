# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

for i in 1..10
  user = User.create(username: "T_User#{i}",
              first_name: "FirstName#{i}",
              last_name: "LastName#{i}",
              email: "user#{i}@example.com",
              password: "TestUser#{i}"
   )
   for j in 1..10
     Post.create(user_id: user.id, content:"TestContent#{j} By user#{i}")
   end
end
