class nagios::nrpe (
  $package_name_nrpe               = $::nagios::params::package_name_nrpe,
  $configfile_nrpe                 = '/etc/nagios/nrpe.cfg',
  $template_nrpe                   = 'nagios/nrpe.erb',
  $log_facility                    = undef,
  $pid_file                        = undef,
  $server_port                     = undef,
  $nrpe_user                       = undef,
  $nrpe_group                      = undef,
  $allowed_hosts                   = undef,
  $dont_blame_nrpe                 = undef,
  $allow_bash_command_substitution = undef,
  $debug                           = undef,
  $command_timeout                 = undef,
  $connection_timeout              = undef,
  $command                         = [],
  $include_dir                     = [],
  $include                         = [],
) inherits ::nagios::params {
  package { $package_name_nrpe: ensure => installed }
  file { $configfile_nrpe:
    require => package[$package_name_nrpe],
    backup  => '.backup',
    content => template($template_nrpe),
  }
  if $::osfamily == 'RedHat' {
    service { 'nrpe':
      require => package[$package_name_nrpe],
      enable  => true,
    }
  }
}
