require 'spec_helper'

describe 'kernel' do
  let :facts do
    {
      :kernelrelease              => '2.6.32.el6.x86_64',
      :osfamily                   => 'RedHat',
      :operatingsystem            => 'CentOS',
      :operatingsystemmajrelease  => '6',
      :architecture               => 'x86_64',
    }
  end

  it { should create_class('kernel') }
  it { should contain_class('kernel::params') }

  it { should contain_anchor('kernel::start').that_comes_before('Class[kernel::install]') }
  it { should contain_class('kernel::install').that_comes_before('Class[kernel::config]') }
  it { should contain_class('kernel::config').that_comes_before('Class[kernel::grub]') }
  it { should contain_class('kernel::grub').that_comes_before('Anchor[kernel::end]') }
  it { should contain_anchor('kernel::end') }

  it_behaves_like 'kernel::install'
  it_behaves_like 'kernel::config'
  it_behaves_like 'kernel::grub'

  context "when operatingsystemmajrelease => 7" do
    let :facts do
      {
        :kernelrelease              => '3.10.0-el7.x86_64',
        :osfamily                   => 'RedHat',
        :operatingsystem            => 'CentOS',
        :operatingsystemmajrelease  => '7',
        :architecture               => 'x86_64',
      }
    end

    it { should_not contain_class('kernel::grub') }
    it { should contain_class('kernel::config').that_comes_before('Class[kernel::grub2]') }
    it { should contain_class('kernel::grub2').that_comes_before('Anchor[kernel::end]') }

    it_behaves_like 'kernel::install'
    it_behaves_like 'kernel::config'
    it_behaves_like 'kernel::grub2'
  end

  # Test validate_bool parameters
  [

  ].each do |param|
    context "with #{param} => 'foo'" do
      let(:params) {{ param.to_sym => 'foo' }}
      it { expect { should create_class('kernel') }.to raise_error(Puppet::Error, /is not a boolean/) }
    end
  end
end
