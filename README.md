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

[http://treydock.github.io/puppet-module-kernel/](http://treydock.github.io/puppet-module-kernel/)

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
