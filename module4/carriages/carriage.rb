class Carriage
  include Vendorable
  include InstanceCountable

  TYPES = ['passenger', 'cargo']

  attr_reader :type, :owner

  def initialize(type: 'passenger', **args)
    @vendor = args[:vendor] || 'No name carriage vendor'
    self.type = type.to_s

    register_instance
  end

  def owner=(train)
    if @owner
      return false
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
      return
    end

    train_number = @owner.number
    @owner = nil

    self
  end
end
