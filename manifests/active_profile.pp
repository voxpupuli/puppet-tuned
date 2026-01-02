# @api private
#
# @summary set the active tuned profile
#
# @param enable_profile_now
#   Run `tuned-adm profile` if the profile is out of sync with `$active_profile`
# @param active_profile_source_file
#   Where to store default profile on daemon start (probably `/etc/tuned/active_profile`)
# @param active_profile
#   What profile should be used by this system
class tuned::active_profile (
  # lint:ignore:parameter_types
  $enable_profile_now = $tuned::enable_profile_now,
  $active_profile = $tuned::active_profile,
  $active_profile_source_file = $tuned::active_profile_source_file,
  # lint:endignore
) inherits tuned {
  assert_private()

  unless empty($active_profile) {
    if $enable_profile_now {
      if fact('tuned_active_profile') != $active_profile {
        # lint:ignore:exec_idempotency
        exec { "set tuned-adm profile to ${active_profile}":
          command => "tuned-adm profile ${active_profile}",
          path    => fact('path'),
        }
        # lint:endignore
      }
    }

    file { $active_profile_source_file:
      ensure  => 'file',
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      content => "${active_profile}\n",
    }
  }
}
