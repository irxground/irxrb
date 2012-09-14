require 'spec_helper'

describe Irxrb::RangeToRegex do
  include Irxrb::RangeToRegex

  describe '#invoke' do
    specify { invoke(1..9 ).should == /[1-9]/ }
    specify { invoke(1...9).should == /[1-8]/ }
    specify { invoke(1..10).should == /[1-9]|10/ }
    specify { invoke(3..100).should == /[3-9]|[1-9][0-9]|100/ }
    specify { invoke(10..100).should == /[1-9][0-9]|100/ }
  end

  describe "#parse_common" do
    specify { parse_common("", "").should == "" }
    specify { parse_common("a", "b").should == "" }
    specify { parse_common("a", "ab").should == "" }
    specify { parse_common("a", "a").should == "a" }
    specify { parse_common("ab", "ab").should == "ab" }
    specify { parse_common("ab", "ac").should == "a" }
  end

  describe '#rev_to_i' do
    specify { rev_to_i(%w(1 2 3)).should == 321 }
    specify { rev_to_i(%w(4 3 2)).should == 234 }
  end

  describe '#i_to_rev' do
    specify { i_to_rev(123).should == [3, 2, 1] }
    specify { i_to_rev(432).should == [2, 3, 4] }
  end
end
