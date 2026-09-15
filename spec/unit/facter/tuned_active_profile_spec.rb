# frozen_string_literal: true

require 'spec_helper'
require 'facter'
require 'facter/tuned_active_profile'

describe ':tuned_active_profile', type: :fact do
  subject(:fact) { Facter.fact(:tuned_active_profile) }

  before do
    # perform any action that should be run before every test
    Facter.clear
  end

  not_running_output = 'No current active profile.'
  active_profile_output = 'Current active profile: balanced'

  context 'with no tuned-adm' do
    it do
      allow(Facter::Core::Execution).to receive(:which).with('tuned-adm').and_return(nil)
      allow(Facter::Core::Execution).to receive(:execute).and_return(nil)
      expect(Facter::Core::Execution).not_to have_received(:execute)

      expect(fact.value).to be_nil
    end
  end

  context 'tuned not running' do
    it do
      allow(Facter::Core::Execution).to receive(:which).with('tuned-adm').and_return('tuned-adm')
      allow(Facter::Core::Execution).to receive(:execute).and_call_original
      allow(Facter::Core::Execution).to receive(:execute).with('tuned-adm active', hash_including(on_fail: nil, logger: instance_of(Logger))).and_return(not_running_output)

      expect(fact.value).to be_nil
    end
  end

  context 'tuned running' do
    it do
      allow(Facter::Core::Execution).to receive(:which).with('tuned-adm').and_return('tuned-adm')
      allow(Facter::Core::Execution).to receive(:execute).and_call_original
      allow(Facter::Core::Execution).to receive(:execute).with('tuned-adm active', hash_including(on_fail: nil, logger: instance_of(Logger))).and_return(active_profile_output)

      expect(fact.value).to eq('balanced')
    end
  end
end
