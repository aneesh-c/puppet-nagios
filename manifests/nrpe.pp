class nagios::nrpe (
  $package_name_nrpe = $::nagios::params::package_name_nrpe,
  $configfile_nrpe   = '/etc/nagios/nrpe.cfg',
  $template_nrpe     = $::nagios::params::template_nrpe,
  $allowed_hosts     = '127.0.0.1',
  $dont_blame_nrpe   = '1',
  $command           = [],
) inherits ::nagios::params {
  package { $package_name_nrpe: ensure => installed }
  file { $configfile_nrpe:
    require => package[$package_name_nrpe],
    content => template($template_nrpe),
  }
  if $::osfamily == 'RedHat' {
    service { 'nrpe':
      require => package[$package_name_nrpe],
      enable  => true,
    }
  }
}
