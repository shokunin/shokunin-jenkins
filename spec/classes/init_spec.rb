require 'spec_helper'
describe 'jenkins' do
  let(:facts) do
    {
      'osfamily' => 'Debian',
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
  end
end
