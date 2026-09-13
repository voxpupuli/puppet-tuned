# frozen_string_literal: true

Facter.add(:tuned_recommended_profile) do
  # https://docs.openvoxproject.org/openfact/latest/
  confine kernel: 'Linux'

  setcode do
    retval = nil

    if Facter::Core::Execution.which('tuned-adm')
      retval = Facter::Core::Execution.execute('tuned-adm recommend', on_fail: nil, stderr: '/dev/null')
      retval = nil if retval == ''
    end

    retval
  end
end
