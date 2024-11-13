module Accessors
  def attr_accessor_with_history(*attributes)
    attributes.each do |attribute|
      instance_var = "@#{attribute}".to_sym

      history_var = "@#{attribute}_history".to_sym

      define_method(attribute) {instance_variable_get(instance_var)}
      
      define_method("#{attribute}=".to_sym) do |value| 
        instance_variable_set(instance_var, value)

        instance_variable_set(history_var, []) unless instance_variable_defined?(history_var)

        instance_variable_get(history_var) << instance_variable_get(instance_var)
      end  

      name_attr_history = "#{attribute}_history"

      define_method(name_attr_history) { instance_variable_get(history_var) if instance_variable_defined?(history_var) }
    end
  end

  def strong_attr_accessor(name, type)
    
    var_name = "@#{name}".to_sym

    define_method(name) { instance_variable_get(var_name) }

    define_method("#{name}=".to_sym) do |value|
      if value.is_a?(type)
        instance_variable_set(var_name, value)
      else 
        raise TypeError, "Expected #{type}, got #{value.class}"
      end  
    end
  end
end
