require 'spec_helper'

describe Irxrb::LazyAttribute do
  subject { TestObj.new }

  its(:counter) { should == 0 }
  its(:value?)  { should == false }

  describe 'after get attribute' do
    before { subject.value.should == 'value1' }
    its(:counter) { should == 1 }
    its(:value?)  { should == true }
    its(:value)   { should == 'value1' }

    describe 'redo lazy' do
      before { subject.value!.should == 'value2' }
      its(:counter) { should == 2 }
      its(:value?)  { should == true }
      its(:value)   { should == 'value2' }
    end
  end

  describe 'redo lazy' do
    before { subject.value!.should == 'value1' }
    its(:counter) { should == 1 }
    its(:value?)  { should == true }
    its(:value)   { should == 'value1' }
  end

  class TestObj
    extend Irxrb::LazyAttribute

    attr_reader :counter
    def initialize
      @counter = 0
    end

    lazy :value do
      @counter += 1
      "value#@counter"
    end

  end
end
