class nagios::params {
  if $::osfamily == 'RedHat' {
    $package_name = [ 'nagios', 'nagios-plugins-ping', 'nagios-plugins-disk', 'nagios-plugins-users', 'nagios-plugins-procs', 'nagios-plugins-load', 'nagios-plugins-ssh', 'nagios-plugins-http', 'nagios-plugins-swap', 'nagios-plugins-nrpe' ]
    $package_name_nrpe = [ 'nrpe', 'nagios-plugins-all', 'openssl' ]
    $configfile_nagios = '/etc/nagios/nagios.cfg'
    $configfile_contacts = '/etc/nagios/objects/contacts.cfg'
    $configdir_server = '/etc/nagios/servers'
  }
  elsif $::osfamily == 'Debian' {
    $package_name = [ 'nagios3', 'nagios-nrpe-plugin' ]
    $package_name_nrpe = [ 'nagios-nrpe-server', 'nagios-plugins' ]
    $configfile_nagios = '/etc/nagios3/nagios.cfg'
    $configfile_contacts = '/etc/nagios3/conf.d/contacts_nagios2.cfg'
    $configdir_server = '/etc/nagios3/servers'
  }
}
