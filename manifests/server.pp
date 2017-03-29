define nagios::server (
  $package_name      = $::nagios::params::package_name,
  $configdir_server  = $::nagios::params::configdir_server,
  $template_server   = 'nagios/server.cfg.erb',
  $configfile_server = undef,
  $define_host       = [],
  $define_service    = [],
) {
  include nagios::params
  file { $configdir_server:
    ensure => directory,
  }
  file { "${configdir_server}/${configfile_server}":
    require => package[$package_name],
    content => template($template_server),
  }
}
