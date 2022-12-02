# frozen_string_literal: true

require 'spec_helper'

describe 'tuned::package' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      describe 'with defaults' do
        it { is_expected.to compile }
        it { is_expected.to contain_package('tuned').with_ensure('installed') }
      end

      describe 'with args' do
        let(:params) do
          {
            'package_names' => ['a', 'b'],
            'packages_ensure' => 'latest',
          }
        end

        it { is_expected.to compile }
        it { is_expected.to contain_package('a').with_ensure('latest') }
        it { is_expected.to contain_package('b').with_ensure('latest') }
      end
    end
  end
end
