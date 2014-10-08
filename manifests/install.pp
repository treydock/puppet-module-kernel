# Private class.
class kernel::install {
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  if $kernel::version != 'UNSET' {
    $package_name         = "${kernel::package_name}-${kernel::version}"
    $devel_package_name   = "${kernel::devel_package_name}-${kernel::version}"
    $headers_package_name = "${kernel::headers_package_name}-${kernel::version}"
  } else {
    $package_name         = $kernel::package_name
    $devel_package_name   = $kernel::devel_package_name
    $headers_package_name = $kernel::headers_package_name
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
      ensure => $kernel::package_ensure,
      name   => $headers_package_name,
    }
  }

}
