# frozen_string_literal: true

require 'logger'

Facter.add(:tuned_recommended_profile) do
  # https://docs.openvoxproject.org/openfact/latest/
  confine kernel: 'Linux'

  setcode do
    retval = nil

    if Facter::Core::Execution.which('tuned-adm')
      retval = Facter::Core::Execution.execute('tuned-adm recommend', on_fail: nil, logger: Logger.new(File::NULL))
      retval = nil if retval == ''
    end

    retval
  end
end
