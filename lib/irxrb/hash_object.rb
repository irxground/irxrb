module Irxrb
  class HashObject
    def initialize(hash)
      raise ArgumentError, 'argument should be Hash' unless Hash === hash
      @hash = hash
    end

    def method_missing(action, *args)
      if @hash.has_key? action
        self.class.class_eval do
          define_method(action) do
            @hash[action]
          end
        end
        return __send__ action
      end
      super
    end
  end
end

