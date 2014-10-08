# Private class.
class kernel::grub {
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  $grub_default_kernel = $kernel::grub_default_kernel ? {
    'UNSET' => $kernel::version,
    default => $kernel::grub_default_kernel,
  }

  if $kernel::set_default_kernel and $grub_default_kernel != 'UNSET' {
    augeas { 'set default kernel':
      context => "/files${kernel::grub_conf_path}",
      incl    => $kernel::grub_conf_path,
      lens    => 'Grub.lns',
      changes => [
        "set title[1] '${::operatingsystem} (${grub_default_kernel})'",
        "set title[1]/kernel '/vmlinuz-${grub_default_kernel}'",
        "set title[1]/initrd '/initramfs-${grub_default_kernel}.img'",
      ]
    }
  }

}
