# puppet-module-kernel

[![Build Status](https://travis-ci.org/treydock/puppet-module-kernel.png)](https://travis-ci.org/treydock/puppet-module-kernel)

####Table of Contents

1. [Overview](#overview)
2. [Usage - Configuration options](#usage)
3. [Reference - Parameter and detailed reference to all options](#reference)
4. [Limitations - OS compatibility, etc.](#limitations)
5. [Development - Guide for contributing to the module](#development)
6. [TODO](#todo)
7. [Additional Information](#additional-information)

## Overview

The kernel Puppet module allows for managing the kernel packages and the default GRUB kernel.

## Usage

### kernel

The default behavior of this module is to ensure the kernel package is present.

    class { 'kernel': }

This is an example of ensuring a specific version of the kernel is installed and set as the default in GRUB.

    class { 'kernel'
      version => '2.6.32-431.23.3.el6'
    }

## Reference

### Classes

#### Public classes

* `kernel`: Installs and configures kernel.

#### Private classes

* `kernel::install`: Installs kernel packages.
* `kernel::config`: Checks if running kernel matches version set in parameters.
* `kernel::grub`: Manages GRUB default kernel.
* `kernel::grub2`: Manages GRUB2 default kernel.
* `kernel::grubby`: Manages GRUB and GRUB2 default kernel using grubby command.
* `kernel::params`: Sets parameter defaults based on fact values.

### Parameters

#### kernel

#####`version`

The desired kernel version to be installed.  Must be the full string that would be output by running `uname -r`.  Default of 'UNSET' disables management of kernel package version.

#####`package_ensure`

Package ensure parameter.  Valid values are 'present' or 'latest'. Defaults to `'present'`.

#####`package_name`

The kernel package name.  Default is OS dependent.

#####`install_dev`

Boolean to specify whether the kernel-devel package should be installed.  Default to `false`.

#####`devel_package_name`

The kernel development package name.  Default is OS dependent.

#####`install_headers`

Boolean to specify whether the kernel-headers package should be installed.  Default to `false`.

#####`headers_package_name`

The kernel headers package name.  Default is OS dependent.

#####`install_firmware`

Boolean to specify whether the kernel-firmware package should be installed.  Default to `false`.

#####`firmware_package_name`

The kernel firmware package name.  Default is OS dependent.

#####`set_default_kernel`

Boolean to specify whether if the default kernel in GRUB should be modified by this module.  Default to `true`.

#####`grub_default_kernel`

The kernel version to set as default in GRUB.  Default is the value of `$version`.

#####`grub_conf_path`

The path to GRUB configuration file.  Default is OS dependent.

#####`grub_class`

The class to be used to manage GRUB.  Default for EL6 is `grub` and default for EL7 is `grub2` (not yet implemented).  The `grubby` class is also available.

## Limitations

This module has been tested on:

* CentOS 6 x86_64

## Development

### Testing

Testing requires the following dependencies:

* rake
* bundler

Install gem dependencies

    bundle install

Run unit tests

    bundle exec rake test

If you have Vagrant >= 1.2.0 installed you can run system tests

    bundle exec rake beaker

## TODO

## Further Information
