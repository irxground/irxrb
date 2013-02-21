class MatchData
  def to_hash
    names.each_with_object({}){|name, hash| hash[name] = self[name] }
  end
end