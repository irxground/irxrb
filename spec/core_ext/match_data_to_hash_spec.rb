require 'spec_helper'
require 'irxrb/core_ext/match_data_to_hash'

describe MatchData, '#to_hash' do
  subject do
    /(?<a>\d+)-(?<b>\d+)-(?<c>\d+)/ =~ '12-34-56'
    $~.to_hash
  end

  it { should be_an_instance_of(Hash) }
  it { should == { 'a' => '12', 'b' => '34', 'c' => '56' } }
end
