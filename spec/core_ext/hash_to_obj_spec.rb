require 'spec_helper'
require 'irxrb/core_ext/hash_to_obj'

describe Hash, '#to_obj' do
  subject { Hash[a: 1] }
  specify { subject.should respond_to(:to_obj) }
  specify { subject.to_obj.should be_an_instance_of(Irxrb::HashObject) }
end
