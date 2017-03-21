class Train
  attr_reader :speed, :number, :carriages, :type, :route

  TYPES = ['passenger', 'cargo']

  def initialize(number: 0, type: 'passenger')
    @number = number
    self.type = type
    @carriages = []

    @speed = 0
    @station_number = 0
  end

  def speed_up(speed)
    @speed += speed
  end

  def speed_down
    @speed = 0
  end

  def add_carriage(carriage)
    if @speed.zero?
      if valid_carriage? carriage
        carriage.owner = self
        @carriages << carriage
        true
      else
        puts 'Carriage type not valid'
        false
      end
    else
      puts "Train in motion! Stop it!"
      false
    end
  end

  def remove_carriage
    return 0 if @carriages.size.zero?

    if @speed.zero?
      carriage = @carriages.pop
      puts "Carraiges decreased to #{self.carriages.size}!"
      carriage.release # Remove train association
    else
      puts "Train in motion! Stop it!"
    end
  end

  def route=(route)
    if @station_number > 0
      puts 'You cannot assign route, train is on the way!'
      return
    end

    @route = route
    @route.stations[@station_number].taking_train self
  end

  def go
    route_assigned!
    return if @station_number == @route.stations.count - 1

    self.speed_up(60) if @speed.zero?

    @route.stations[@station_number].send_train self

    @station_number += 1

    @route.stations[@station_number].taking_train self
  end


  def prev_station
    route_assigned!

    if @station_number.zero?
      @route.stations[@station_number]
    else
      @route.stations[@station_number - 1]
    end
  end

  def station
    route_assigned!

    @route.stations[@station_number]
  end

  def next_station
    route_assigned!

    @route.stations[@station_number + 1]
  end

  private

  def type=(type)
    @type = TYPES.include?(type) ? type : (raise 'Invalid train type!')
  end

  def route_assigned!
    raise "Route not yet assigend!" unless @route
  end

  def valid_carriage?(value)
    @type == value.type
  end
end
