# Class: jenkins::user
# ===========================
class jenkins::user {

  group { 'jenkins':
    ensure  => present,
  }

  user { 'jenkins':
    ensure  => present,
    groups  => 'jenkins',
    require =>  Group['jenkins'],
  }

  file { '/home/jenkins/.gitconfig':
    ensure  => present,
    owner   => jenkins,
    group   => jenkins,
    mode    => '0644',
    content => template('jenkins/gitconfig.erb'),
  }

}
