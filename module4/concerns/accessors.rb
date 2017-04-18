module Accessors
  def attr_accessor_with_history(*args)
    args.each do |arg|
      instance_var = "@#{arg}".to_sym
      history_var = "@#{arg}_history".to_sym
      define_method(:"#{arg}") { instance_variable_get(instance_var) }

      define_method(:"#{arg}=") do |value|
        instance_variable_get(history_var) || instance_variable_set(history_var, [])
        instance_eval("#{history_var} << #{instance_var}") if instance_variable_get(instance_var)
        instance_variable_set(instance_var, value)
      end

      define_method(:"#{arg}_history") do
        instance_variable_get(history_var) || []
      end
    end
  end

  def strong_attr_accessor(name, type)
    instance_var = "@#{name}".to_sym
    define_method(name) { instance_variable_get(instance_var) }
    define_method("#{name}=".to_sym) do |value|
      raise ArgumentError unless value.is_a?(type)
      instance_variable_set(instance_var, value)
    end
  end
end
