node default {
  include user
  include ssh
  include ruby
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
class { 'fail2ban':
  config_file_template     => "fail2ban/${::lsbdistcodename}/etc/fail2ban/jail.conf.erb",
  config_file_options_hash => {
  'bantime' => '86400',
  'maxretry' => '2'
 }
}
class clamav {
  package { 'clamav':
  ensure => 'installed',
  }
}
