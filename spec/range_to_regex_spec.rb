require 'spec_helper'

describe Irxrb::RangeToRegex do
  include Irxrb::RangeToRegex

  describe '#invoke' do
    specify { invoke(1..  9).should == /[1-9]/ }
    specify { invoke(1... 9).should == /[1-8]/ }
    specify { invoke(1.. 10).should == /[1-9]|10/ }
    specify { invoke(1.. 11).should == /[1-9]|1[0-1]/ }
    specify { invoke(1.. 99).should == /[1-9]|[1-9][0-9]/ }
    specify { invoke(1..100).should == /[1-9]|[1-9][0-9]|100/ }
    specify { invoke(1..101).should == /[1-9]|[1-9][0-9]|10[0-1]/ }
    specify { invoke(1..110).should == /[1-9]|[1-9][0-9]|10[0-9]|110/ }
    specify { invoke(1..111).should == /[1-9]|[1-9][0-9]|10[0-9]|11[0-1]/ }

    specify { invoke(59.. 79).should == /59|[6-7][0-9]/ }
#    specify { invoke(60.. 80).should == /[1-9]|[1-9][0-9]/ }
#    specify { invoke(61.. 81).should == /[1-9]|[1-9][0-9]/ }
#    specify { invoke(59.. 99).should == /[1-9]|[1-9][0-9]/ }
#    specify { invoke(60..100).should == /[1-9]|[1-9][0-9]/ }
#    specify { invoke(61..101).should == /[1-9]|[1-9][0-9]/ }

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
