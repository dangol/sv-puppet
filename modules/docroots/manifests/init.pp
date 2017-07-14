class docroots {
# create document roots for all web containers, list them below:
 $docroots = [ '/srv/staging_bifma/', '/srv/staging_bifma/current/', ]

file { $docroots:
  ensure => 'directory',
  owner  => 'deploy',
  group  => 'deploy',
  mode   => '0775',
  }
}