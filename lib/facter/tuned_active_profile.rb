# frozen_string_literal: true

Facter.add(:tuned_active_profile) do
  # https://docs.openvoxproject.org/openfact/latest/
  confine { Facter::Core::Execution.which('tuned-adm') }

  setcode do
    cmd = Facter::Core::Execution.execute('tuned-adm active')
    %r{^Current active profile: (.*)$}.match(cmd)[1]
  end
end
