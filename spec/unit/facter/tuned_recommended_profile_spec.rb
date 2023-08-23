# frozen_string_literal: true

require 'spec_helper'
require 'facter'
require 'facter/tuned_recommended_profile'

describe ':tuned_recommended_profile', type: :fact do
  subject(:fact) { Facter.fact(:tuned_recommended_profile) }

  before do
    # perform any action that should be run before every test
    Facter.clear
  end

  recommend_output = 'virtual-guest'

  context 'with no tuned-adm' do
    it do
      allow(Facter::Util::Resolution).to receive(:which).at_least(1).with('tuned-adm').and_return(nil)
      allow(Facter::Core::Execution).to receive(:exec)
      expect(Facter::Core::Execution).not_to have_received(:exec)

      expect(fact.value).to be_nil
    end
  end

  context 'tuned recomend disabled' do
    it do
      allow(Facter::Util::Resolution).to receive(:which).at_least(1).with('tuned-adm').and_return('tuned-adm')
      allow(Facter::Core::Execution).to receive(:exec).with('tuned-adm recommend 2>/dev/null').and_return('')

      expect(fact.value).to be_nil
    end
  end

  context 'tuned running' do
    it do
      allow(Facter::Util::Resolution).to receive(:which).at_least(1).with('tuned-adm').and_return('tuned-adm')
      allow(Facter::Core::Execution).to receive(:exec).with('tuned-adm recommend 2>/dev/null').and_return(recommend_output)

      expect(fact.value).to eq('virtual-guest')
    end
  end
end
