# Parameters for rally
#
class rally::params {

  $rally_conf = '/etc/rally/rally.conf'
  $db_sync_command = 'rally-manage db_sync'

  case $::osfamily {
    'RedHat': {
      $package_name         = 'openstack-rally'
      $sqlite_package_name  = undef
      $pymysql_package_name = undef
    }
    'Debian': {
      $package_name         = 'rally'
      $sqlite_package_name  = 'python-pysqlite2'
      $pymysql_package_name = 'python-pymysql'
    }
    default: {
      fail("Unsupported osfamily: ${::osfamily} operatingsystem")
    }

  }
}
