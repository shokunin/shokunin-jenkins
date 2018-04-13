# Class: jenkins
# ===========================
class jenkins (
  Boolean $manage_apt_repo  = true,
  Boolean $manage_utilities = false,
  Array   $prereqs          = ['openjdk-8-jre-headless'],
  String  $disk_device      = '',
  String  $disk_mount       = '/var/lib/jenkins',
  String  $packer_version   = '1.1.3',
  String  $ruby_version     = '2.3.3',
  String  $repo_url         = 'http://pkg.jenkins-ci.org/debian',
  String  $repo_key_id      = '150FDE3F7787E7D11EF4E12A9B7D32F2D50582E6',
  String  $repo_key_source  = 'http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key',
){

  contain jenkins::apt_repo
  contain jenkins::install
  contain jenkins::configure
  contain jenkins::service
  contain jenkins::volume
  contain jenkins::user
  contain jenkins::postinstall

  if $::jenkins::manage_utilities {
    include ::jenkins::utilities
  }

  Class['::jenkins::apt_repo']
  -> Class['::jenkins::user']
  -> Class['::jenkins::volume']
  -> Class['::jenkins::install']
  -> Class['::jenkins::configure']
  -> Class['::jenkins::postinstall']
  -> Class['::jenkins::service']

}
