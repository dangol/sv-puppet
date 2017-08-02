class pdfkit {
  package { 'xz-utils':
    ensure => 'installed',}
  package { 'libxrender1':
    ensure => 'installed',}
  package { 'libfontconfig1':
    ensure => 'installed',}
  exec { 'getwkhtmltopdf':
    command => 'wget -O /tmp/wkhtmltox-0.12.4_linux-generic-amd64.tar.xz https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.4/wkhtmltox-0.12.4_linux-generic-amd64.tar.xz',
    path => '/usr/bin',
}
  exec { 'untar_wkhtmltopdf':
        command => 'tar xvJf /tmp/wkhtmltox-0.12.4_linux-generic-amd64.tar.xz -C /tmp; mv /tmp/wkhtmltox/bin/wkhtmltopdf /usr/local/bin/wkhtmltopdf; mv /tmp/wkhtmltox/bin/wkhtmltoimage /usr/local/bin/wkhtmltoimage; chmod +x /usr/local/bin/wkhtmltopdf; chmod +x /usr/local/bin/wkhtmltoimage; rm -Rf /tmp/wkht*',
       path => '/usr/bin/:/bin/',
}
  package { 'pdfkit':
    ensure => 'installed',
    provider => 'gem',
  }
}
