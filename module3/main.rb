require 'byebug'
require_relative './train'
require_relative './station'
require_relative './route'

stations = %w(Moscow Saint-Petersburg Yekaterinburg).map do |name|
  Station.new(name)
end

sapsan = Train.new(number: 1, type: 'passenger', carriages: 5)
cargo_train = Train.new(number: 2, type: 'cargo', carriages: 25)

sapsan.speed_up 60
puts "Sapsan current speed: #{sapsan.speed}"

sapsan.speed_down
puts "Sapsan current speed: #{sapsan.speed}"

puts "Sapsan qty carriages: #{sapsan.carriages}"

sapsan.add_carriage
puts "Sapsan qty carriages: #{sapsan.carriages}"

sapsan.remove_carriage
puts "Sapsan qty carriages: #{sapsan.carriages}"

puts stations

route = Route.new(stations.first, stations.last)

route.stations.each do |station|
  p "Станция -- #{station.name}"
end

route.add_station(stations[1])

route.stations.each do |station|
  p "Станция -- #{station.name}"
end

sapsan.route = route
cargo_train.route = route

puts "Sapsan current station: #{sapsan.station.name}"

puts "Sapsan next station: #{sapsan.next_station.name}"

puts "Cargo train current station: #{cargo_train.station.name}"
puts "Cargo train next station: #{cargo_train.next_station.name}"

puts "Trains in #{stations.first.name}:"
stations.first.trains.each do |train|
  puts "Train number: #{train.number}"
end

puts "Station trains by type passenger: "
stations.first.trains_by_type("passenger").each do |t|
  puts "Train with number: #{t.number}"
end

puts "Station count trains by type passenger: #{stations.first.trains_by_type("passenger").count}"

sapsan.go
puts "Sapsan current station: #{sapsan.station.name}"


puts "Trains in #{stations.first.name}:"
stations.first.trains.each do |train|
  puts "Train number: #{train.number}"
end

puts "Trains in #{stations[1].name}:"
stations[1].trains.each do |train|
  puts "Trains: #{train.number}"
end

sapsan.go
puts "Sapsan current station: #{sapsan.station.name}"

sapsan.go
puts "Sapsan current station: #{sapsan.station.name}"


puts "Sapsan prev station: #{sapsan.prev_station.name}"

