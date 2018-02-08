# Class: jenkins::postinstall
# ===========================
class jenkins::postinstall {

  include staging

  class { '::tfenv':
    manage_user  => false,
    manage_group => false,
    tfenv_user   => jenkins,
    tfenv_group  => jenkins,
  }

  class { '::rvm': }

  rvm_system_ruby {
    "ruby-${jenkins::ruby_version}":
      ensure      => 'present',
      default_use => true,
  }

  rvm_gemset {
    "ruby-${jenkins::ruby_version}@packer":
      ensure  => present,
      require => Rvm_system_ruby["ruby-${jenkins::ruby_version}"],
  }

  rvm_gem {
    'bundler':
      ensure       => latest,
      name         => 'bundler',
      ruby_version => "ruby-${jenkins::ruby_version}",
      require      => [ Rvm_system_ruby["ruby-${jenkins::ruby_version}"], Rvm_gemset["ruby-${jenkins::ruby_version}@packer"] ]
  }

  exec { 'add_jenkins_to_rvm_group':
    unless  => '/usr/bin/getent group rvm |/usr/bin/cut -d: -f4 |/bin/grep -q jenkins',
    command => '/usr/sbin/usermod -a -G rvm jenkins',
    require => [ Rvm_system_ruby["ruby-${jenkins::ruby_version}"], Rvm_gemset["ruby-${jenkins::ruby_version}@packer"] ]
  }

  staging::file { "packer_${jenkins::packer_version}.zip":
        source => "https://releases.hashicorp.com/packer/${jenkins::packer_version}/packer_${jenkins::packer_version}_linux_${::architecture}.zip"
      }
      -> file { "${::staging::path}/packer-${jenkins::packer_version}":
        ensure => directory,
      }
      -> staging::extract { "packer_${jenkins::packer_version}.zip":
        target  => "${::staging::path}/packer-${jenkins::packer_version}",
        creates => "${::staging::path}/packer-${jenkins::packer_version}/packer",
      }
      -> file {
        "${::staging::path}/packer-${jenkins::packer_version}/packer":
          owner => 'root',
          group => 0, # 0 instead of root because OS X uses "wheel".
          mode  => '0555';
        '/usr/local/bin/packer':
          ensure => link,
          target => "${::staging::path}/packer-${jenkins::packer_version}/packer";
      }

}
