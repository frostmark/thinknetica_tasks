class Station
  attr_reader :name, :trains

  @@stations = []

  def initialize(name)
    @name = name
    @trains = []

    @@stations << self
  end

  def taking_train(train)
    @trains << train
  end

  def send_train(train)
    @trains = @trains.delete_if {|t| t.number == train.number}
    puts "#{@name.capitalize} send train with number #{train.number}"
  end

  def trains_by_type(type)
    @trains.select{|train| train.type == type}
  end

  class << self
    def all
      @@stations
    end
  end
end
