shared_examples_for "kernel::grub" do
  it { should have_augeas_resource_count(0) }

  it { should_not contain_augeas('set default kernel') }

  context 'when grub_kernel_version defined' do
    let(:params) {{ :grub_default_kernel => '2.6.32-431.23.3.el6.x86_64' }}

    it do
      should contain_augeas('set default kernel').with({
        :context  => '/files/boot/grub/grub.conf',
        :incl     => '/boot/grub/grub.conf',
        :lens     => 'Grub.lns',
        :changes  => [
          "set title[1] 'CentOS (2.6.32-431.23.3.el6.x86_64)'",
          "set title[1]/kernel '/vmlinuz-2.6.32-431.23.3.el6.x86_64'",
          "set title[1]/initrd '/initramfs-2.6.32-431.23.3.el6.x86_64.img'",
        ]
      })
    end
  end

  context 'when only version defined' do
    let(:params) {{ :version => '2.6.32-431.23.3.el6.x86_64' }}
    it { should contain_augeas('set default kernel') }
  end

  context 'when set_default_kernel => false' do
    let(:params) {{ :set_default_kernel => false }}
    it { should_not contain_augeas('set default kernel') }
  end
end
