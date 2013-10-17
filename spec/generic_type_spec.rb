require_relative 'spec_helper'
require 'irxrb/core_ext/generic_type'

describe Irxrb::GenericType do
  context 'one type parameter' do
    module Factory
      type_parameter :T

      def create
        self.T.new
      end
    end

    describe 'class' do
      specify { Factory[String]::T.should == String }
    end

    describe 'instance' do
      subject { Factory[String].new }
      it { should be_an_instance_of(Factory[String]) }
      it { should be_kind_of(Factory) }
      it { should_not be_an_instance_of(Factory[Object]) }

      specify { subject.T == String }
      specify { subject.create.should == "" }
    end
  end

  context 'two type parameters' do
    module Map
      type_parameter :Key, :Value
    end

    subject { Map[Integer, String] }
    specify { subject::Key.should   == Integer }
    specify { subject::Value.should == String  }
    specify { subject.new.should be_kind_of(Map) }
  end
end

