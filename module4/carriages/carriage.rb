# frozen_string_literal: true

class Carriage
  include Vendorable
  include InstanceCountable

  TYPES = %w[passenger cargo].freeze

  attr_reader :type, :owner

  def initialize(type: 'passenger', **args)
    @vendor = args[:vendor] || 'No name carriage vendor'
    self.type = type.to_s

    register_instance
  end

  def owner=(train)
    return false if @owner

    @owner = train
  end

  def to_s
    "Carriage type: #{@type}, associated with train: #{@owner&.number ? @owner.number : 'None'}"
  end

  def type=(type)
    @type = TYPES.include?(type) ? type : (raise 'Invalid carriage type!')
  end

  def release
    return unless @owner

    train_number = @owner.number
    @owner = nil

    self
  end
end
