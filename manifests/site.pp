node default {
  include user
  include ssh
#  include ruby
  include apache
}
class { 'fail2ban':
  config_file_template     => "fail2ban/${::lsbdistcodename}/etc/fail2ban/jail.conf.erb",
  config_file_options_hash => {
  'bantime' => '86400',
  'maxretry' => '2'
 }
}