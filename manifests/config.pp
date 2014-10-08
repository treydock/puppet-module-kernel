# Private class.
class kernel::config {
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  if $kernel::version != 'UNSET' {
    $current = $::kernelrelease

    if $current != $kernel::version {
      notify { 'kernel':
        message => "A reboot is required to change the running kernel from ${current} to ${kernel::version}"
      }
    }
  }

}
