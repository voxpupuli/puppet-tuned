# @api private
#
# @summary manage tuned service
#
# @param service_names
#   What services are part of tuned
# @param services_ensure
#   Expected state of tuned services
class tuned::service (
  # lint:ignore:parameter_types
  $service_names = $tuned::service_names,
  $services_ensure = $tuned::services_ensure,
  $services_enable = $tuned::services_enable,
  # lint:endignore
) inherits tuned {
  assert_private()

  service { $service_names:
    ensure => $services_ensure,
    enable => $services_enable,
  }
}
