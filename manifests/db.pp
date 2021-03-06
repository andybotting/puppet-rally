# == Class: rally::db
#
#  Configure the rally database
#
# === Parameters
#
# [*database_connection*]
#   Url used to connect to database.
#   (optional) Defaults to 'sqlite:////var/lib/rally/rally.sqlite'.
#
# [*database_idle_timeout*]
#   Timeout when db connections should be reaped.
#   (optional) Defaults to 3600.
#
# [*database_max_retries*]
#   Maximum number of database connection retries during startup.
#   Setting -1 implies an infinite retry count.
#   (optional) Defaults to 10.
#
# [*database_retry_interval*]
#   Interval between retries of opening a database connection.
#   (optional) Defaults to 10.
#
# [*database_min_pool_size*]
#   Minimum number of SQL connections to keep open in a pool.
#   (optional) Defaults to 1.
#
# [*database_max_pool_size*]
#   Maximum number of SQL connections to keep open in a pool.
#   (optional) Defaults to 10.
#
# [*database_max_overflow*]
#   If set, use this value for max_overflow with sqlalchemy.
#   (optional) Defaults to 20.
#
class rally::db (
  $database_connection     = "sqlite:////var/lib/rally/rally.sqlite",
  $database_idle_timeout   = 3600,
  $database_min_pool_size  = 1,
  $database_max_pool_size  = 10,
  $database_max_retries    = 10,
  $database_retry_interval = 10,
  $database_max_overflow   = 20,
) {

  $database_connection_real = pick($::rally::database_connection, $database_connection)
  $database_idle_timeout_real = pick($::rally::database_idle_timeout, $database_idle_timeout)
  $database_min_pool_size_real = pick($::rally::database_min_pool_size, $database_min_pool_size)
  $database_max_pool_size_real = pick($::rally::database_max_pool_size, $database_max_pool_size)
  $database_max_retries_real = pick($::rally::database_max_retries, $database_max_retries)
  $database_retry_interval_real = pick($::rally::database_retry_interval, $database_retry_interval)
  $database_max_overflow_real = pick($::rally::database_max_overflow, $database_max_overflow)

  validate_re($database_connection_real,
    '(sqlite|mysql|postgresql):\/\/(\S+:\S+@\S+\/\S+)?')

  case $database_connection_real {
    /^mysql(\+pymysql)?:\/\//: {
      require 'mysql::bindings'
      require 'mysql::bindings::python'
      if $database_connection_real =~ /^mysql\+pymysql/ {
        $backend_package = $::rally::params::pymysql_package_name
      } else {
        $backend_package = false
      }
    }
    /^postgresql:\/\//: {
      $backend_package = false
      require 'postgresql::lib::python'
    }
    /^sqlite:\/\//: {
      $backend_package = $::rally::params::sqlite_package_name
    }
    default: {
      fail('Unsupported backend configured')
    }
  }

  if $backend_package and !defined(Package[$backend_package]) {
    package { 'rally-backend-package':
      ensure => present,
      name   => $backend_package,
      tag    => 'openstack',
    }
  }

  rally_config {
    'database/connection':     value => $database_connection_real, secret => true;
    'database/idle_timeout':   value => $database_idle_timeout_real;
    'database/min_pool_size':  value => $database_min_pool_size_real;
    'database/max_retries':    value => $database_max_retries_real;
    'database/retry_interval': value => $database_retry_interval_real;
    'database/max_pool_size':  value => $database_max_pool_size_real;
    'database/max_overflow':   value => $database_max_overflow_real;
  }
}
