shared_examples_for 'kernel::grubby' do |_default_facts|
  it { is_expected.not_to contain_class('kernel::grubby') }

  context 'when grub_class => grubby' do
    let(:params) { { grub_class: 'grubby' } }

    it { is_expected.to contain_class('kernel::grubby') }
    it { is_expected.not_to contain_exec('set default kernel') }

    context 'when grub_kernel_version defined' do
      let(:params) { { grub_class: 'grubby', grub_default_kernel: '2.6.32-431.23.3.el6.x86_64' } }

      it do
        is_expected.to contain_exec('set default kernel').with(command: '/sbin/grubby --set-default=/boot/vmlinuz-2.6.32-431.23.3.el6.x86_64',
                                                               path: ['/bin', '/usr/bin'],
                                                               unless: '/sbin/grubby --default-kernel | grep -q /boot/vmlinuz-2.6.32-431.23.3.el6.x86_64')
      end
    end

    context 'when only version defined' do
      let(:params) { { grub_class: 'grubby', version: '2.6.32-431.23.3.el6' } }

      it do
        is_expected.to contain_exec('set default kernel').with(command: '/sbin/grubby --set-default=/boot/vmlinuz-2.6.32-431.23.3.el6.x86_64',
                                                               path: ['/bin', '/usr/bin'],
                                                               unless: '/sbin/grubby --default-kernel | grep -q /boot/vmlinuz-2.6.32-431.23.3.el6.x86_64')
      end
    end

    context 'when set_default_kernel => false' do
      let(:params) { { grub_class: 'grubby', set_default_kernel: false } }

      it { is_expected.not_to contain_exec('set default kernel') }
    end
  end
end
