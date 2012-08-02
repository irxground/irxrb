require 'spec_helper'

describe Irxrb::Maybe do
  describe '.[]' do
    specify { expect { Irxrb::Maybe[] }.to raise_error }
    specify { Irxrb::Maybe[nil  ].should be_an_instance_of(Irxrb::Maybe::Nothing) }
    specify { Irxrb::Maybe[false].should be_an_instance_of(Irxrb::Maybe::Just) }
    specify { Irxrb::Maybe[true ].should be_an_instance_of(Irxrb::Maybe::Just) }
    specify { Irxrb::Maybe[1    ].should be_an_instance_of(Irxrb::Maybe::Just) }
    specify { Irxrb::Maybe["str"].should be_an_instance_of(Irxrb::Maybe::Just) }
    specify { Irxrb::Maybe[:sym ].should be_an_instance_of(Irxrb::Maybe::Just) }
    specify { Irxrb::Maybe[Class].should be_an_instance_of(Irxrb::Maybe::Just) }
  end

  describe '#!' do
    specify {                   expect(!maybe(nil  )).to eq(nil  ) }
    specify {                   expect(!maybe(1    )).to eq(1    ) }
    specify {                   expect(!maybe("str")).to eq("str") }
    specify { obj = Object.new; expect(!maybe(obj  )).to eq(obj  ) }
  end

  describe 'method call' do
    describe Irxrb::Maybe::Nothing do
      describe 'always return Nothing' do
        subject { Irxrb::Maybe[nil] }
        specify { expect(!subject           ).to eq(nil) }
        specify { expect(!subject.foo       ).to eq(nil) }
        specify { expect(!subject.foo.bar   ).to eq(nil) }
        specify { expect(!subject.foo(1)    ).to eq(nil) }
        specify { expect(!subject.foo{|x| x}).to eq(nil) }
      end
    end

    describe Irxrb::Maybe::Just do
      before do
        @mock = Object.new
        @mock.stub(ret_nil: nil)
        @mock.stub(ret_self: @mock)
      end

      specify { expect(!maybe(@mock).ret_self).to eq(@mock) }
      specify { expect(!maybe(@mock).ret_nil ).to eq(nil) }
      specify { expect(!maybe(@mock).ret_self.ret_self).to eq(@mock) }
      specify { expect(!maybe(@mock).ret_self.ret_nil ).to eq(nil)   }
      specify { expect(!maybe(@mock).ret_nil .ret_self).to eq(nil)   }
      specify { expect(!maybe(@mock).ret_nil .ret_nil ).to eq(nil)   }
      specify { expect(!maybe([1,2,3]).map{|x| x*x }).to eq([1,4,9]) }
      specify { expect(!maybe([1,2,3]).inject{|a,x| a+x }).to eq(6)  }
    end
  end

  describe '.new' do
    specify { expect{ Irxrb::Maybe::Just.new(nil) }.to raise_error }
    specify { expect{ Irxrb::Maybe::Nothing.new   }.to raise_error }
  end

  def maybe(value)
    Irxrb::Maybe[value]
  end
end

