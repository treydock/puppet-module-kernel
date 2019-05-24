shared_examples_for 'kernel::install' do |_default_facts|
  it { is_expected.to have_package_resource_count(1) }

  it do
    is_expected.to contain_package('kernel').only_with(ensure: 'present',
                                                       name: 'kernel')
  end

  it { is_expected.not_to contain_package('kernel-dev') }
  it { is_expected.not_to contain_package('kernel-headers') }
  it { is_expected.not_to contain_package('kernel-firmware') }

  context 'when version defined' do
    let(:params) { { version: '2.6.32-431.23.3.el6' } }

    it { is_expected.to contain_package('kernel').with_name('kernel-2.6.32-431.23.3.el6') }
  end

  context 'when install_devel => true' do
    let(:params) { { install_devel: true } }

    it { is_expected.to contain_package('kernel-devel').with_ensure('present') }

    context 'when version defined' do
      let(:params) { { install_devel: true, version: '2.6.32-431.23.3.el6' } }

      it { is_expected.to contain_package('kernel-devel').with_name('kernel-devel-2.6.32-431.23.3.el6') }
    end
  end

  context 'when install_headers => true' do
    let(:params) { { install_headers: true } }

    it { is_expected.to contain_package('kernel-headers').with_ensure('present') }

    context 'when version defined' do
      let(:params) { { install_headers: true, version: '2.6.32-431.23.3.el6' } }

      it { is_expected.to contain_package('kernel-headers').with_ensure('2.6.32-431.23.3.el6') }
    end
  end

  context 'when install_firmware => true' do
    let(:params) { { install_firmware: true } }

    it { is_expected.to contain_package('kernel-firmware').with_ensure('present') }

    context 'when version defined' do
      let(:params) { { install_firmware: true, version: '2.6.32-431.23.3.el6' } }

      it { is_expected.to contain_package('kernel-firmware').with_ensure('2.6.32-431.23.3.el6') }
    end
  end

  context 'when package_ensure => latest' do
    let(:params) { { package_ensure: 'latest' } }

    it { is_expected.to contain_package('kernel').with_ensure('latest') }
  end
end
