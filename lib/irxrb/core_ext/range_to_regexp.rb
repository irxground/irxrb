require 'irxrb/range_to_regexp'

class Range
  def to_regexp
    Irxrb::RangeToRegexp.invoke(self)
  end
end
