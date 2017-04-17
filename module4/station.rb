# frozen_string_literal: true

class Station
  include Validateable
  include InstanceCountable
  extend Accessors

  attr_reader :name, :trains

  attr_accessor_with_history :test

  NAME_FORMAT = /\A[a-z]+|\d+\z/i

  validate :name, :format, NAME_FORMAT

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
end
