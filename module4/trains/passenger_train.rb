require_relative 'train'

class PassengerTrain < Train
  def initialize(num)
    super(number: num, type: 'passenger')
  end
end
