# Reference

<!-- DO NOT EDIT: This document was generated by Puppet Strings -->

## Table of Contents

### Classes

#### Public Classes

* [`tuned`](#tuned): Setup the tuned daemon, config, and profile

#### Private Classes

* `tuned::active_profile`: set the active tuned profile
* `tuned::config`: setup any requested tuned config settings
* `tuned::package`: setup tuned packages
* `tuned::service`: manage tuned service

## Classes

### <a name="tuned"></a>`tuned`

This class manages the tuned packages, config, service, and active profile

#### Parameters

The following parameters are available in the `tuned` class:

* [`package_names`](#-tuned--package_names)
* [`packages_ensure`](#-tuned--packages_ensure)
* [`main_config_file`](#-tuned--main_config_file)
* [`main_conf_ini_settings`](#-tuned--main_conf_ini_settings)
* [`service_names`](#-tuned--service_names)
* [`services_ensure`](#-tuned--services_ensure)
* [`services_enable`](#-tuned--services_enable)
* [`enable_profile_now`](#-tuned--enable_profile_now)
* [`active_profile_source_file`](#-tuned--active_profile_source_file)
* [`active_profile`](#-tuned--active_profile)

##### <a name="-tuned--package_names"></a>`package_names`

Data type: `Array[String[1]]`

What packages are part of tuned

##### <a name="-tuned--packages_ensure"></a>`packages_ensure`

Data type: `String[1]`

Expected state of tuned packages

##### <a name="-tuned--main_config_file"></a>`main_config_file`

Data type: `Stdlib::Absolutepath`

Path to your `/etc/tuned/tuned-main.conf`

##### <a name="-tuned--main_conf_ini_settings"></a>`main_conf_ini_settings`

Data type: `Hash`

Settings to put in `$main_config_file`

##### <a name="-tuned--service_names"></a>`service_names`

Data type: `Array[String[1]]`

What services are part of tuned

##### <a name="-tuned--services_ensure"></a>`services_ensure`

Data type: `Stdlib::Ensure::Service`

Expected state of tuned services

##### <a name="-tuned--services_enable"></a>`services_enable`

Data type: `Boolean`

Expected state of tuned services

##### <a name="-tuned--enable_profile_now"></a>`enable_profile_now`

Data type: `Boolean`

Run `tuned-adm profile` if the profile is out of sync with `$active_profile`

##### <a name="-tuned--active_profile_source_file"></a>`active_profile_source_file`

Data type: `Stdlib::Absolutepath`

Where to store default profile on daemon start (probably `/etc/tuned/active_profile`)

##### <a name="-tuned--active_profile"></a>`active_profile`

Data type: `Optional[String]`

What profile should be used by this system

