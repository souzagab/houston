# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#

PLANETS = {
  # AI Data, didn't confirm if the values are real
  "Mercury" => 57.9,
  "Venus" => 108.2,
  "Mars" => 227.9,
  "Jupiter" => 778.3,
  "Saturn" => 1427.0,
  "Uranus" => 2871.0,
  "Neptune" => 4497.1,
  "Pluto" => 5913.0
}.freeze

PLANETS.each do |name, distance_to_earth|
  FactoryBot.create(:planet, name:, distance_to_earth:)
end

puts "Planets created"
Planet.pluck(%i[id name]).each do |planet|
  puts "  #{planet.last} (ID #{planet.first})"
end

Spacecraft::TYPES.each do |type|
  FactoryBot.create(:spacecraft, type:)
end

puts "Spacecrafts created"
Spacecraft.pluck(%i[id type]).each do |spacecraft|
  puts "  #{spacecraft.last} (ID #{spacecraft.first})"
end
