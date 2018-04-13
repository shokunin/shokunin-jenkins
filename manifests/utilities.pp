# Class: jenkins::utlities
# ===========================
class jenkins::utilities {

  # source for this can be found at https://raw.githubusercontent.com/shokunin/ops_scripts/master/elastic_search/logstash_cleanup.go
  file { '/usr/local/bin/logstash_cleanup':
    ensure => prent,
    owner  => root,
    group  => root,
    mode   => '0755',
    source => 'puppet:///modules/jenkins/logstash_cleanup',
  }

}
