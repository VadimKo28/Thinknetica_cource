module Validation 
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end


  module ClassMethods
    def validations
      @validations ||= []
    end

    def validate(attr_name, validation_type, option = nil)
      validations << { attr_name: attr_name, validation_type: validation_type, option: option }
    end
  end 
  
  module InstanceMethods
    def validate!
      self.class.validations.each do |validation|
        attr_name = validation[:attr_name]
        validation_type = validation[:validation_type]
        option = validation[:option]
    
        value = instance_variable_get("@#{attr_name}".to_sym)

        if instance_variable_defined?("@#{attr_name}".to_sym)
          case validation_type
          when :presence
            validate_presence(value, attr_name) 
          when :type 
            validate_type(attr_name, option)
          when :format 
            validate_format(value, attr_name, option)
          end
        end
      end

      "Ok"

    rescue ArgumentError => e
      puts e.message  
    end

    def valid?
      validate! == "Ok" ? true : false
    end

    private 

    def validate_presence(value, attr_name)      
      if value.nil? || value.empty? 
         raise StandardError, "#{attr_name.capitalize} can't be blank"
      end
    end

    def validate_type(attr_name, option)
      unless self.class == option
        raise TypeError, "Attribute #{attr_name} Expected #{option} class, got #{self.class}"
      end
    end

    def validate_format(value, attr_name, option)
      if value.to_s !~ option
        raise StandardError, "Value #{value} invalid #{attr_name} format"
      end
    end
  end
end
