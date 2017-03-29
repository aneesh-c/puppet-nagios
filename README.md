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
    cfg_dir                 => [ '/etc/nagios/servers' ],
    check_external_commands => '1',
    email                   => 'admin@example.com',
}
```

Define commands:

```puppet
class { 'nagios::commands':
    define_command  => {
        'check_nrpe' => [
            'command_name check_nrpe',
            'command_line /usr/lib64/nagios/plugins/check_nrpe -H $HOSTADDRESS$ -c $ARG1$',
        ],
    },
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
    allowed_hosts     => '127.0.0.1',
    dont_blame_nrpe   => '1',
    command           => [
'[check_users]=/usr/lib64/nagios/plugins/check_users -w 5 -c 10',
'[check_load]=/usr/lib64/nagios/plugins/check_load -w 15,10,5 -c 30,25,20',
'[check_hda1]=/usr/lib64/nagios/plugins/check_disk -w 20% -c 10% -p /dev/hda1',
'[check_zombie_procs]=/usr/lib64/nagios/plugins/check_procs -w 5 -c 10 -s Z',
'[check_total_procs]=/usr/lib64/nagios/plugins/check_procs -w 150 -c 200',
'[check_swap]=/usr/lib64/nagios/plugins/check_swap -w 20 -c 10',
    ],
}
```
