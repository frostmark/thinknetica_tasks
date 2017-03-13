class Route
  attr_reader :start_station, :end_station

  def initialize(start_st, end_st)
    self.start_station = start_st
    self.end_station = end_st

    @stations = [@start_station, @end_station]
  end

  def start_station=(station)
    station?(station)
    debugger
    @start_station = station
  end

  def end_station=(station)
    station?(station)
    @end_station = station
  end

  def add(station)
    station?(station)
    @stations.insert(-2, station)
  end

  def remove(station)
    station?(station)
    @stations.delete_if { |s| s.name == station.name }
  end

  def [](key)
    @stations[key]
  end

  def length
    @stations.count
  end

  def reverse
    @stations.reverse
  end

  def to_s
    @stations.map { |st| st.name }.join(', ')
  end

  private

  attr_writer :start_station, :end_station

  def station?(station)
    raise 'Argument must be instance of Station class' unless station.is_a?(Station)
    true
  end

end