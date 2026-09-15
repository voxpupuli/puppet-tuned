# frozen_string_literal: true

require 'logger'

Facter.add(:tuned_active_profile) do
  # https://docs.openvoxproject.org/openfact/latest/
  confine kernel: 'Linux'

  setcode do
    retval = nil

    if Facter::Core::Execution.which('tuned-adm')
      cmd = Facter::Core::Execution.execute('tuned-adm active', on_fail: nil, logger: Logger.new(File::NULL))
      retval = Regexp.last_match(1) if cmd && cmd =~ %r{^Current active profile: (.*)$}
    end

    retval
  end
end
