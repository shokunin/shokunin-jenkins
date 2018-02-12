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

}
