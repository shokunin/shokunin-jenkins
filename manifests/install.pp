# Class: jenkins::install
# ===========================
class jenkins::install {

  notify {"DTM: ${jenkins::prereqs}"}
  each($jenkins::prereqs) |$pkg| {
    notify {"DTM: ${$pkg}"}
    ensure_packages($pkg)
  }

  package { 'jenkins':
    ensure  => installed,
    require => Class['jenkins::apt_repo']
  }

}
