class docroots {
file { '//srv/staging_bifma/':
    ensure => 'directory',
    owner  => 'deploy',
    group  => 'deploy',
    mode   => '0775',
    }
file { '//srv/staging_bifma/current/':
    ensure => 'directory',
    owner  => 'deploy',
    group  => 'deploy',
    mode   => '0775',
    }
}