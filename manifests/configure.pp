# Class: jenkins::configure
# ===========================
class jenkins::configure {

  file { '/var/lib/jenkins/.gitconfig':
    ensure  => present,
    owner   => jenkins,
    group   => jenkins,
    mode    => '0644',
    content => template('jenkins/gitconfig.erb'),
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


  if $::jenkins_has_consul { 
    notify { 'DTM: Enabled': }
  } else {
    notify { 'DTM: Enabled': }
  }

}
