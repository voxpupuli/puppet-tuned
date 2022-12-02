# @summary Setup the tuned daemon, config, and profile
#
# This class manages the tuned packages, config, service, and active profile
#
# @param package_names
#   What packages are part of tuned
# @param packages_ensure
#   Expected state of tuned packages
# @param main_config_file
#   Path to your `/etc/tuned/tuned-main.conf`
# @param main_conf_ini_settings
#   Settings to put in `$main_config_file`
# @param service_names
#   What services are part of tuned
# @param services_ensure
#   Expected state of tuned services
# @param services_enable
#   Expected state of tuned services
# @param enable_profile_now
#   Run `tuned-adm profile` if the profile is out of sync with `$active_profile`
# @param active_profile_source_file
#   Where to store default profile on daemon start (probably `/etc/tuned/active_profile`)
# @param active_profile
#   What profile should be used by this system
class tuned (
  Array[String[1]] $package_names,
  String[1] $packages_ensure,
  Stdlib::Absolutepath $main_config_file,
  Hash $main_conf_ini_settings,
  Array[String[1]] $service_names,
  Stdlib::Ensure::Service $services_ensure,
  Boolean $services_enable,
  Boolean $enable_profile_now,
  Stdlib::Absolutepath $active_profile_source_file,
  Optional[String] $active_profile,
) {
  contain tuned::package

  if $packages_ensure != 'absent' {
    contain tuned::config
    contain tuned::service
    contain tuned::active_profile

    Class['tuned::package'] -> Class['tuned::config'] ~> Class['tuned::service'] -> Class['tuned::active_profile']
  }
}
