module Accessors
  def attr_accessor_with_history(*args)
    args.each do |arg|
      instance_var = "@#{arg}".to_sym
      define_method(:"#{arg}") { instance_variable_get(instance_var) }

      define_method(:"#{arg}=") do |value|
        instance_variable_set(instance_var, value)

        @history ||= {}
        @history[instance_var] ||= []
        @history[instance_var] << value
      end
      define_method(:"#{arg}_history") do
        if !!@history
          @history[instance_var] || []
        else
          {}
        end
      end
    end
  end

  def strong_attr_accessor(name, type)
    instance_var = "@#{name}".to_sym
    define_method(name) { instance_variable_get(instance_var) }
    define_method("#{name}=".to_sym) do |value|
      raise 'Wrong variable type' unless value.class.is_a? == type.is_a?
      instance_variable_set(instance_var, value)
    end
  end
end
