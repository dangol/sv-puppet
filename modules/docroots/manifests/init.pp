class docroots {
# create document roots for all web containers, list them below:
$docroots = [  '/srv/','/srv/staging_bifma/','/srv/staging_bifma/current/','/srv/staging_cdr/','/srv/staging_cdr/current/','/srv/staging_mcf/','/srv/staging_mcf/current/','/srv/staging_rapid_screen/','/srv/staging_rapid_screen/current/','/srv/staging_rsl/','/srv/staging_rsl/current/','/srv/staging_ssp1/','/srv/staging_ssp1/current/','/srv/staging_toy/','/srv/staging_toy/current/','/srv/staging_toy2/','/srv/staging_toy2/current/' ]

file { $docroots:
  ensure => 'directory',
  owner  => 'deploy',
  group  => 'deploy',
  mode   => '0775',
  }
}