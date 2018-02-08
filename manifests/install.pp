# Class: jenkins::install
# ===========================
class jenkins::install {

  each($jenkins::prereqs) |$pkg| {
    ensure_packages($pkg)
  }

  package { 'jenkins':
    ensure  => installed,
    require => Class['jenkins::apt_repo']
  }

}
