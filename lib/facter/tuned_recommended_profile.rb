# frozen_string_literal: true

Facter.add(:tuned_recommended_profile) do
  # https://puppet.com/docs/puppet/latest/fact_overview.html
  confine kernel: 'Linux'

  if Facter::Util::Resolution.which('tuned-adm')
    retval = Facter::Core::Execution.exec('tuned-adm recommend 2>/dev/null')
    if retval == ''
      retval = nil
    end
  end

  setcode do
    retval
  end
end
