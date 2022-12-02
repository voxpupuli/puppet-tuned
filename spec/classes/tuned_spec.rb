# frozen_string_literal: true

require 'spec_helper'

describe 'tuned' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      describe 'with defaults' do
        it { is_expected.to compile }
        it { is_expected.to contain_class('tuned') }
        it { is_expected.to contain_class('tuned::package') }
        it { is_expected.to contain_class('tuned::config').that_requires('Class[tuned::package]') }
        it { is_expected.to contain_class('tuned::service').that_subscribes_to('Class[tuned::config]') }
        it { is_expected.to contain_class('tuned::active_profile').that_requires('Class[tuned::service]') }
      end

      describe 'with packages absent' do
        let(:params) do
          {
            'packages_ensure' => 'absent'
          }
        end

        it { is_expected.to compile }
        it { is_expected.to contain_class('tuned') }
        it { is_expected.to contain_class('tuned::package') }
        it { is_expected.not_to contain_class('tuned::config') }
        it { is_expected.not_to contain_class('tuned::service') }
        it { is_expected.not_to contain_class('tuned::active_profile') }
      end
    end
  end
end
