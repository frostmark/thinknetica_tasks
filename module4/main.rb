require 'byebug'

require_relative 'concerns/vendorable'
require_relative 'concerns/instance_countable'
require_relative 'concerns/validateable'
require_relative 'trains/cargo_train'
require_relative 'trains/passenger_train'
require_relative 'carriages/cargo_carriage'
require_relative 'carriages/passenger_carriage'
require_relative 'station'
require_relative 'route'
require_relative 'railway_cli'

app = RailwayCLI.new

app.execute
