# frozen_string_literal: true

Facter.add(:tuned_recommended_profile) do
  # https://puppet.com/docs/puppet/latest/fact_overview.html
  confine kernel: 'Linux'

  setcode do
    retval = nil

    if Facter::Util::Resolution.which('tuned-adm')
      retval = Facter::Core::Execution.exec('tuned-adm recommend 2>/dev/null')
      retval = nil if retval == ''
    end

    retval
  end
end
