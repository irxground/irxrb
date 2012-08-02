require 'spec_helper'
require 'irxrb/extensions/to_proc'

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

  describe Proc do
    it 'should not cause infinit loop' do
      is_odd = proc{|num| num % 2 != 0 }

      is_odd[1].should     be_true
      is_odd[2].should_not be_true

      case 1
      when is_odd
        value = :odd
      else
        value = :even
      end
      value.should == :odd

      case 2
      when is_odd
        value = :odd
      else
        value = :even
      end
      value.should == :even
    end
  end

  describe '&proc' do
    specify { [1,2,3].map(&2).should == [false, true, false] }
    specify { %w(foo bar baz).select(&/a/).should == %w(bar baz) }
  end
end

