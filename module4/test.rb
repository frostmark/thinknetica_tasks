def test app
  station_start = Station.new "Start"
  station_end = Station.new "End"

  route = Route.new station_start, station_end

  train = Train.new number: 1, type: 'cargo'

  app.trains << train
  app.routes << route
  app.stations << station_start
  app.stations << station_end
  app
end
