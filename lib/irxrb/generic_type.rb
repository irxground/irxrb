module Irxrb
  module GenericType
    def type_parameter(*params)
      m = self
      define_singleton_method :[] do |*types|
        raise ArgumentError if params.size != types.size
        @_specific_type ||= {}
        @_specific_type[types] ||=
          begin
            k = (m.is_a? Class) ?
              Class.new(m) :
              Module.new.tap{ |x| x.instance_eval { include m } }
            params.zip(types).each do |param_name, type|
              k.const_set param_name, type
              k.instance_eval do
                define_method(param_name){ type }
              end
            end
            k
          end
      end
    end
  end
end

