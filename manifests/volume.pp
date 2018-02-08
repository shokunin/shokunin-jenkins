# Class: jenkins::volume
# ===========================
class jenkins::volume {
  unless $jenkins::disk_device == '' {
    include ::lvm
    include ::stdlib

    filesystem { $jenkins::disk_device:
      ensure  => present,
      fs_type => 'ext4',
    }

    file { $jenkins::disk_mount:
      ensure => directory,
      owner  => jenkins,
      group  =>  jenkins,
    }

    file_line { 'jenkins_mount':
      path => '/etc/fstab',
      line => "${jenkins::disk_device} ${jenkins::disk_mount} ext4  defaults,nofail 0  2"
    }

  }
}
