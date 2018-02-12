# Class: jenkins::user
# ===========================
class jenkins::user {

  group { 'jenkins':
    ensure  => present,
  }

  user { 'jenkins':
    ensure  => present,
    groups  => 'jenkins',
    require => Group['jenkins'],
    home    => '/var/lib/jenkins',
  }

  file { '/var/lib/jenkins/.bash_profile':
    ensure => present,
    owner  => 'jenkins',
    group  => 'jenkins',
    mode   => '0644',
    source => 'puppet:///modules/jenkins/bash_profile',
  }

  file { '/var/lib/jenkins/.bashrc':
    ensure => present,
    owner  => 'jenkins',
    group  => 'jenkins',
    mode   => '0644',
    source => 'puppet:///modules/jenkins/bash_rc',
  }

  file { '/var/lib/jenkins/.rvmrc':
    ensure => present,
    owner  => 'jenkins',
    group  => 'jenkins',
    mode   => '0644',
    source => 'puppet:///modules/jenkins/rvmrc',
  }

}
