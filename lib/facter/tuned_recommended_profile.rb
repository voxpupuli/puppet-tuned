# frozen_string_literal: true

Facter.add(:tuned_recommended_profile) do
  # https://docs.openvoxproject.org/openfact/latest/
  confine { Facter::Core::Execution.which('tuned-adm') }

  setcode do
    cmd = Facter::Core::Execution.execute('tuned-adm recommend')
    cmd.empty? ? nil : cmd
  end
end
