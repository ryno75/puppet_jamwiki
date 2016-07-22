require 'spec_helper'

describe 'jamwiki' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end

        context "jamwiki class without any parameters" do
          it { is_expected.to compile.with_all_deps }

          it { is_expected.to contain_class('jamwiki::params') }
          it { is_expected.to contain_class('jamwiki::install').that_comes_before('jamwiki::config') }
          it { is_expected.to contain_class('jamwiki::config') }
          it { is_expected.to contain_class('jamwiki::service').that_subscribes_to('jamwiki::config') }

          it { is_expected.to contain_service('jamwiki') }
          it { is_expected.to contain_package('jamwiki').with_ensure('present') }
        end
      end
    end
  end

  context 'unsupported operating system' do
    describe 'jamwiki class without any parameters on Solaris/Nexenta' do
      let(:facts) do
        {
          :osfamily        => 'Solaris',
          :operatingsystem => 'Nexenta',
        }
      end

      it { expect { is_expected.to contain_package('jamwiki') }.to raise_error(Puppet::Error, /Nexenta not supported/) }
    end
  end
end
