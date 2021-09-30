# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'
require "securerandom"

# generate 20 users
(1..40).each do |id|
    User.create!(
# each user is assigned an id from 1-20
        name: Faker::Name.name,
        username: Faker::App.name,
        email: Faker::Internet.email,
        phone_number: Faker::PhoneNumber.cell_phone,
    )
end

(1..20).each do |id|
    Restaurant.create!(
# each user is assigned an id from 1-20
        name: Faker::Restaurant.name,
        city: "Philadelphia",
        state: "PA",
        phone_number: Faker::PhoneNumber.cell_phone,
        address: Faker::Address.street_address,
        postal_code: Faker::Address.zip_code,
        owner: User.find(id+3)
    )
end