# frozen_string_literal: true

module InstanceCountable
  def self.included(klass)
    klass.extend ClassMethods
    klass.include InstanceMethods
  end

  module InstanceMethods
    private

    def register_instance
      instance_count = self.class.instances || 0
      self.class.send(:instances=, instance_count + 1)
    end
  end

  module ClassMethods
    attr_accessor :instances
    private :instances=
  end
end
