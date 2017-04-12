# frozen_string_literal: true

class RailwayCLI
  attr_accessor :stations, :trains, :routes, :carriages
  def initialize
    @stations = []
    @trains = []
    @routes = []
    @carriages = []
  end

  def execute
    loop do
      show_menu

      gets
    end
  end

  private

  def reserve_seat
    pass_carriages = @carriages.select { |c| c.type == 'passenger' }
    if pass_carriages.empty?
      puts 'Passenger carriages do not yet exist'
      return
    end

    puts 'List of carriages:'
    pass_carriages.each_with_index { |c, i| puts "#{i + 1} - #{c}" }

    puts 'Carriage number:'
    number = gets.chomp.to_i
    car = pass_carriages.fetch(number - 1)
    puts "Avialable seats: #{car.free_seats}"
    puts 'Seat number:'
    seat = gets.chomp.to_i
    car.reserve_seat(seat)
    puts "Seat was number #{seat} was resevred!"
  rescue => e
    puts e.message
    retry
  end

  def create_station
    print 'Station name: '
    name = gets.chomp
    station = Station.new(name)
    @stations << station
    puts "Station #{station.name} was created!"
  rescue => e
    puts e.message
    retry
  end

  def print_stations
    @stations.each_with_index { |s, i| puts "#{i + 1} - #{s.name}" }
  end

  def create_route
    if @stations.size <= 1
      puts 'Not enough stations!'
      return
    end

    print_stations

    print 'Start station: '
    start_station = gets.chomp.to_i

    print 'End station: '
    end_station = gets.chomp.to_i

    route = Route.new(@stations[start_station - 1], @stations[end_station - 1])
    @routes << route

    puts "Route #{route} was created!"
  rescue => e
    puts e.message
    retry
  end

  def fill_capacity
    cargo_carriages = @carriages.select { |c| c.type == 'cargo' }
    if cargo_carriages.empty?
      puts 'Cargo carriages do not yet exist'
      return
    end

    puts 'List of carriages:'
    cargo_carriages.each_with_index { |c, i| puts "#{i + 1} - #{c}" }

    puts 'Carriage number:'
    number = gets.chomp.to_i
    car = cargo_carriages.fetch(number - 1)
    puts 'Fill with value:'
    capacity = gets.chomp.to_i
    car.fill_capacity(capacity)
    puts 'Capacity was changed!'
    puts car
  end

  def print_routes
    @routes.each_with_index { |r, i| puts "#{i + 1} Route: #{r}" }
  end

  def create_train
    print 'Train number: '
    number = gets.chomp
    print 'Train type (cargo or passenger): '
    type = gets.chomp.downcase

    case type
    when 'cargo'
      train = CargoTrain.new(number)
    when 'passenger'
      train = PassengerTrain.new(number)
    else
      puts "#{type} not exist"
      return
    end

    @trains << train
    puts "#{type} train with number #{train.number} was created!"
  rescue => e
    puts e.message
    retry
  end

  def print_trains
    @trains.each_with_index { |t, i| puts "#{i + 1} – train №#{t.number} type: #{t.type} carriages: #{t.carriages.count}" }
  end

  def assign_route
    if [@trains, @routes].any?(&:empty?)
      puts 'Trains or Routes not existed!'
      return
    end

    print_trains
    print 'Train number: '
    number = gets.chomp.to_i - 1
    train = @trains.fetch(number)

    print_routes
    print 'Route number: '
    number = gets.chomp.to_i - 1
    route = @routes.fetch(number)

    train.route = route

    puts 'Route added!'
  rescue => e
    puts e.message
    retry
  end

  def run_train
    print_trains

    print 'Train number: '
    number = gets.chomp.to_i - 1
    train = @trains.fetch(number)

    unless train.route
      puts 'Train not have assigned route!'
      return
    end

    puts 'How many stations to pass?'
    number = gets.chomp.to_i

    number.times do
      train.go
    end
  end

  def trains_on_station
    if @stations.size <= 1
      puts 'Not enough stations!'
      return
    end

    print_stations
    number = gets.chomp.to_i - 1

    station = @stations.fetch(number)

    station.trains.each_with_index { |t, i| puts "#{i + 1} – train №#{t.number} type: #{t.type}" }
  end

  def add_route_station
    if [@routes, @stations].any?(&:empty?)
      puts 'Stations or Routes not existed!'
      return
    end

    print_routes
    puts 'Route number:'
    number = gets.chomp.to_i - 1
    route = @routes.fetch(number)

    print_stations
    puts 'Staion number:'
    number = gets.chomp.to_i - 1
    station = @stations.fetch(number)

    if route.stations.include? station
      puts 'Route already have this station!'
      return
    end

    route.add_station(station)
    puts "#{route} add #{station.name} station"
  end

  def create_carriage
    puts 'Carriage type (cargo or passenger):'
    type = gets.chomp.downcase

    case type
    when 'cargo'
      car = CargoCarriage.new
    when 'passenger'
      car = PassengerCarriage.new
    else
      puts "#{type} not exist"
      return
    end

    puts "#{type.capitalize} carriage was created!"
    @carriages << car
  end

  def print_carriages
    return 'Carriages do not yet exist' if @carriages.empty?
    puts 'List of carriages:'
    @carriages.each_with_index { |c, i| puts "#{i + 1} - #{c}" }
  end

  def attach_carriage
    if [@trains, @carriages].any?(&:empty?)
      puts 'Trains or Carriages not existed!'
      return
    end

    print_trains
    puts 'Train number:'
    train = @trains.fetch(gets.chomp.to_i - 1)

    print_carriages
    puts 'Carriage number:'
    car = @carriages.fetch(gets.chomp.to_i - 1)

    if train.add_carriage(car)
      puts "#{car.type.capitalize} carriage was attached to train #{train.number}"
    end
  end

  def detach_carriage
    if @trains.empty?
      puts 'Trains not existed!'
      return
    end

    print_trains

    puts 'Train number:'
    number = gets.chomp.to_i - 1
    train = @trains[number]

    if train.carriages.size.zero?
      puts 'Train not have carriages'
      return
    end

    train.remove_carriage
    puts "Carriages dettached from train #{train.number}"
  end

  def show_menu
    puts 'Enter number what you want do.'
    puts 'The following actions are available:'
    puts <<~ACTIONS
      Stations:
      [1] - Create station
      [2] - List of stations
      [3] - List of trains of station
      ----------------------
      Trains:
      [4] - Create train
      [5] - List of trains
      [6] - Add cariage
      [7] - Remove carriage
      [8] - Add route
      [9] - Run train
      ----------------------
      Routes:
      [10] - Create route
      [11] - List of routes
      [12] - Add station to route
      ----------------------
      Carriages:
      [13] - Create carriage
      [14] - List of carriages
      [15] - Reserve seat
      [16] - Fill capacity
      ----------------------
    ACTIONS

    action = gets.chomp.to_i

    case action
    when 1
      create_station
    when 2
      print_stations
    when 3
      trains_on_station
    when 4
      create_train
    when 5
      print_trains
    when 6
      attach_carriage
    when 7
      detach_carriage
    when 8
      assign_route
    when 9
      run_train
    when 10
      create_route
    when 11
      print_routes
    when 12
      add_route_station
    when 13
      create_carriage
    when 14
      print_carriages
    when 15
      reserve_seat
    when 16
      fill_capacity
    else
      puts 'Action not available!'
    end
  end
end
