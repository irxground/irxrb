require_relative 'spec_helper'

describe Irxrb::HashObject do
  describe 'constructor' do
    it 'should raise error' do
      expect {
        Irxrb::HashObject.new("str")
      }.to raise_error(ArgumentError)
    end

    it 'should create instance' do
      expect {
        Irxrb::HashObject.new(foo: 'bar')
      }.not_to raise_error
    end
  end

  describe 'method' do
    subject { Irxrb::HashObject.new(foo: 1) }
    specify { expect( subject.foo ).to eq(1) }
    specify { expect{ subject.bar }.to raise_error(NoMethodError) }
  end
end

