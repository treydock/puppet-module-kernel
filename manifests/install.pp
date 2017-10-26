# Private class.
class kernel::install {
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  if $kernel::version {
    $package_name            = "${kernel::package_name}-${kernel::version}"
    $devel_package_name      = "${kernel::devel_package_name}-${kernel::version}"
    $headers_package_ensure  = $kernel::version
    $firmware_package_ensure = $kernel::version
  } else {
    $package_name            = $kernel::package_name
    $devel_package_name      = $kernel::devel_package_name
    $headers_package_ensure  = $kernel::package_ensure
    $firmware_package_ensure = $kernel::package_ensure
  }

  package { 'kernel':
    ensure => $kernel::package_ensure,
    name   => $package_name,
  }

  if $kernel::install_devel {
    package { 'kernel-devel':
      ensure => $kernel::package_ensure,
      name   => $devel_package_name,
    }
  }

  if $kernel::install_headers {
    package { 'kernel-headers':
      ensure => $headers_package_ensure,
      name   => $kernel::headers_package_name,
    }
  }

  if $kernel::install_firmware {
    package { 'kernel-firmware':
      ensure => $firmware_package_ensure,
      name   => $kernel::firmware_package_name,
    }
  }

}
