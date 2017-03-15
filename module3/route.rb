class Route
  attr_reader :stations

  def initialize(start_station, end_station)
    @stations = [start_station, end_station]
  end

  def add_station(index, station)
    @stations.insert(index, station)
  end

  def remove_station(index)
    @stations = @stations.delete_at index
  end
end