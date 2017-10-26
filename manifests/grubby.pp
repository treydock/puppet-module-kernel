# Private class.
class kernel::grubby{
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  $grub_default_kernel = $kernel::grub_default_kernel ? {
    Undef   => $kernel::kernel_version,
    default => $kernel::grub_default_kernel,
  }

  if $kernel::set_default_kernel and $grub_default_kernel {

    $_default_kernel = "/boot/vmlinuz-${grub_default_kernel}"

    exec { 'set default kernel':
      command => "/sbin/grubby --set-default=${_default_kernel}",
      path    => ['/bin','/usr/bin'],
      unless  => "/sbin/grubby --default-kernel | grep -q ${_default_kernel}",
    }
  }

}
