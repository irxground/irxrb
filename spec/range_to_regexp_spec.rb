require 'spec_helper'

describe Irxrb::RangeToRegexp do
  include Irxrb::RangeToRegexp

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
    specify { invoke(60.. 79).should == /[6-7][0-9]/ }
    specify { invoke(61.. 79).should == /6[1-9]|7[0-9]/ }
    specify { invoke(59.. 80).should == /59|[6-7][0-9]|80/ }
    specify { invoke(60.. 80).should == /[6-7][0-9]|80/ }
    specify { invoke(61.. 80).should == /6[1-9]|7[0-9]|80/ }
    specify { invoke(59.. 81).should == /59|[6-7][0-9]|8[0-1]/ }
    specify { invoke(60.. 81).should == /[6-7][0-9]|8[0-1]/ }
    specify { invoke(61.. 81).should == /6[1-9]|7[0-9]|8[0-1]/ }

    specify { invoke(10..100).should == /[1-9][0-9]|100/ }
    specify do
      actual = invoke(987..654321)
      expect = [
        '98[7-9]|99[0-9]',
        '[1-9][0-9][0-9][0-9]',
        '[1-9][0-9][0-9][0-9][0-9]',
        '[1-5][0-9][0-9][0-9][0-9][0-9]',
        '6[0-4][0-9][0-9][0-9][0-9]',
        '65[0-3][0-9][0-9][0-9]',
        '654[0-2][0-9][0-9]',
        '6543[0-1][0-9]',
        '65432[0-1]'].join('|')
      actual.should == /#{expect}/
    end
  end

  describe '#unit_of' do
    specify { unit_of(  8).should ==   1 }
    specify { unit_of( 10).should ==  10 }
    specify { unit_of( 99).should ==  10 }
    specify { unit_of(100).should == 100 }
  end

  describe '#split_by_unit' do
    specify { split_by_unit(1905).should == [[1000, 1], [100, 9], [1, 5]] }
  end

  describe '#pivot' do
    specify { pivot(100, 200).should == 200 }
    specify { pivot(199, 200).should == 200 }
    specify { pivot( 99, 200).should == 200 }
    specify { pivot(100, 299).should == 200 }
    specify { pivot(100, 201).should == 200 }

    specify { pivot(1860, 1970).should == 1900 }
    specify { pivot(1960, 1970).should == 1970 }
    specify { pivot(1986, 1987).should == 1987 }

    specify { pivot(9876, 9876).should == 9876 }
  end

  describe '#make_regexp' do
    specify { make_regexp(100, 10, 2).should == '1[0-1][0-9]' }
    specify { make_regexp(130, 10, 3).should == '1[3-5][0-9]' }
    specify { make_regexp(100, 10, 1).should == '10[0-9]' }
    specify { make_regexp(130, 10, 1).should == '13[0-9]' }

    specify { make_regexp(  10,   10, 3).should == '[1-3][0-9]' }
    specify { make_regexp( 100,  100, 3).should == '[1-3][0-9][0-9]' }
    specify { make_regexp(1000, 1000, 3).should == '[1-3][0-9][0-9][0-9]' }
  end
end
