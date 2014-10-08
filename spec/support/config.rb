shared_examples_for "kernel::config" do
  it { should have_notify_resource_count(0) }

  it { should_not contain_notify('kernel') }

  context 'when version matches kernelrelease fact' do
    let :facts do
      {
        :kernelrelease              => '2.6.32.el6.x86_64',
        :osfamily                   => 'RedHat',
        :operatingsystem            => 'CentOS',
        :operatingsystemmajrelease  => '6',
      }
    end

    let(:params) {{ :version => '2.6.32.el6.x86_64' }}
    it { should_not contain_notify('kernel') }
  end

  context 'when version does not match kernelrelease fact' do
    let :facts do
      {
        :kernelrelease              => '2.6.32.el6.x86_64',
        :osfamily                   => 'RedHat',
        :operatingsystem            => 'CentOS',
        :operatingsystemmajrelease  => '6',
      }
    end

    let(:params) {{ :version => '2.6.32-431.29.2.el6.x86_64' }}

    it do
      should contain_notify('kernel').with({
        :message  => "A reboot is required to change the running kernel from 2.6.32.el6.x86_64 to 2.6.32-431.29.2.el6.x86_64"
      })
    end
  end

end
