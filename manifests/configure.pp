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
    file { '/opt/consul/etc/jenkins.json':
      ensure  => present,
      owner   => root,
      group   => root,
      content => '{"service":{ "name": "jenkins", "port": 8080, "checks": [{ "script": "/usr/bin/curl -o /dev/null -sf localhost:8080/login", "interval": "10s"}]}}',
      notify  =>  Exec['jenkins_reload_consul'],
    }

    exec { 'jenkins_reload_consul':
      command     => '/usr/local/bin/supervisorctl restart consul',
      refreshonly => true,
    }

  }

}
