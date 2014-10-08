# Private class.
class kernel::params {

  case $::osfamily {
    'RedHat': {
      $package_name         = 'kernel'
      $devel_package_name   = 'kernel-devel'
      $headers_package_name = 'kernel-headers'

      if $::operatingsystemmajrelease <= 6 {
        $grub_class     = 'grub'
        $grub_conf_path = '/boot/grub/grub.conf'
      } else {
        $grub_class     = 'grub2'
        $grub_conf_path = '/etc/default/grub'
      }
    }

    default: {
      fail("Unsupported osfamily: ${::osfamily}, module ${module_name} only support osfamily RedHat")
    }
  }

}
