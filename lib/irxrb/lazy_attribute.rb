module Irxrb
  module LazyAttribute
    def lazy(name, &block)
      method_name = "__#{name}_lazy"
      self.class_eval <<-"END"
        def #{name}=(value)
          @#{name} = value
        end

        def #{name}
          @#{name} ||= #{method_name}
        end

        def #{name}?
          @#{name} != nil
        end

        def #{name}!
          @#{name} = #{method_name}
        end
      END
      self.instance_eval do
        define_method method_name, block
      end
    end
  end
end
