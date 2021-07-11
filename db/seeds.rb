require 'csv'

csv_data = CSV.read('db/Divesite02.csv', headers: true)
csv_data.each do |data|
  Divesite.create!(data.to_hash)
end

# 10.times do |n|
#   name = Faker::Games::Pokemon.name
#   email = Faker::Internet.email
#   password = "password"
#   divesite_id = 1 + n
#   uid = 1 + n
#   User.create!(name: name,
#                email: email,
#                password: password,
#                divesite_id: divesite_id,
#                uid: uid,
#                )
# end
