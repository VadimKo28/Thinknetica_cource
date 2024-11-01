module InstanceCounter
  def self.included(base)
    base.extend ClassMethod
    base.include InstanseMethod
  end

  module ClassMethod
    attr_writer :instances

    def instances
      @objects.count
    end
  end

  module InstanseMethod
    private

    def register_instance
      self.class.instances += 1
    end
  end
end
