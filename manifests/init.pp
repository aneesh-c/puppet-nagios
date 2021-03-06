# == Class: nagios
#
# === Examples
#
#  class { 'nagios':
#    log_file                                    => '/var/log/nagios/nagios.log',
#    cfg_file                                    => [ '/etc/nagios/objects/commands.cfg', '/etc/nagios/objects/contacts.cfg', '/etc/nagios/objects/timeperiods.cfg', '/etc/nagios/objects/templates.cfg', '/etc/nagios/objects/localhost.cfg' ],
#    cfg_dir                                     => [ '/etc/nagios/conf.d', '/etc/nagios/servers' ],
#    object_cache_file                           => '/var/spool/nagios/objects.cache',
#    precached_object_file                       => '/var/spool/nagios/objects.precache',
#    resource_file                               => '/etc/nagios/private/resource.cfg',
#    status_file                                 => '/var/spool/nagios/status.dat',
#    status_update_interval                      => '10',
#    nagios_user                                 => 'nagios',
#  }
#
# === Authors
#
# Aneesh C <aneeshchandrasekharan@gmail.com>
#

class nagios (
  $package_name                                = $::nagios::params::package_name,
  $configfile_nagios                           = $::nagios::params::configfile_nagios,
  $template_nagios                             = 'nagios/configfile.erb',
  $log_file                                    = undef,
  $cfg_file                                    = [],
  $cfg_dir                                     = [],
  $object_cache_file                           = undef,
  $precached_object_file                       = undef,
  $resource_file                               = undef,
  $status_file                                 = undef,
  $status_update_interval                      = undef,
  $nagios_user                                 = undef,
  $nagios_group                                = undef,
  $check_external_commands                     = undef,
  $command_file                                = undef,
  $lock_file                                   = undef,
  $temp_file                                   = undef,
  $temp_path                                   = undef,
  $event_broker_options                        = undef,
  $log_rotation_method                         = undef,
  $log_archive_path                            = undef,
  $use_syslog                                  = undef,
  $log_notifications                           = undef,
  $log_service_retries                         = undef,
  $log_host_retries                            = undef,
  $log_event_handlers                          = undef,
  $log_initial_states                          = undef,
  $log_current_states                          = undef,
  $log_external_commands                       = undef,
  $log_passive_checks                          = undef,
  $service_inter_check_delay_method            = undef,
  $max_service_check_spread                    = undef,
  $service_interleave_factor                   = undef,
  $host_inter_check_delay_method               = undef,
  $max_host_check_spread                       = undef,
  $max_concurrent_checks                       = undef,
  $check_result_reaper_frequency               = undef,
  $max_check_result_reaper_time                = undef,
  $check_result_path                           = undef,
  $max_check_result_file_age                   = undef,
  $cached_host_check_horizon                   = undef,
  $cached_service_check_horizon                = undef,
  $enable_predictive_host_dependency_checks    = undef,
  $enable_predictive_service_dependency_checks = undef,
  $soft_state_dependencies                     = undef,
  $auto_reschedule_checks                      = undef,
  $auto_rescheduling_interval                  = undef,
  $auto_rescheduling_window                    = undef,
  $service_check_timeout                       = undef,
  $host_check_timeout                          = undef,
  $event_handler_timeout                       = undef,
  $notification_timeout                        = undef,
  $ocsp_timeout                                = undef,
  $perfdata_timeout                            = undef,
  $retain_state_information                    = undef,
  $state_retention_file                        = undef,
  $retention_update_interval                   = undef,
  $use_retained_program_state                  = undef,
  $use_retained_scheduling_info                = undef,
  $retained_host_attribute_mask                = undef,
  $retained_service_attribute_mask             = undef,
  $retained_process_host_attribute_mask        = undef,
  $retained_process_service_attribute_mask     = undef,
  $retained_contact_host_attribute_mask        = undef,
  $retained_contact_service_attribute_mask     = undef,
  $interval_length                             = undef,
  $check_for_updates                           = undef,
  $bare_update_check                           = undef,
  $use_aggressive_host_checking                = undef,
  $execute_service_checks                      = undef,
  $accept_passive_service_checks               = undef,
  $execute_host_checks                         = undef,
  $accept_passive_host_checks                  = undef,
  $enable_notifications                        = undef,
  $enable_event_handlers                       = undef,
  $process_performance_data                    = undef,
  $obsess_over_services                        = undef,
  $obsess_over_hosts                           = undef,
  $translate_passive_host_checks               = undef,
  $passive_host_checks_are_soft                = undef,
  $check_for_orphaned_services                 = undef,
  $check_for_orphaned_hosts                    = undef,
  $check_service_freshness                     = undef,
  $service_freshness_check_interval            = undef,
  $service_check_timeout_state                 = undef,
  $check_host_freshness                        = undef,
  $host_freshness_check_interval               = undef,
  $additional_freshness_latency                = undef,
  $enable_flap_detection                       = undef,
  $low_service_flap_threshold                  = undef,
  $high_service_flap_threshold                 = undef,
  $low_host_flap_threshold                     = undef,
  $high_host_flap_threshold                    = undef,
  $date_format                                 = undef,
  $use_regexp_matching                         = undef,
  $use_true_regexp_matching                    = undef,
  $admin_email                                 = undef,
  $admin_pager                                 = undef,
  $daemon_dumps_core                           = undef,
  $use_large_installation_tweaks               = undef,
  $enable_environment_macros                   = undef,
  $debug_level                                 = undef,
  $debug_verbosity                             = undef,
  $debug_file                                  = undef,
  $max_debug_file_size                         = undef,
  $allow_empty_hostgroup_assignment            = undef,
  $command_check_interval                      = undef,
  $external_command_buffer_slots               = undef,
  $sleep_time                                  = undef,
  $p1_file                                     = undef,
  $enable_embedded_perl                        = undef,
  $use_embedded_perl_implicitly                = undef,
) inherits ::nagios::params {
  package { $package_name: ensure => installed }
  file { $configfile_nagios:
    require => package[$package_name],
    backup  => '.backup',
    content => template($template_nagios),
  }
  if $::osfamily == 'RedHat' {
    service { 'nagios':
      require => package[$package_name],
      enable  => true,
    }
  }
}
