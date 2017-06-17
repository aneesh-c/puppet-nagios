class nagios::contacts (
  $package_name                  = $::nagios::params::package_name,
  $configfile_contacts           = $::nagios::params::configfile_contacts,
  $template_contacts             = 'nagios/contacts.erb',
  $contact_name                  = undef,
  $use                           = undef,
  $alias                         = undef,
  $email                         = undef,
  $service_notification_period   = undef,
  $host_notification_period      = undef,
  $service_notification_options  = undef,
  $host_notification_options     = undef,
  $service_notification_commands = undef,
  $host_notification_commands    = undef,
  $contactgroup_name             = undef,
  $contactgroup_alias            = undef,
  $members                       = undef,
) inherits nagios::params {
  file { $configfile_contacts:
    require => package[$package_name],
    backup  => '.backup',
    content => template($template_contacts),
  }
}
