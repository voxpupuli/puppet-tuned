# frozen_string_literal: true

require 'spec_helper'
require 'facter'
require 'facter/tuned_active_profile'

describe :tuned_active_profile, type: :fact do
  subject(:fact) { Facter.fact(:tuned_active_profile) }

  before :each do
    # perform any action that should be run before every test
    Facter.clear
  end

  not_running_output = 'No current active profile.'
  active_profile_output = 'Current active profile: balanced'

  context 'with no tuned-adm' do
    before(:each) do
      expect(Facter::Util::Resolution).to receive(:which).at_least(1).with('tuned-adm').and_return(nil)
      expect(Facter::Core::Execution).not_to receive(:exec)
    end

    it do
      expect(fact.value).to eq(nil)
    end
  end

  context 'tuned not running' do
    before(:each) do
      expect(Facter::Util::Resolution).to receive(:which).at_least(1).with('tuned-adm').and_return('tuned-adm')
      expect(Facter::Core::Execution).to receive(:exec).with('tuned-adm active 2>/dev/null').and_return(not_running_output)
    end

    it do
      expect(fact.value).to eq(nil)
    end
  end

  context 'tuned running' do
    before(:each) do
      expect(Facter::Util::Resolution).to receive(:which).at_least(1).with('tuned-adm').and_return('tuned-adm')
      expect(Facter::Core::Execution).to receive(:exec).with('tuned-adm active 2>/dev/null').and_return(active_profile_output)
    end

    it do
      expect(fact.value).to eq('balanced')
    end
  end
end
