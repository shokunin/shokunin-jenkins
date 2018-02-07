# Class: jenkins::apt_repo
# ===========================
class jenkins::apt_repo {
  if $jenkins::manage_apt_repo {
    include ::apt
    apt::source { 'jenkins-ci':
      location => $jenkins::repo_url,
      release  => 'binary/',
      repos    => '',
      key      => {
        id     => $jenkins::repo_key_id,
        source => $jenkins::repo_key_source,
      }
    }

  }
}
