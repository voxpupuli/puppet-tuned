# frozen_string_literal: true

Facter.add(:tuned_active_profile) do
  # https://puppet.com/docs/puppet/latest/fact_overview.html
  confine kernel: 'Linux'

  setcode do
    retval = nil

    if Facter::Util::Resolution.which('tuned-adm')
      cmd = Facter::Core::Execution.exec('tuned-adm active 2>/dev/null')
      retval = Regexp.last_match(1) if cmd && cmd =~ %r{^Current active profile: (.*)$}
    end

    retval
  end
end
