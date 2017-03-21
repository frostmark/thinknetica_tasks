require_relative 'train'

class CargoTrain < Train
  def initialize(num)
    super(number: num, type: 'cargo')
  end
end
