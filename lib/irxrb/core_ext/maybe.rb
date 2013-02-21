def Maybe(obj)
  Irxrb::Maybe[obj]
end
class Object
  def maybe(&block)
    self.instance_eval(&block)
  end
end
class NilClass
  def maybe(&block)
  end
end

