require 'spec_helper_acceptance'

describe 'kernel class:' do
  context 'default parameters' do
    it 'should run successfully' do
      pp =<<-EOS
      class { 'kernel': }
      EOS

      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes => true)
    end
  end

  context 'version defined' do
    case fact('operatingsystemmajrelease')
    when '7'
      version = '3.10.0-229.1.2.el7'
    when '6'
      version = '2.6.32-573.3.1.el6'
    end

    it 'should run successfully' do
      pp =<<-EOS
      class { 'kernel':
        version => '#{version}',
      }
      EOS

      apply_manifest(pp, :catch_failures => true)
      # The notify of kernel version mismatch will trigger changes
      apply_manifest(pp, :expect_changes => false)
    end

    case fact('operatingsystemmajrelease')
    when '6'
      describe file('/boot/grub/grub.conf') do
        its(:content) { should match /^title CentOS \(#{version}.x86_64\)/ }
        its(:content) { should match /^\s+kernel \/vmlinuz-#{version}.x86_64/ }
        its(:content) { should match /^\s+initrd \/initramfs-#{version}.x86_64.img/ }
      end
    end
  end
end
