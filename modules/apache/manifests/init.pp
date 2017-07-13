class { 'apache':
  default_vhost => false,
}
apache::vhost { 'staging-bifma.scivera.com':
  servername => 'staging-bifma.scivera.com',
  port       => '80',
  docroot    => '/srv/staging_bifma/current/public',
  redirect_status => 'permanent',
  redirect_dest   => 'https://staging-bifma.scivera.com/'
  firewall { '100 allow http and https access':
    dport  => [80, 443],
    proto  => tcp,
    action => accept,
  }
}
apache::vhost { 'staging-bifma.scivera.com':
  servername => 'staging-bifma.scivera.com',
  port    => '443',
  docroot => '/srv/staging_bifma/current/public',
  ssl     => true,
}