require_relative '../spec_helper'

describe '#to_proc' do
  describe Object do
    it 'should same as ==' do
      obj = Object.new
      obj.to_proc.(obj).should be_true
    end
  end
end

