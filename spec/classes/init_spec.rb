require 'spec_helper'
describe 'jenkins' do
  let(:facts) do
    {
      'fqdn' => 'testjenkinsbox',
      'osfamily' => 'Debian',
      'operatingsystem' => 'Ubuntu',
      'architecture' => 'amd64',
      'staging_http_get' => 'wget',
      'path' => '/tmp',
      'root_home' => '/tmp',
      'kernel' => 'Linux',
      'os' => {
        'name'    => 'Ubuntu',
        'family'  => 'Debian',
        'release' => { 'major' => '16.04', 'full' => '16.04' },
        'lsb'     =>
                              {
                                'distcodename'    => 'xenial',
                                'distid'          => 'Ubuntu',
                                'distdescription' => 'Ubuntu 16.04.3 LTS',
                                'distrelease'     => '16.04',
                                'majdistrelease'  => '16.04'
                              }
      }
    }
  end
  context 'with default values for all parameters' do
    it { should contain_class('jenkins') }
    it { is_expected.to contain_package('openjdk-8-jre-headless') }
    it { is_expected.to contain_user('jenkins') }
    it { is_expected.to contain_group('jenkins') }
    it { is_expected.to contain_package('jenkins') }
    it { is_expected.to contain_service('jenkins').with('ensure' => 'running', 'enable' => true) }
    it { should contain_file('/var/lib/jenkins/.gitconfig').with_content(/jenkins@testjenkinsbox/) }
    it { should contain_file('/var/lib/jenkins/.bashrc') }
    it { should contain_file('/var/lib/jenkins/.bash_profile') }
    it { should contain_file('/var/lib/jenkins/.rvmrc') }
  end
end
