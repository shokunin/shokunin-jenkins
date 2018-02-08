# Class: jenkins::postinstall
# ===========================
class jenkins::postinstall {

  class { '::tfenv':
    manage_user  => false,
    manage_group => false,
    tfenv_user   => jenkins,
    tfenv_group  => jenkins,
  }

  class { '::rvm': }

  rvm_system_ruby {
    'ruby-2.3.3':
      ensure      => 'present',
      default_use => true,
  }

  rvm_gemset {
    'ruby-2.3.3@packer':
      ensure  => present,
      require => Rvm_system_ruby['ruby-2.3.3'],
  }

  rvm_gem {
    'bundler':
      ensure       => latest,
      name         => 'bundler',
      ruby_version => 'ruby-2.3.3',
      require      => [ Rvm_system_ruby['ruby-2.3.3'], Rvm_gemset['ruby-2.3.3@packer'] ]
  }

  exec { 'add_jenkins_to_rvm_group':
    unless  => '/usr/bin/getent group rvm |/usr/bin/cut -d: -f4 |/bin/grep -q jenkins',
    command => '/usr/sbin/usermod -a -G rvm jenkins',
    require      => [ Rvm_system_ruby['ruby-2.3.3'], Rvm_gemset['ruby-2.3.3@packer'] ]
  }

}
