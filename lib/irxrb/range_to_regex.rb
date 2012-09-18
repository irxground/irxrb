module Irxrb::RangeToRegex

  module_function

  def invoke(range)
    max = range.max
    min = range.min
    common = parse_common(min.to_s, max.to_s)

    if common.size > 0
      diff = max.to_s.size - common.size
      dex = 10 << (diff - 1)
      max %= dex
      min %= dex
    end
    Regexp.new(parse_diff(min, max)
      .map{|pattern| common + pattern }
      .join("|"))
  end

  def parse_common(min_str, max_str)
    return '' if min_str.size != max_str.size
    i = 0
    while i < min_str.size
      break if min_str[i] != max_str[i]
      i += 1
    end
    return (i < 0) ? '' : min_str[0...i]
  end

  def parse_diff(min, max)
    min, min_result = parse_diff_min(min, max)
    p [min_result, min]
    max_result = parse_diff_max(min, max)
    min_result.concat(max_result)
  end

  def parse_diff_min(min, max)
    ret = []
    min_chars = i_to_rev(min)
    loop.with_index do |_, i|
      next_chars = min_chars.clone
      next if next_chars[i] == 0
      next_chars[i] = 0
      next_chars[i+1] ||= 0
      next_chars[i+1] += 1
      next_min = rev_to_i(next_chars)
      break if next_min > max

      buff = []
      (min_chars.size - 1).downto(i+1) do |j|
        buff << min_chars[i]
      end
      buff << "[#{min_chars[i]}-9]"
      i.times{ buff << '[0-9]' }
      ret << buff.join

      min = next_min
      min_chars = next_chars
    end
    return min, ret
  end

  def parse_diff_max(min, max)
    min_chars = i_to_chars(min)
    max_chars = i_to_chars(max)
    ret = []
    continue = true
    while continue
      buff = []
      i = 0
      while i < min_chars.size && min_chars[i] == max_chars[i]
        buff << min_chars[i]
        i += 1
      end
      continue = (i != min_chars.size)
      if i < min_chars.size
        if min_chars[i+1..-1].all?{|c| c == 0 } &&
           max_chars[i+1..-1].all?{|c| c == 9 }
          buff << "[#{min_chars[i]}-#{max_chars[i]}]"
          continue = false
        elsif min_chars[i] + 1 == max_chars[i]
          buff << min_chars[i]
        else
          buff << "[#{min_chars[i]}-#{max_chars[i]-1}]"
        end
        min_chars[i] = max_chars[i]
        i += 1
      end
      while i < min_chars.size
        buff << '[0-9]'
        i += 1
      end
      result = buff.join
      ret << result
    end
    return ret
  end

  def rev_to_i(rev_chars)
    rev_chars.reverse.join.to_i
  end

  def i_to_rev(int)
    i_to_chars(int).reverse
  end

  def i_to_chars(int)
    int.to_s.split('').map(&:to_i)
  end
end
