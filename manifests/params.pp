class nagios::params {
  if $::osfamily == 'RedHat' {
    $package_name = [ 'nagios', 'nagios-plugins-ping', 'nagios-plugins-disk', 'nagios-plugins-users', 'nagios-plugins-procs', 'nagios-plugins-load', 'nagios-plugins-ssh', 'nagios-plugins-http', 'nagios-plugins-swap', 'nagios-plugins-nrpe' ]
    $package_name_nrpe = [ 'nrpe', 'nagios-plugins-all', 'openssl' ]
    $configfile_nagios = '/etc/nagios/nagios.cfg'
    $configfile_contacts = '/etc/nagios/objects/contacts.cfg'
    $configdir_server = '/etc/nagios/servers'
    $configfile_commands = '/etc/nagios/objects/commands.cfg'
    case $::operatingsystemrelease {
      /^6.*/: {
        $template_nagios = 'nagios/nagios.cfg.c.6.erb'
        $template_contacts = 'nagios/contacts.cfg.c.6.erb'
        $template_commands = 'nagios/commands.cfg.c.6.erb'
        $template_nrpe = 'nagios/nrpe.cfg.c.6.erb'
      }
      /^7.*/: {
        $template_nagios = 'nagios/nagios.cfg.c.7.erb'
        $template_contacts = 'nagios/contacts.cfg.c.7.erb'
        $template_commands = 'nagios/commands.cfg.c.7.erb'
        $template_nrpe = 'nagios/nrpe.cfg.c.7.erb'
      }
      default: {
        $template_nagios = 'nagios/nagios.cfg.c.6.erb'
        $template_contacts = 'nagios/contacts.cfg.c.6.erb'
        $template_commands = 'nagios/commands.cfg.c.6.erb'
        $template_nrpe = 'nagios/nrpe.cfg.c.6.erb'
      }
    }
  }
  if $::osfamily == 'Debian' {
    $package_name = [ 'nagios3', 'nagios-nrpe-plugin' ]
    $package_name_nrpe = [ 'nagios-nrpe-server', 'nagios-plugins' ]
    $configfile_nagios = '/etc/nagios3/nagios.cfg'
    $configfile_contacts = '/etc/nagios3/conf.d/contacts_nagios2.cfg'
    $configdir_server = '/etc/nagios3/servers'
    $configfile_commands = '/etc/nagios3/commands.cfg'
    case $::operatingsystemrelease {
      /^12.*/: {
        $template_nagios = 'nagios/nagios.cfg.u.12.erb'
        $template_contacts = 'nagios/contacts_nagios2.cfg.u.12.erb'
        $template_commands = 'nagios/commands.cfg.u.12.erb'
        $template_nrpe = 'nagios/nrpe.cfg.u.12.erb'
      }
      /^14.*/: {
        $template_nagios = 'nagios/nagios.cfg.u.14.erb'
        $template_contacts = 'nagios/contacts_nagios2.cfg.u.14.erb'
        $template_commands = 'nagios/commands.cfg.u.14.erb'
        $template_nrpe = 'nagios/nrpe.cfg.u.14.erb'
      }
      default: {
        $template_nagios = 'nagios/nagios.cfg.u.12.erb'
        $template_contacts = 'nagios/contacts_nagios2.cfg.u.12.erb'
        $template_commands = 'nagios/commands.cfg.u.12.erb'
        $template_nrpe = 'nagios/nrpe.cfg.u.12.erb'
      }
    }
  }
}
