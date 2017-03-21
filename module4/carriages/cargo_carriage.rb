require_relative 'carriage'

class CargoCarriage < Carriage
  def initialize
    super(type: 'cargo')
  end
end
