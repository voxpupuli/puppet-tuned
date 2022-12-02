# frozen_string_literal: true

require 'spec_helper'

describe 'tuned::active_profile' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      # it { pp catalogue.resources }
      describe 'with defaults' do
        let(:facts) { os_facts.merge({ 'tuned_active_profile' => nil }) }

        it { is_expected.to compile }
        it {
          is_expected.to contain_file('/etc/tuned/active_profile')
            .with_ensure('file')
            .with_owner('root')
            .with_group('root')
            .with_mode('0644')
            .with_content("\n")
        }
        it { is_expected.to have_exec_resource_count(0) }
      end

      describe 'with profile from fact' do
        let(:facts) { os_facts.merge({ 'tuned_active_profile' => nil, 'tuned_recommended_profile' => 'desktop' }) }

        it { is_expected.to compile }
        it {
          is_expected.to contain_file('/etc/tuned/active_profile')
            .with_ensure('file')
            .with_owner('root')
            .with_group('root')
            .with_mode('0644')
            .with_content("desktop\n")
        }
        it { is_expected.to contain_exec('set tuned-adm profile to desktop').with_command('tuned-adm profile desktop') }
      end

      describe 'with profile from fact and already set' do
        let(:facts) { os_facts.merge({ 'tuned_active_profile' => 'desktop', 'tuned_recommended_profile' => 'desktop' }) }

        it { is_expected.to compile }
        it {
          is_expected.to contain_file('/etc/tuned/active_profile')
            .with_ensure('file')
            .with_owner('root')
            .with_group('root')
            .with_mode('0644')
            .with_content("desktop\n")
        }
        it { is_expected.to have_exec_resource_count(0) }
      end

      describe 'with profile from fact but do not set' do
        let(:facts) { os_facts.merge({ 'tuned_active_profile' => nil, 'tuned_recommended_profile' => 'desktop' }) }
        let(:params) { { 'enable_profile_now' => false } }

        it { is_expected.to compile }
        it {
          is_expected.to contain_file('/etc/tuned/active_profile')
            .with_ensure('file')
            .with_owner('root')
            .with_group('root')
            .with_mode('0644')
            .with_content("desktop\n")
        }
        it { is_expected.to have_exec_resource_count(0) }
      end

      describe 'with profile from fact and arg' do
        let(:facts) { os_facts.merge({ 'tuned_active_profile' => nil, 'tuned_recommended_profile' => 'desktop' }) }
        let(:params) { { 'active_profile' => 'virtual-guest', 'active_profile_source_file' => '/some/file' } }

        it { is_expected.to compile }
        it {
          is_expected.to contain_file('/some/file')
            .with_ensure('file')
            .with_owner('root')
            .with_group('root')
            .with_mode('0644')
            .with_content("virtual-guest\n")
        }
        it { is_expected.to contain_exec('set tuned-adm profile to virtual-guest').with_command('tuned-adm profile virtual-guest') }
      end
    end
  end
end
