class Train
  attr_reader :number, :type, :carriages, :speed, :station_number, :route
  @@numbers = []

  def initialize(number: 0, type: 'passenger', carriages: 0)
    self.number = number
    self.type = type.to_s
    self.carriages = carriages.to_i
    @speed = 0
    @station_number = 0
  end

  def number=(number)
    positive_number?(number)
    raise 'Train with this number exist!' if @@numbers.include?(number)

    @@numbers << number
    @number = number
  end

  def type=(type)
    @type = %w(cargo passenger).include?(type) ? type : (raise 'Invalid train type!')
  end

  def carriages=(carriages)
    positive_number?(carriages)
    @carriages = carriages
  end

  def speed_up(speed)
    positive_number?(speed)
    @speed += speed
    puts "Speed increased to #{@speed}km/h"
  end

  def speed_down
    @speed = 0
    puts 'Train was stoped!'
  end

  def add_carriage
    if @speed.zero?
      @carriages += 1
      puts "Carraiges increased to #{@carriages}!"
    else
      puts "Train in motion! Stop it!"
    end
  end

  def remove_carriage
    if @carriages.zero?
      puts 'Train already not have carriages!'
      return
    end

    if @speed.zero?
      @carriages -= 1
      puts "Carraiges decreased to #{@carriages}!"
    else
      puts "Train in motion! Stop it!"
    end
  end

  def route=(route)
    route?(route)

    if @station_number > 0
      puts "You cannot assign route, train is on the way!"
      return
    end

    @route = route
    first_station = @route[0]
    first_station.taking_train(self)
  end

  def go
    route_assigned?
    self.speed_up(60) if @speed.zero?

    if @station_number == @route.length - 1
      puts "You've reached the end of the road. Now take back!"
      @route = @route.reverse
      @station_number = 0
    end

    current_station = @route[@station_number]
    current_station.send_train(self)

    @station_number += 1

    next_station = @route[@station_number]
    next_station.taking_train(self)
  end

  def prev_station
    route_assigned?

    # If station is start of the route
    if @station_number == @route[0]
      station_name = @route[@station_number].name.capitalize
      puts "#{station_name} is the last in the route"
    else
      prev_station_name =@route[@station_number - 1].name.capitalize
      puts "Prev station: #{prev_station_name}"
    end
  end

  def station
    route_assigned?

    station_name = @route[@station_number].name.capitalize
    number_from_beginning = @station_number + 1
    route_length = @route.length
    puts "Current station: #{station_name} is #{number_from_beginning}/#{route_length} station"
  end

  def next_station
    route_assigned?

    # If station is end of the route
    if @station_number == @route.length - 1
      station_name = @route[@station_number].name.capitalize
      puts "#{station_name} is the last in the route"
    else
      next_station_name = @route[@station_number + 1].name.capitalize
      puts "Next station: #{next_station_name}"
    end
  end

  def to_s
    puts "Train number: #{@number}, type: #{@type}, carriages: #{@carriages}, speed: #{@speed}km/h"
  end

  def self.numbers
    @@numbers
  end

  private

  def positive_number?(value)
    raise 'Argument must be positive!' if value.to_i < 0
    true
  end

  def route?(value)
    raise 'Argument must instance of Route class' unless value.is_a?(Route)
    true
  end

  def route_assigned?
    raise "Route not yet assigend!" unless @route
  end
end