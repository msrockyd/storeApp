# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


user =  User.create({:email => "admin@example.com", :password => "computer", :password_confirmation => "computer", :is_admin => true })
AdminUser.create(:first_name => "admin 1", :last_name => "user 1", :user_id => user.id)