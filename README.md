# Nagios Module

## Overview

This module install and configure nagios IT infrastructure monitoring server.

## Usage

Default configuration:

```puppet
include nagios
```

Change configuration file settings:

```puppet
class { 'nagios':
    log_file                                    => '/var/log/nagios/nagios.log',
    cfg_file                                    => [ '/etc/nagios/objects/commands.cfg', '/etc/nagios/objects/contacts.cfg', '/etc/nagios/objects/timeperiods.cfg', '/etc/nagios/objects/templates.cfg', '/etc/nagios/objects/localhost.cfg' ],
    cfg_dir                                     => [ '/etc/nagios/conf.d', '/etc/nagios/servers' ],
    object_cache_file                           => '/var/spool/nagios/objects.cache',
    precached_object_file                       => '/var/spool/nagios/objects.precache',
    resource_file                               => '/etc/nagios/private/resource.cfg',
    status_file                                 => '/var/spool/nagios/status.dat',
    status_update_interval                      => '10',
    nagios_user                                 => 'nagios',
    nagios_group                                => 'nagios',
    check_external_commands                     => '1',
    command_file                                => '/var/spool/nagios/cmd/nagios.cmd',
    lock_file                                   => '/var/run/nagios/nagios.pid',
    temp_file                                   => '/var/spool/nagios/nagios.tmp',
    temp_path                                   => '/tmp',
    event_broker_options                        => '-1',
    log_rotation_method                         => 'd',
    log_archive_path                            => '/var/log/nagios/archives',
    use_syslog                                  => '1',
    log_notifications                           => '1',
    log_service_retries                         => '1',
    log_host_retries                            => '1',
    log_event_handlers                          => '1',
    log_initial_states                          => '0',
    log_current_states                          => '1',
    log_external_commands                       => '1',
    log_passive_checks                          => '1',
    service_inter_check_delay_method            => 's',
    max_service_check_spread                    => '30',
    service_interleave_factor                   => 's',
    host_inter_check_delay_method               => 's',
    max_host_check_spread                       => '30',
    max_concurrent_checks                       => '0',
    check_result_reaper_frequency               => '10',
    max_check_result_reaper_time                => '30',
    check_result_path                           => '/var/spool/nagios/checkresults',
    max_check_result_file_age                   => '3600',
    cached_host_check_horizon                   => '15',
    cached_service_check_horizon                => '15',
    enable_predictive_host_dependency_checks    => '1',
    enable_predictive_service_dependency_checks => '1',
    soft_state_dependencies                     => '0',
    auto_reschedule_checks                      => '0',
    auto_rescheduling_interval                  => '30',
    auto_rescheduling_window                    => '180',
    service_check_timeout                       => '60',
    host_check_timeout                          => '30',
    event_handler_timeout                       => '30',
    notification_timeout                        => '30',
    ocsp_timeout                                => '5',
    perfdata_timeout                            => '5',
    retain_state_information                    => '1',
    state_retention_file                        => '/var/spool/nagios/retention.dat',
    retention_update_interval                   => '60',
    use_retained_program_state                  => '1',
    use_retained_scheduling_info                => '1',
    retained_host_attribute_mask                => '0',
    retained_service_attribute_mask             => '0',
    retained_process_host_attribute_mask        => '0',
    retained_process_service_attribute_mask     => '0',
    retained_contact_host_attribute_mask        => '0',
    retained_contact_service_attribute_mask     => '0',
    interval_length                             => '60',
    check_for_updates                           => '1',
    bare_update_check                           => '0',
    use_aggressive_host_checking                => '0',
    execute_service_checks                      => '1',
    accept_passive_service_checks               => '1',
    execute_host_checks                         => '1',
    accept_passive_host_checks                  => '1',
    enable_notifications                        => '1',
    enable_event_handlers                       => '1',
    process_performance_data                    => '0',
    obsess_over_services                        => '0',
    obsess_over_hosts                           => '0',
    translate_passive_host_checks               => '0',
    passive_host_checks_are_soft                => '0',
    check_for_orphaned_services                 => '1',
    check_for_orphaned_hosts                    => '1',
    check_service_freshness                     => '1',
    service_freshness_check_interval            => '60',
    service_check_timeout_state                 => 'c',
    check_host_freshness                        => '0',
    host_freshness_check_interval               => '60',
    additional_freshness_latency                => '15',
    enable_flap_detection                       => '1',
    low_service_flap_threshold                  => '5.0',
    high_service_flap_threshold                 => '20.0',
    low_host_flap_threshold                     => '5.0',
    high_host_flap_threshold                    => '20.0',
    date_format                                 => 'us',
    use_regexp_matching                         => '0',
    use_true_regexp_matching                    => '0',
    admin_email                                 => 'nagios@localhost',
    admin_pager                                 => 'pagenagios@localhost',
    daemon_dumps_core                           => '0',
    use_large_installation_tweaks               => '0',
    enable_environment_macros                   => '0',
    debug_level                                 => '0',
    debug_verbosity                             => '1',
    debug_file                                  => '/var/spool/nagios/nagios.debug',
    max_debug_file_size                         => '1000000',
    allow_empty_hostgroup_assignment            => '0',
}
```

Define contacts:

```puppet
class { 'nagios::contacts':
    contact_name                  => 'nagiosadmin',
    use                           => 'generic-contact',
    alias                         => 'Nagios Admin',
    email                         => 'admin@example.com',
    contactgroup_name             => 'admins',
    contactgroup_alias            => 'Nagios Administrators',
    members                       => 'nagiosadmin',
}
```

Add nagios remote host:

```puppet
nagios::server { 'client.cfg':
    configfile_server       => 'client.cfg',
    define_host             => {
        'client'        => [
            'use                    linux-server',
            'host_name              client',
            'alias                  client',
            'address                127.0.0.1',
            'max_check_attempts     5',
            'check_period           24x7',
            'notification_interval  30',
            'notification_period    24x7',
        ],
    },
    define_service      => {
        'SSH'   => [
            'use                    generic-service',
            'host_name              client',
            'service_description    SSH',
            'check_command          check_ssh',
            'notifications_enabled  0',
        ],
        'Current Load'  => [
            'use                    generic-service',
            'host_name              client',
            'service_description    Current Load',
            'check_command          check_nrpe!check_load',
        ],
    },
}
```

Host configuration file settings:

```puppet
class { 'nagios::nrpe':
    log_facility                    => 'daemon',
    pid_file                        => '/var/run/nrpe/nrpe.pid',
    server_port                     => '5666',
    nrpe_user                       => 'nrpe',
    nrpe_group                      => 'nrpe',
    allowed_hosts                   => '127.0.0.1',
    dont_blame_nrpe                 => '0',
    allow_bash_command_substitution => '0',
    debug                           => '0',
    command_timeout                 => '60',
    connection_timeout              => '300',
    command                         => [
      '[check_users]=/usr/lib64/nagios/plugins/check_users -w 5 -c 10',
      '[check_load]=/usr/lib64/nagios/plugins/check_load -w 15,10,5 -c 30,25,20',
      '[check_hda1]=/usr/lib64/nagios/plugins/check_disk -w 20% -c 10% -p /dev/hda1',
      '[check_zombie_procs]=/usr/lib64/nagios/plugins/check_procs -w 5 -c 10 -s Z',
      '[check_total_procs]=/usr/lib64/nagios/plugins/check_procs -w 150 -c 200',
      '[check_swap]=/usr/lib64/nagios/plugins/check_swap -w 20 -c 10'
    ],
    include_dir                     => [ '/etc/nrpe.d/' ],
}
```
