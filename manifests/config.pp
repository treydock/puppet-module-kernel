# Private class.
class kernel::config {
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  if $kernel::kernel_version {
    $current  = $::kernelrelease

    if $current != $kernel::kernel_version {
      notify { 'kernel':
        message => "A reboot is required to change the running kernel from ${current} to ${kernel::kernel_version}"
      }
    }
  }

}
