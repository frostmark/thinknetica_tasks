require_relative 'carriage'

class CargoCarriage < Carriage
  attr_reader :capacity
  attr_reader :filled_capacity

  CAPACITY_MAX = 500

  def initialize(capacity: 0)
    @capacity = capacity
    @filled_capacity = 0

    super(type: 'cargo')
  end

  def fill_capacity(value)
    valid_capacity? value
    enough_space? value

    self.filled_capacity = value
  end

  def available_capacity
    @capacity - @filled_capacity
  end

  protected

  attr_writer :filled_capacity

  def validate!
    super
    valid_capacity? @capacity
  end

  def valid_capacity?(value)
    msg = "The capacity should be from 0 #{CAPACITY_MAX}"
    raise ArgumentError, msg unless value.between? 0, CAPACITY_MAX
  end

  def enough_space?(value)
    raise 'Not enough space!' if value > available_capacity
  end
end
