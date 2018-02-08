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

}
