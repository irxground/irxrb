require 'spec_helper'
require 'irxrb/extensions/range_to_regex'

describe Range do
  subject { (10...100) }
  specify { subject.to_regex.should be_an_instance_of(Regexp) }
end
