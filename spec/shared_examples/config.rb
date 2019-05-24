shared_examples_for 'kernel::config' do |default_facts|
  case default_facts[:operatingsystemmajrelease]
  when '7'
    version = '3.10.0-123.el7'
    kernelrelease_match = '3.10.0-123.el7.x86_64'
    kernelrelease_nomatch = '3.10.0-123.13.2.el7.x86_64'
  when '6'
    version = '2.6.32-431.20.5.el6'
    kernelrelease_match = '2.6.32-431.20.5.el6.x86_64'
    kernelrelease_nomatch = '2.6.32-431.29.2.el6.x86_64'
  end

  it { is_expected.to have_notify_resource_count(0) }

  it { is_expected.not_to contain_notify('kernel') }

  context 'when version matches kernelrelease fact' do
    let(:facts) do
      default_facts.merge(kernelrelease: kernelrelease_match)
    end
    let(:params) { { version: version } }

    it { is_expected.not_to contain_notify('kernel') }
  end

  context 'when version does not match kernelrelease fact' do
    let(:facts) do
      default_facts.merge(kernelrelease: kernelrelease_nomatch)
    end
    let(:params) { { version: version } }

    it do
      is_expected.to contain_notify('kernel').with(message: "A reboot is required to change the running kernel from #{facts[:kernelrelease]} to #{version}.#{facts[:architecture]}")
    end
  end
end
