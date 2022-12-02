# frozen_string_literal: true

require 'spec_helper'

describe 'tuned::config' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      describe 'with defaults' do
        it { is_expected.to compile }
        it { is_expected.to have_ini_setting_resource_count(0) }
      end

      describe 'with args' do
        let(:params) do
          {
            'main_config_file' => '/some/file',
            'main_conf_ini_settings' => {
              'disable dynamic tuning' => {
                'setting'              => 'dynamic_tuning',
                'value'                => '0',
              },
              'disable daemon' => {
                'ensure' => 'absent',
                'setting' => 'daemon',
                'value' => false,
              }
            }
          }
        end

        it { is_expected.to compile }
        it {
          is_expected.to contain_ini_setting('disable dynamic tuning')
            .with_ensure('present')
            .with_setting('dynamic_tuning')
            .with_value('0')
            .with_path('/some/file')
            .with_section('')
        }
        it {
          is_expected.to contain_ini_setting('disable daemon')
            .with_ensure('absent')
            .with_setting('daemon')
            .with_value(false)
            .with_path('/some/file')
            .with_section('')
        }
      end
    end
  end
end
