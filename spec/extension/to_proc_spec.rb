require_relative '../spec_helper'

describe '#to_proc' do
  describe Object do
    it 'should behave as ==' do
      obj1 = Object.new
      obj2 = Object.new
      p = obj1.to_proc

      p[obj1].should     be_true
      p[obj2].should_not be_true
    end
  end

  describe Regexp do
    it 'should behave as matcher' do
      p = /o/.to_proc

      p['foo'].should     be_true
      p['bar'].should_not be_true
    end
  end

  describe Class do
    it 'should behave as is_a?' do
      is_str = String.to_proc

      is_str['foo'].should     be_true
      is_str[12345].should_not be_true
    end
  end
end

