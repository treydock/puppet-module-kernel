shared_examples_for "kernel::install" do
  it { should have_package_resource_count(1) }

  it do
    should contain_package('kernel').only_with({
      :ensure => 'present',
      :name   => 'kernel',
    })
  end

  it { should_not contain_package('kernel-dev') }
  it { should_not contain_package('kernel-headers') }

  context 'when version defined' do
    let(:params) {{ :version => '2.6.32-431.23.3.el6.x86_64' }}

    it { should contain_package('kernel').with_name('kernel-2.6.32-431.23.3.el6.x86_64') }
  end

  context 'when install_devel => true' do
    let(:params) {{ :install_devel => true }}

    it { should contain_package('kernel-devel').with_ensure('present') }

    context 'when version defined' do
      let(:params) {{ :install_devel => true, :version => '2.6.32-431.23.3.el6.x86_64' }}
      it { should contain_package('kernel-devel').with_name('kernel-devel-2.6.32-431.23.3.el6.x86_64') }
    end
  end

  context 'when install_headers => true' do
    let(:params) {{ :install_headers => true }}

    it { should contain_package('kernel-headers').with_ensure('present') }

    context 'when version defined' do
      let(:params) {{ :install_headers => true, :version => '2.6.32-431.23.3.el6.x86_64' }}
      it { should contain_package('kernel-headers').with_name('kernel-headers-2.6.32-431.23.3.el6.x86_64') }
    end
  end

  context 'when package_ensure => latest' do
    let(:params) {{ :package_ensure => 'latest' }}
    it { should contain_package('kernel').with_ensure('latest') }
  end
end
