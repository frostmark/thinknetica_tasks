class Route
  attr_accessor :stations

  def initialize(start_station, end_station)
    @stations = [start_station, end_station]
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def remove_station(index)
    return 'cannot remove first and end stations' if [0, @stations.count - 1].include(index)
    @stations.delete_at index
  end
end