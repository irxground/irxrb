class Object
  def to_proc
    Proc.new{|obj| self === obj }
  end
end
