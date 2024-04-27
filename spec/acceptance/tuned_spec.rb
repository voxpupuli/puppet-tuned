# frozen_string_literal: true

require 'spec_helper_acceptance'

describe 'tuned' do
  context 'with defaults values' do
    pp = <<-EOS
    include tuned
    EOS

    it 'works with no errors' do
      apply_manifest(pp, catch_failures: true)
      # apply twice so that the tuned_recommended_profile fact is present
      apply_manifest(pp, catch_failures: true)
    end

    it 'works idempotently' do
      # at least idempotently after two real runs
      apply_manifest(pp, catch_changes: true)
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
