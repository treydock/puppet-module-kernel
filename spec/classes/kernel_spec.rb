require 'spec_helper'

describe 'kernel' do
  on_supported_os(hardwaremodels: ['x86_64'],
                  supported_os: [
                    {
                      'operatingsystem' => 'CentOS',
                      'operatingsystemrelease' => [
                        '6',
                        '7',
                      ],
                    },
                  ]).each do |os, default_facts|
    context "on #{os}" do
      case default_facts[:operatingsystemmajrelease]
      when '7'
        grubclass = 'grub2'
      when '6'
        grubclass = 'grub'
      end

      let(:facts) { default_facts }

      it { is_expected.to create_class('kernel') }
      it { is_expected.to contain_class('kernel::params') }

      it { is_expected.to contain_class('kernel::install').that_comes_before('Class[kernel::config]') }
      it { is_expected.to contain_class('kernel::config').that_comes_before("Class[kernel::#{grubclass}]") }
      it { is_expected.to contain_class("kernel::#{grubclass}") }

      it_behaves_like 'kernel::install', default_facts
      it_behaves_like 'kernel::config', default_facts
      it_behaves_like "kernel::#{grubclass}", default_facts
      it_behaves_like 'kernel::grubby', default_facts
    end
  end
end
