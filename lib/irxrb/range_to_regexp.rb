module Irxrb::RangeToRegexp

  module_function

  def invoke(range)
    max = range.max + 1
    min = range.min
    pivot = pivot(min, max)

    ret = []

    base = pivot
    split_by_unit(max - pivot).each do |unit, diff|
      ret << make_regexp(base, unit, diff)
      base += unit * diff
    end

    base = pivot
    split_by_unit(pivot - min).each do |unit, diff|
      ret.unshift make_regexp(base, unit, -diff)
      base -= unit * diff
    end

    /#{ret.join('|')}/
  end

  def unit_of(num)
    unit = 1
    loop do
      return unit if num < unit * 10
      unit *= 10
    end
  end

  def split_by_unit(num)
    ret = []
    unit = 1
    while num > 0
      n = num % 10
      ret.unshift [unit, n] if n != 0
      unit *= 10
      num /= 10
    end
    return ret
  end

  def pivot(min, max)
    unit = unit_of(max)
    pivot = max / unit * unit
    while unit > 1 && (min / pivot) == 1
      unit /= 10
      pivot = max / unit * unit
    end
    return pivot
  end

  def make_regexp(base, unit, diff)
    if diff < 0
      return make_regexp(base + unit * diff, unit, -diff)
    end
    prefix = base / (unit * 10)
    prefix_str = prefix == 0 ? '' : prefix.to_s
    current = base / unit % 10
    current_str = diff == 1 ? current.to_s : "[#{current}-#{current + diff - 1}]"
    suffix_str = "[0-9]" * Math.log(unit, 10).round
    return prefix_str + current_str + suffix_str
  end
end
