# @summary Manage kernel
#
# @example
#   include ::kernel
#
# @param version
#   The desired kernel version to be installed.
#   Must be the full string that would be output by running `uname -r`.
#   Default of 'UNSET' disables management of kernel package version.
# @param package_ensure
#   Package ensure parameter.
# @param package_name
#   The kernel package name.
# @param install_devel
#   Boolean to specify whether the kernel-devel package should be installed.
# @param devel_package_name
#   The kernel development package name.
# @param install_headers
#   Boolean to specify whether the kernel-headers package should be installed.
# @param headers_package_name
#   The kernel headers package name.
# @param install_firmware
#   Boolean to specify whether the kernel-firmware package should be installed.
# @param firmware_package_name
#   The kernel firmware package name.
# @param set_default_kernel
#   Boolean to specify whether if the default kernel in GRUB should be modified by this module.
# @param grub_default_kernel
#   The kernel version to set as default in GRUB.
#   Default is the value of `$version`.
# @param grub_conf_path
#   The path to GRUB configuration file.  Default is OS dependent.
# @param grub_class
#   The class to be used to manage GRUB.
#   Default for EL6 is `grub` and default for EL7 is `grub2` (not yet implemented).
#   The `grubby` class is also available.
#
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
