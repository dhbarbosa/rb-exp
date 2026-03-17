# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'csv'
require 'faker'

Faker::Config.locale = 'pt-BR'

puts "Criando cids..."
csv_text = File.read(Rails.root.join('lib', 'seeds', 'seeds_file.csv'))

csv = CSV.parse(csv_text, headers: true, col_sep: ';', encoding: 'UTF-8')

csv.each do |row|
  data ={
    number: row[0],
    description: [ 'DESCRICAO' ]
  }
    Cid.create(data)
end
puts "Cids criadas!"
puts "Gerando User..."
Faker::Number.between(from: 500, to: 1000).times do
  User.create(
    name: Faker::Name.name,
    age: Faker::Number.between(from: 18, to: 80)

  )
end
puts "User criados!"
puts "Gerando Hopstial"

  Faker::Number.between(from: 30, to: 60).times do
    Hospital.create(
      name: Faker::Company.name
    )
  end

puts "Hospital criado!"

puts "Atrelando users as cids..."

cid_qtd = Cid.count
user_qtd = User.count

User.all.each do |user|
  jump = [ false, false, false, true ].sample

  next if jump

  id = Faker::Number.between(from: 1, to: cid_qtd)
  cid = Cid.find(id)
  UserCid.create(user: user, cid: cid, first_diagnosed_at: Faker::Date.between(from: '2020-01-01', to: '2024-12-31'))
end

User.count.times do
  user_id = Faker::Number.between(from: 1, to: user_qtd)
  cid_id = Faker::Number.between(from: 1, to: cid_qtd)
  UserCid.create(user: User.find(user_id), cid: Cid.find(cid_id), first_diagnosed_at: Faker::Date.between(from: '2020-01-01', to: '2024-12-31'))
end

puts "User atreladod as cids"

puts "Atrelando UserCids aos Hospitais..."

hospital_qtd = Hospital.count

UserCid.all.each do |user_cid|
  id = Faker::Number.between(from: 1, to: hospital_qtd)
  hospital = Hospital.find(id)
  tratament_start_at = Faker::Date.between(from: '2020-01-01', to: '2024-12-31')
  tratament_on_tratament_in_days = Faker::Number.between(from: 1, to: (365*5))
  tratament_end_at = tratament_start_at + tratament_on_tratament_in_days
  HospitalUserCid.create(
    hospital: hospital,
    user_cid: user_cid,
    tratament_start_at: tratament_start_at,
    tratament_end_at: tratament_end_at
  )
end
puts "UserCids atrelados aos Hospitais!"
