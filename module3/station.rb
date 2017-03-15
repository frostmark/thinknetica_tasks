class Station
  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  def taking_train(train)
    @trains << train
  end

  def send_train(train)
    @trains = @trains.delete_if {|t| t.number == train.number}
    puts "#{@name.capitalize} send train with number #{train.number}"
  end

  def trains_by_type
    result = {}
    @trains.each do |train|
      if result[train.type].nil? 
        result[train.type] = 1
      else
        result[train.type] += 1
      end
    end
    result
  end
end