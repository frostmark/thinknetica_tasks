class Train
  include Vendorable
  include InstanceCountable
  include Validateable

  attr_reader :speed, :number, :carriages, :type, :route

  TYPES = ['passenger', 'cargo']
  NUMBER_FORMAT = /\A([a-z]|\d){3}-?([a-z]|\d){2}\z/i

  @@trains = {}

  def initialize(number: 0, type: 'passenger', **args)
    @number = number
    self.type = type
    @carriages = []

    @speed = 0
    @station_number = 0
    @vendor = args[:vendor] || 'No name train vendor'

    validate!

    @@trains[@number] = self
    register_instance
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
        false
      end
    else
      false
    end
  end

  def remove_carriage
    return 0 if @carriages.size.zero?

    if @speed.zero?
      carriage = @carriages.pop
      carriage.release # Remove train association
    else
      false
    end
  end

  def route=(route)
    if @station_number > 0
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

  def each_carriage(&block)
    raise ArgumentError, 'Method expects a block!' unless block_given?
    @carriages.each { |c| block.call c }
  end

  class << self
    def find(number)
      @@trains[number]
    end
  end

  protected

  def type=(type)
    @type = TYPES.include?(type) ? type : (raise 'Invalid train type!')
  end

  def route_assigned!
    raise "Route not yet assigend!" unless @route
  end

  def valid_carriage?(value)
    @type == value.type
  end

  def validate!
    raise ArgumentError, 'Number format should be like xxx-xx' if NUMBER_FORMAT !~ @number.to_s
    raise ArgumentError, "Type must be one of #{TYPES.join(', ')}" unless TYPES.include? @type
    raise ArgumentError, 'Train with this number exist!' if @@trains[@number]
  end
end
