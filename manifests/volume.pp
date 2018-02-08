# Class: jenkins::volume
# ===========================
class jenkins::volume {
  unless $jenkins::disk_device == '' {
    include ::lvm

    physical_volume { $jenkins::disk_device:
      ensure => present,
    }

    filesystem { $jenkins::disk_device:
      ensure  => present,
      fs_type => 'ext4',
      require => Physical_Volume[$jenkins::disk_device],
    }

    file { $jenkins::disk_mount:
      ensure => directory,
      owner  => jenkins,
      group  =>  jenkins,
    }

  }
}
