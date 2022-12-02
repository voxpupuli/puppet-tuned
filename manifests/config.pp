# @api private
#
# @summary setup any requested tuned config settings
#
# @param main_config_file
#   Path to your `/etc/tuned/tuned-main.conf`
# @param main_conf_ini_settings
#   Settings to put in `$main_config_file`
class tuned::config (
  # lint:ignore:parameter_types
  $main_config_file = $tuned::main_config_file,
  $main_conf_ini_settings = $tuned::main_conf_ini_settings,
  # lint:endignore
) inherits tuned {
  assert_private()

  # lint:ignore:140chars
  create_resources(ini_setting, $main_conf_ini_settings, { 'ensure' => 'present', 'path' => $main_config_file, 'section' => '' })
  # lint:endignore
}
