# frozen_string_literal: true

require 'spec_helper'
require 'facter'
require 'facter/tuned_recommended_profile'

describe :tuned_recommended_profile, type: :fact do
  subject(:fact) { Facter.fact(:tuned_recommended_profile) }

  before :each do
    # perform any action that should be run before every test
    Facter.clear
  end

  recommend_output = 'virtual-guest'

  context 'with no tuned-adm' do
    before(:each) do
      expect(Facter::Util::Resolution).to receive(:which).at_least(1).with('tuned-adm').and_return(nil)
      expect(Facter::Core::Execution).not_to receive(:exec)
    end

    it do
      expect(fact.value).to eq(nil)
    end
  end

  context 'tuned recomend disabled' do
    before(:each) do
      expect(Facter::Util::Resolution).to receive(:which).at_least(1).with('tuned-adm').and_return('tuned-adm')
      expect(Facter::Core::Execution).to receive(:exec).with('tuned-adm recommend 2>/dev/null').and_return('')
    end

    it do
      expect(fact.value).to eq(nil)
    end
  end

  context 'tuned running' do
    before(:each) do
      expect(Facter::Util::Resolution).to receive(:which).at_least(1).with('tuned-adm').and_return('tuned-adm')
      expect(Facter::Core::Execution).to receive(:exec).with('tuned-adm recommend 2>/dev/null').and_return(recommend_output)
    end

    it do
      expect(fact.value).to eq('virtual-guest')
    end
  end
end
