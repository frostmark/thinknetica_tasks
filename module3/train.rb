class Train
  attr_reader :speed, :number, :type, :carriages

  def initialize(number: 0, type: 'passenger', carriages: 0)
    @number = number
    self.type = type
    @carriages = carriages

    @speed = 0
    @station_number = 0
  end

  def type=(type)
    @type = %w(cargo passenger).include?(type) ? type : (raise 'Invalid train type!')
  end

  def speed_up(speed)
    @speed += speed
  end

  def speed_down
    @speed = 0
  end

  def add_carriage
    if @speed.zero?
      @carriages += 1
    else
      puts "Train in motion! Stop it!"
    end
  end

  def remove_carriage
    return 0 if @carriages.zero?

    if @speed.zero?
      @carriages -= 1
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
    self.speed_up(60) if @speed.zero?

    if @station_number == @route.stations.count - 1
      puts 'You\'ve reached the end of the road. Now take back!'
      return
    end

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

  def route_assigned!
    raise "Route not yet assigend!" unless @route
  end
end