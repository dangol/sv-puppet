node default {
  include user
  include ssh
#  include ruby
  include apache
}
class { 'apache':
  default_vhost => false,
}
file { '//srv/staging_bifma/current/':
    ensure => 'directory',
    owner  => 'deploy',
    group  => 'deploy',
    mode   => '0775',
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