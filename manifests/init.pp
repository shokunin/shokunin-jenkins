# Class: jenkins
# ===========================
class jenkins (
  Boolean $manage_apt_repo = true,
  String  $repo_url        = 'http://pkg.jenkins-ci.org/debian',
  String  $repo_key_id     = '150FDE3F7787E7D11EF4E12A9B7D32F2D50582E6',
  String  $repo_key_source = 'http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key',
){

  contain jenkins::apt_repo
  contain jenkins::install
  contain jenkins::configure
  contain jenkins::service

  Class['::jenkins::apt_repo']
  -> Class['::jenkins::install']
  -> Class['::jenkins::configure']
  -> Class['::jenkins::service']

}
