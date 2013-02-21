require 'spec_helper'
require 'irxrb/core_ext/maybe'

describe '#maybe' do
  it 'should raise error without block' do
    expect{ Object.new.maybe }.to raise_error
  end

  specify { expect([1,2,3].maybe{ self.map{|x| x * x } }).to eq([1,4,9]) }
  specify { expect(    nil.maybe{ self.map{|x| x * x } }).to eq(nil    ) }
  specify { expect(     10.maybe{ self * self          }).to eq(100    ) }
end

describe '#Maybe' do
  specify { Maybe(100).should be_an_instance_of(Irxrb::Maybe::Just)    }
  specify { Maybe(nil).should be_an_instance_of(Irxrb::Maybe::Nothing) }
end
