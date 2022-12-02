# @api private
#
# @summary setup tuned packages
#
# @param package_names
#   What packages are part of tuned
# @param packages_ensure
#   Expected state of tuned packages
class tuned::package (
  # lint:ignore:parameter_types
  $package_names = $tuned::package_names,
  $packages_ensure = $tuned::packages_ensure,
  # lint:endignore
) inherits tuned {
  assert_private()

  package { $package_names:
    ensure => $packages_ensure,
  }
}
