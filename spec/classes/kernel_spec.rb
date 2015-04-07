require 'spec_helper'

describe 'kernel' do
  on_supported_os({
    :hardwaremodels => ['x86_64'],
    :supported_os   => [
      {
        "operatingsystem" => "CentOS",
        "operatingsystemrelease" => [
          "6",
          "7"
        ]
      }
    ]
  }).each do |os, default_facts|
    context "on #{os}" do
      case default_facts[:operatingsystemmajrelease]
      when '7'
        grubclass = 'grub2'
      when '6'
        grubclass = 'grub'
      end

      let(:facts) { default_facts }

      it { should create_class('kernel') }
      it { should contain_class('kernel::params') }

      it { should contain_anchor('kernel::start').that_comes_before('Class[kernel::install]') }
      it { should contain_class('kernel::install').that_comes_before('Class[kernel::config]') }
      it { should contain_class('kernel::config').that_comes_before("Class[kernel::#{grubclass}]") }
      it { should contain_class("kernel::#{grubclass}").that_comes_before('Anchor[kernel::end]') }
      it { should contain_anchor('kernel::end') }

      it_behaves_like 'kernel::install', default_facts
      it_behaves_like 'kernel::config', default_facts
      it_behaves_like "kernel::#{grubclass}", default_facts

      # Test validate_bool parameters
      [
        :install_devel,
        :install_headers,
        :set_default_kernel,
      ].each do |param|
        context "with #{param} => 'foo'" do
          let(:params) {{ param.to_sym => 'foo' }}
          it 'should raise an error' do
            expect { should compile }.to raise_error(/is not a boolean/)
          end
        end
      end

    end
  end
end
