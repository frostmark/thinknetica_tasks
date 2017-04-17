# frozen_string_literal: true

module Validateable
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def validate(attr, type, *arg)
      @validations ||= []
      @validations << { attr.to_sym => [type.to_sym, arg.first].compact }
      @validations.uniq
      debugger
    end
  end

  module InstanceMethods
    def valid?
      validate!
    rescue
      false
    end

    def validate!
      self.class.instance_variable_get(:@validations).each do |hash|
        self.send "#{hash.values[0].first}!", hash.keys[0], hash.values[0].last
        self.instance_variable_get("@#{hash.keys[0]}")
      end
    end

    private

    def presence!(validate, *value)
      raise "'#{validate}' is nil or empty" if validate.nil? || validate.to_s.empty?
    end

    def format!(validate, value)
      raise "Wrong format of argument:'#{validate}'" unless validate =~ value
    end

    def type!(attr, value)
      raise "Wrong type of argument:'#{attr}'" unless validate.is_a?(value)
    end
  end
end
