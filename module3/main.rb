require 'byebug'
require_relative './train'
require_relative './station'
require_relative './route'

sapsan = Train.new(number: 1, type: :passenger, carriages: 5)
cargo_train = Train.new(number: 2, type: :cargo, carriages: 25)


puts sapsan.speed
sapsan.speed_up(15)
sapsan.speed_up(45)
sapsan.speed_down
sapsan.speed_up(3)
puts sapsan.speed

sapsan.add_carriage
puts sapsan.carriages
sapsan.speed_down
sapsan.remove_carriage
puts sapsan.carriages
puts sapsan

moscow = Station.new('Moscow')
petushki = Station.new('Petushki')


village_1 = Station.new('Village 1')
village_2 = Station.new('Village 2')

msk_pth_route = Route.new(moscow, petushki)
msk_pth_route.add(village_1)
msk_pth_route.add(village_2)

sapsan.route = msk_pth_route
cargo_train.route = msk_pth_route

6.times {
  sapsan.go
  sapsan.prev_station
  sapsan.station
  sapsan.next_station
  puts "="*40
}