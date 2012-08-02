require 'spec_helper'
require 'irxrb/extensions/hash_to_obj'

describe Hash do
  subject { Hash[a: 1] }
  specify { subject.should respond_to(:to_obj) }
  specify { subject.to_obj.should be_an_instance_of(Irxrb::HashObject) }
end
