#require 'facter/osg_version'
require 'spec_helper'

describe 'kernel_arguments fact' do
  before :each do
    Facter.fact(:kernel).stubs(:value).returns('Linux')
  end

  it "should return output from /proc/cmdline" do
    expected_value = my_fixture_read('cmdline1')
    Facter::Util::Resolution.expects(:exec).with('cat /proc/cmdline 2>/dev/null').returns(expected_value)
    expect(Facter.fact(:kernel_arguments).value).to eq(expected_value)
  end
end
