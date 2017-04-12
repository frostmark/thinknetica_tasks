class Station
  include Validateable
  include InstanceCountable

  attr_reader :name, :trains

  NAME_FORMAT = /\A[a-z]+|\d+\z/i

  @@stations = []

  def initialize(name)
    @name = name
    @trains = []

    validate!

    @@stations << self
    register_instance
  end

  def taking_train(train)
    @trains << train
  end

  def send_train(train)
    @trains = @trains.delete_if { |t| t.number == train.number }
  end

  def trains_by_type(type)
    @trains.select { |train| train.type == type }
  end

  def each_train
    raise ArgumentError, 'Method expects a block!' unless block_given?
    @trains.each { |t| yield t }
  end

  class << self
    def all
      @@stations
    end
  end

  protected

  def validate!
    raise ArgumentError, 'Argument must have at least character of number' if NAME_FORMAT !~ name
  end
end
