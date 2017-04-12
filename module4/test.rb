def test(app)
  station_start = Station.new 'Start'
  station_end = Station.new 'End'

  route = Route.new station_start, station_end

  cargo_train = CargoTrain.new('xxx-11')
  passenger_train = PassengerTrain.new('xxx-12')

  app.trains << cargo_train
  app.trains << passenger_train

  passenger_carriage = PassengerCarriage.new(seats: 60)
  app.carriages << passenger_carriage
  passenger_train.add_carriage passenger_carriage

  passenger_carriage.reserve_seat(1)
  passenger_carriage.reserve_seat(2)

  p passenger_carriage.free_seats
  p passenger_carriage.reserved_seats
  puts passenger_carriage

  cargo_carriage = CargoCarriage.new(capacity: 700)
  app.carriages << cargo_carriage
  cargo_train.add_carriage cargo_carriage

  p cargo_carriage.capacity
  p cargo_carriage.fill_capacity 500
  p cargo_carriage.filled_capacity
  p cargo_carriage.available_capacity
  puts cargo_carriage

  app.routes << route
  app.stations << station_start
  app.stations << station_end

  cargo_train.route = route

  station_start.each_train { |t| puts t.type }
  cargo_train.each_carriage { |c| puts c.owner.type }

  app
end
