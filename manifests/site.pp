node default {
  include user
  include ssh
  include fail2ban
  include docroots
#  include apache
  include passenger
}
class { 'apache':
  default_vhost => false,
}
apache::vhost { 'staging.bifma':
  port          => '80',
  docroot       => '/srv/staging_bifma/current/public',
  }
class clamav {
  package { 'clamav':
  ensure => 'installed',
  }
}
