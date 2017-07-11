node default {
  include user
  include ssh
  include ruby
}
class { 'fail2ban':
  ignoreip => ['127.0.0.1', '10.0.0.1'],
  bantime => '86400',
  jails => ['ssh', 'ssh-ddos'],
  maxretry => '2'
}
