node default {
  include user
  include ssh
#  include ruby
  include docroots
  include apache
}
class { 'apache':
  default_vhost => false,
}
apache::vhost { 'staging.bifma':
  port          => '80',
  docroot       => '/srv/staging_bifma/current/public',
  }
<<<<<<< HEAD
=======

>>>>>>> 31ac17554102d63305dcbe0a722167c3fb010f2f
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
class { '::nodejs':
  manage_package_repo       => false,
  nodejs_dev_package_ensure => 'present',
  npm_package_ensure        => 'present',
}
