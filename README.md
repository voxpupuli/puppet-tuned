# tuned

Manage the tuned daemon

## Table of Contents

1. [Description](#description)
1. [Setup - The basics of getting started with tuned](#setup)
    * [What tuned affects](#what-tuned-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with tuned](#beginning-with-tuned)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Transfer Notice - All your module are belong to us](#transfer-notice)

## Description

Install/uninstall the tuned daemon, configure the settings, and set the profile.
You can run this in one-shot or daemon mode by setting the required options.

## Setup

### Beginning with tuned

Most users can probably get by with

```puppet
include tuned
```

By default the tuned recommended profile is activated unless you select another one.
This means two puppet runs are required in the default case: one to install tuned and one to populate the fact.

If you set `active_profile` to a specific value, rather than the fact fallthrough, just one run is required.

## Usage

The parameters you're most likly to need are:

* `main_conf_ini_settings`
* `enable_profile_now`
* `active_profile`

Odds are something like this should point you in the right direction:

```puppet
class { 'tuned':
  enable_profile_now => false,
  active_profile => 'hpc-compute',
  services_ensure => 'stopped',
  main_conf_ini_settings => {
    'use tuned oneshot mode' => {
      'setting' => 'daemon',
      'value' => 0,
    }
  }
}
```

or

```puppet
class { 'tuned':
  active_profile => 'desktop',
  main_conf_ini_settings => {
    'disable dynamic tuning' => {
      'setting' => 'dynamic_tuning',
      'value' => 0,
    }
  }
}
```

## Limitations

When run with the defaults, two runs are required to get the facts populated and utilized.

## Transfer Notice

This plugin was originally authored by @jcpunk. The maintainer preferred that Puppet Community take ownership of the module for future improvement and maintenance. Existing pull requests and issues were transferred over, please fork and continue to contribute here.

Previously: https://github.com/jcpunk/puppet-tuned
