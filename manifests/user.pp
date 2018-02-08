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

  file { '/var/lib/jenkins/.gitconfig':
    ensure  => present,
    owner   => jenkins,
    group   => jenkins,
    mode    => '0644',
    content => template('jenkins/gitconfig.erb'),
  }

}
