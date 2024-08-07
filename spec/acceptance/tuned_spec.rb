# frozen_string_literal: true

require 'spec_helper_acceptance'

describe 'tuned' do
  context 'with defaults values' do
    it_behaves_like 'an idempotent resource' do
      let(:manifest) { 'include tuned' }
    end

    describe service('tuned') do
      it { is_expected.to be_running }
      it { is_expected.to be_enabled }
    end

    describe command('tuned-adm list') do
      its(:exit_status) { is_expected.to eq 0 }
      its(:stdout) { is_expected.to match(%r{Available profiles:}) }
      its(:stdout) { is_expected.to match(%r{balanced}) }
    end
  end
end
