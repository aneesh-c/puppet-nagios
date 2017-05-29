# == Class: nagios
#
# === Examples
#
#  class { 'nagios':
#    email   => 'admin@example.com',
#  }
#
# === Authors
#
# Aneesh C <aneeshchandrasekharan@gmail.com>
#

class nagios (
  $package_name            = $::nagios::params::package_name,
  $configfile_nagios       = $::nagios::params::configfile_nagios,
  $configfile_contacts     = $::nagios::params::configfile_contacts,
  $template_nagios         = $::nagios::params::template_nagios,
  $template_contacts       = $::nagios::params::template_contacts,
  $cfg_dir                 = [],
  $check_external_commands = undef,
  $email                   = undef,
) inherits ::nagios::params {
  package { $package_name: ensure => installed }
  file { $configfile_nagios:
    require => Package[$package_name],
    content => template($template_nagios),
  }
  file { $configfile_contacts:
    require => Package[$package_name],
    content => template($template_contacts),
  }
  if $::osfamily == 'RedHat' {
    service { 'nagios':
      require => package[$package_name],
      enable  => true,
    }
  }
}
