class nagios::commands (
  $package_name        = $::nagios::params::package_name,
  $configfile_commands = $::nagios::params::configfile_commands,
  $template_commands   = $::nagios::params::template_commands,
  $define_command      = [],
) inherits nagios::params {
  file { $configfile_commands:
    require => package[$package_name],
    content => template($template_commands),
  }
}
