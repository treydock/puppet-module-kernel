# See README.md for more details.
class kernel (
  Optional[String] $version                   = undef,
  Enum['present', 'latest'] $package_ensure   = 'present',
  String $package_name                        = $kernel::params::package_name,
  Boolean $install_devel                      = false,
  String $devel_package_name                  = $kernel::params::devel_package_name,
  Boolean $install_headers                    = false,
  String $headers_package_name                = $kernel::params::headers_package_name,
  Boolean $install_firmware                   = false,
  String $firmware_package_name               = $kernel::params::firmware_package_name,
  Boolean $set_default_kernel                 = true,
  Optional[String] $grub_default_kernel       = undef,
  Stdlib::Unixpath $grub_conf_path            = $kernel::params::grub_conf_path,
  Enum['grub', 'grub2', 'grubby'] $grub_class = $kernel::params::grub_class,
) inherits kernel::params {

  $kernel_version = $version ? {
    Undef   => $version,
    default => "${version}.${::architecture}",
  }

  contain kernel::install
  contain kernel::config
  contain "kernel::${grub_class}"

  Class['kernel::install']
  -> Class['kernel::config']
  -> Class["kernel::${grub_class}"]

}
