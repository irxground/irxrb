require 'irxrb/range_to_regex'

class Range
  def to_regex
    Irxrb::RangeToRegex.invoke(self)
  end
end
