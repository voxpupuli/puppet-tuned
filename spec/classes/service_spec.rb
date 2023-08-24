# frozen_string_literal: true

require 'spec_helper'

describe 'tuned::service' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      describe 'with defaults' do
        it { is_expected.to compile }
        it { is_expected.to contain_service('tuned.service').with_ensure('running').with_enable(true) }
      end

      describe 'with args' do
        let(:params) do
          {
            'service_names' => %w[a b],
            'services_ensure' => 'stopped',
            'services_enable' => false,
          }
        end

        it { is_expected.to compile }
        it { is_expected.to contain_service('a').with_ensure('stopped').with_enable(false) }
        it { is_expected.to contain_service('b').with_ensure('stopped').with_enable(false) }
      end
    end
  end
end
