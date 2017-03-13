class Station
  attr_accessor :name

  def initialize(name)
    @name = name.downcase
    @trains = []
  end

  def taking_train(train)
    train?(train)
    @trains << train
    puts "#{@name.capitalize} taking train with number #{train.number}"
  end

  def send_train(train)
    train?(train)
    train = @trains.pop { |t| t.number == train.number }
    puts "#{@name.capitalize} send train with number #{train.number}"
  end

  def to_s
    pass_trains = 0
    cargo_trains = 0

    @trains.each do |train|
      pass_trains +=1 if train.type == 'passenger'
      cargo_trains +=1 if train.type == 'cargo'
    end

    puts %Q(
    - Station "#{self.name}""
    - Cargo trains: #{cargo_trains}
    - Passenger trains: #{pass_trains}
    - Total: #{@trains.count}
    )
  end

  private

  def train?(train)
    raise 'Argument must be instance of Train class' unless train.is_a?(Train)
    true
  end
end