#
# Class to execute rally-manage db_sync
#
# == Parameters
#
class rally::db::sync {
  exec { 'rally-db-sync':
    command     => "${::rally::params::db_sync_command}",
    path        => '/usr/bin',
    user        => 'rally',
    refreshonly => true,
    subscribe   => [Package['rally'], Rally_config['database/connection']],
  }

  Exec['rally-manage db_sync'] ~> Service<| title == 'rally' |>
}
