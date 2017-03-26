class Carriage
  include Vendorable

  TYPES = ['passenger', 'cargo']

  attr_reader :type, :owner

  def initialize(type: 'passenger', **args)
    @vendor = args[:vendor] || 'No name carriage vendor'
    self.type = type.to_s
  end

  def owner=(train)
    if @owner
      puts "Carriage already attached to train with number: #{@owner.number}"
      return
    end

    @owner = train
  end

  def to_s
    "Carriage type: #{@type}, associated with train: #{@owner&.number ? @owner.number : 'None'}"
  end

  def type=(type)
    @type = TYPES.include?(type) ? type : (raise 'Invalid carriage type!')
  end

  def release
    unless @owner
      puts 'Carriage yet have not attached to train!'
      return
    end

    train_number = @owner.number
    @owner = nil

    puts "Carriage dettached from train with number: #{train_number}"
    self
  end
end
