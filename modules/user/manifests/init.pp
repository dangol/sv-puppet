class user {
  group { 'deploy':
  ensure => present,
  }
  group { 'dan':
  ensure => present,
  }
  user { 'dan':
    ensure => present,
    comment => 'dan',
    gid => 'dan',
    groups => ['admin'],
    home => '/home/dan',
    managehome => true,
    shell => '/bin/bash',
  }
  user { 'deploy':
    ensure => 'present',
    password => '$1$cIi844cd$dkCSXo45v9RpWj4c4JfIi0',
    comment => 'deploy',
    gid => 'deploy',
    groups => ['admin'],
    home => '/home/deploy',
    shell => '/bin/bash',
    managehome => true,
  }
  ssh_authorized_key { 'deploy_ssh':
  user => 'deploy',
    type => 'rsa',
    key => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQCJCr/FCxC1BBf2wBvoThvNCaG5ito0pUM2mcbM+MfBO77T5xJn8b3uGw5OMOGcwf0zrYwx9ea/NSV22e0U4XhdYpFliSt2ddMGi2W4rnapChrRg2wWIR9pPb5csOQ+WDj071J1ueDWV1VNRxy0MrI3gOAflrhrE2oFxiaSB2K8YDolSRjj649zydyxe9qLkQfR3l84LNJX6ogMboY0Qf2LT/6xeCc9+g/p+lbKKzPhdj6dgzLurivVddf6qKw0bCG6hfIwBOH5HPo8kTRdET+Th43o1AAsl+w5Ox+BHo2JIkiVKZvAlm550lPdMPlrON8N3z/wYa1wWxmBFBHCYHoD',
  }
  ssh_authorized_key { 'dan_ssh':
  user => 'dan',
    type => 'rsa',
    key => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQCJCr/FCxC1BBf2wBvoThvNCaG5ito0pUM2mcbM+MfBO77T5xJn8b3uGw5OMOGcwf0zrYwx9ea/NSV22e0U4XhdYpFliSt2ddMGi2W4rnapChrRg2wWIR9pPb5csOQ+WDj071J1ueDWV1VNRxy0MrI3gOAflrhrE2oFxiaSB2K8YDolSRjj649zydyxe9qLkQfR3l84LNJX6ogMboY0Qf2LT/6xeCc9+g/p+lbKKzPhdj6dgzLurivVddf6qKw0bCG6hfIwBOH5HPo8kTRdET+Th43o1AAsl+w5Ox+BHo2JIkiVKZvAlm550lPdMPlrON8N3z/wYa1wWxmBFBHCYHoD',
  }
}

