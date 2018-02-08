# Class: jenkins::postinstall
# ===========================
class jenkins::postinstall {

  class { '::tfenv':
    manage_user  => false,
    manage_group => false,
    tfenv_user   => jenkins,
    tfenv_group  => jenkins,
  }

}
