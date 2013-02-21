class Hash
  def to_obj
    Irxrb::HashObject.new(self)
  end
end
