
module Irxrb
  class Maybe
    class << self
      def [](value)
        value != nil ? Just.new(value) : Nothing.instance
      end
    end

    class Nothing < Maybe
      @@instance = new

      def initialize
        raise "#{self.class} can't be instantize."
      end

      def self.instance
        @@instance
      end

      def !@
        nil
      end

      def method_missing(name, *arg)
        self
      end
    end

    class Just < Maybe
      def initialize(value)
        raise 'argument should not be nil' if value == nil
        @value = value
      end

      def !@
        @value
      end

      def method_missing(name, *arg)
        ret =
          block_given? ?
            @value.__send__(name, *arg){|*a| yield *a } :
            @value.__send__(name, *arg)
        return Nothing.instance if ret == nil
        return self             if ret == @value
        return Just.new(ret)
      end
    end
  end
end

