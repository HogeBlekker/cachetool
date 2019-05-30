# == Class: cachetool
#
# his Puppet module downloads Gordalina Cachetool from GitHub.io and sets proper configuration.
#
# === Parameters
#
# Document parameters here.
#
# phar_location
#   Declare the URL of the cachetool phar
#   Defaults to https://gordalina.github.io/cachetool/downloads/cachetool.phar
#
# target_dir
#   Declare the location where the cachetool phar should be stored
#   Defaults to /usr/local/bin
#
# command_name
#   Declare the name of the cachetool command
#   Defaults to cachetool
#
# user
#   Declare the user that should set permissions
#   Defaults to root
#
# cachetool_adapter
#   Declare the adapter to use
#   Defaults to fastcgi
#   See cachetool documentation: https://github.com/gordalina/cachetool
#
# cachetool_fastcgi
#   Declare how to connect to fastcgi
#   Defaults to 127.0.0.1:9000
#   See cachetool documentation: https://github.com/gordalina/cachetool
#
# cachetool_temp_dir
#   Declare an alternative system temporary directory for cachetool to write to
#   Defaults to undef
#   See cachetool documentation: https://github.com/gordalina/cachetool
#
# === Examples
#
#  include cachetool
#
# === Authors
#
# Frederik Van Leeckwyck <frederik@skylegs.com>
#

class cachetool(
    $phar_location      = $cachetool::params::phar_location,
    $target_dir         = $cachetool::params::target_dir,
    $command_name       = $cachetool::params::command_name,
    $user               = $cachetool::params::user,
    $cachetool_adapter  = $cachetool::params::cachetool_adapter,
    $cachetool_fastcgi  = $cachetool::params::cachetool_fastcgi,
    $cachetool_temp_dir = $cachetool::params::cachetool_temp_dir
) inherits cachetool::params {

    # Download the cachetool package
    include '::archive'
    archive { 'cachetool_phar':
        ensure      => 'present',
        source      => $phar_location,
        path        => "${target_dir}/${command_name}",
    }

    # Set proper permissions if needed
    exec { 'cachetool_set_permissions':
        command => "chmod a+x ${command_name}",
        path    => '/usr/bin:/bin:/usr/sbin:/sbin',
        cwd     => $target_dir,
        user    => $user,
        unless  => "test -x ${target_dir}/${command_name}",
        require => Archive['cachetool_phar']
    }

    # Set configuration settings
    file { 'cachetool_yml':
        path    => '/etc/cachetool.yml',
        ensure  => file,
        content => template('cachetool/cachetool.yml.erb'),
        owner   => 'root',
        group   => 'root',
        mode    => '0644'
    }
}
