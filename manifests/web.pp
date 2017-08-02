node default {
  include user
  include ssh
  include fail2ban
  include docroots
  include passenger
  include pdfkit
}
class { 'apache':
  default_vhost => false,
}
apache::vhost { 'staging.bifma':
  port          => '80',
  docroot       => '/srv/staging_bifma/current/public',
}