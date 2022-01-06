# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

(1..10).to_a.each do
  fake_user = Faker::Internet.user('username', 'email', 'password')
  customer = Customer.find_by(email: fake_user[:email]) || Customer.new
  customer.email = fake_user[:email]
  customer.name = fake_user[:username].humanize.capitalize
  customer.password = fake_user[:password]
  customer.build_wallet
  if customer.save
    puts "Successfully create customer with email #{fake_user[:email]} and xid #{customer.xid}"
  else
    puts customer.errors.full_messages
  end
end
