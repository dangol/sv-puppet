class ssh {
  package { "openssh-server": ensure => "installed" }
  service { "ssh": ensure => "running",
    enable => "true",
    require => Package["openssh-server"]
    }
  sshd_config { "PermitRootLogin":
    ensure    => present,
      value     => "no",
  }
  sshd_config { "X11Forwarding":
    ensure    => present,
    value     => no,
  }
  sshd_config { "MaxAuthTries":
    ensure    => present,
    value     => "10",
  }
  sshd_config { "UsePam":
    ensure    => present,
    value     => "yes",
  }
  sshd_config { "AllowGroups":
    ensure    => present,
    value     => ["rvm","infosec","deploy"],
  }
  sshd_config { "PrintMotd":
    ensure    => present,
    value     => yes,
  }
  sshd_config { "PermitUserEnvironment":
    ensure    => present,
    value     => no,
  }  
  sshd_config { "Ciphers":
    ensure    => present,
    value     => ["aes128-ctr","aes192-ctr","aes256-ctr"],
  }    
  sshd_config { "ClientAliveInterval":
    ensure    => present,
    value     => 900,
  }    
  sshd_config { "ClientAliveCountMax":
    ensure    => present,
    value     => 0,
  }      
}
