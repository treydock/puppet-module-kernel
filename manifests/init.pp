# See README.md for more details.
class kernel (
  $version               = 'UNSET',
  $package_ensure        = 'present',
  $package_name          = $kernel::params::package_name,
  $install_devel         = false,
  $devel_package_name    = $kernel::params::devel_package_name,
  $install_headers       = false,
  $headers_package_name  = $kernel::params::headers_package_name,
  $install_firmware      = false,
  $firmware_package_name = $kernel::params::firmware_package_name,
  $set_default_kernel    = true,
  $grub_default_kernel   = 'UNSET',
  $grub_conf_path        = $kernel::params::grub_conf_path,
  $grub_class            = $kernel::params::grub_class,
) inherits kernel::params {

  validate_re($package_ensure, ['^present$', '^latest$'])

  validate_bool($install_devel, $install_headers)
  validate_bool($set_default_kernel)

  validate_string($version, $grub_default_kernel)
  validate_string($package_name, $devel_package_name, $headers_package_name)
  validate_string($grub_conf_path, $grub_class)

  if $version != 'UNSET' {
    $kernel_version = "${kernel::version}.${::architecture}"
  } else {
    $kernel_version = 'UNSET'
  }

  include kernel::install
  include kernel::config
  include "kernel::${grub_class}"

  anchor { 'kernel::start': }->
  Class['kernel::install']->
  Class['kernel::config']->
  Class["kernel::${grub_class}"]->
  anchor { 'kernel::end': }

}
