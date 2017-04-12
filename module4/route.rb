# frozen_string_literal: true

class Route
  attr_accessor :stations

  def initialize(start_station, end_station)
    @stations = [start_station, end_station]
    validate!
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def remove_station(index)
    return false if [0, @stations.count - 1].include(index)
    @stations.delete_at index
  end

  def to_s
    @stations.map(&:name).join(' – ')
  end

  protected

  def validate!
    stations.each { |s| station! s }
    true
  end

  def station!(station)
    return if station.is_a?(Station)
    raise ArgumentError, 'Argument must be instance of Station class'
  end
end
