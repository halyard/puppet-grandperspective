require 'spec_helper'

describe 'grandperspective' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end

        context "grandperspective class without any parameters" do
          let(:params) {{ }}

          it { is_expected.to compile.with_all_deps }

          it { is_expected.to contain_class('grandperspective::params') }
          it { is_expected.to contain_class('grandperspective::install').that_comes_before('grandperspective::config') }
          it { is_expected.to contain_class('grandperspective::config') }
          it { is_expected.to contain_class('grandperspective::service').that_subscribes_to('grandperspective::config') }

          it { is_expected.to contain_service('grandperspective') }
          it { is_expected.to contain_package('grandperspective').with_ensure('present') }
        end
      end
    end
  end

  context 'unsupported operating system' do
    describe 'grandperspective class without any parameters on Solaris/Nexenta' do
      let(:facts) {{
        :osfamily        => 'Solaris',
        :operatingsystem => 'Nexenta',
      }}

      it { expect { is_expected.to contain_package('grandperspective') }.to raise_error(Puppet::Error, /Nexenta not supported/) }
    end
  end
end
