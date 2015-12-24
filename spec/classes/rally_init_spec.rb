require 'spec_helper'

describe 'rally' do

  default_params = {
    'package_ensure'                           => 'present',
    'verbose'                                  => false,
    'debug'                                    => false,
    'rally_debug'                              => false,
    'openstack_client_http_timeout'            => 180.0,
    'cinder_volume_create_prepoll_delay'       => 2.0,
    'cinder_volume_create_timeout'             => 600.0,
    'cinder_volume_create_poll_interval'       => 2.0,
    'cinder_volume_delete_timeout'             => 600.0,
    'cinder_volume_delete_poll_interval'       => 2.0,
    'ec2_server_boot_prepoll_delay'            => 1.0,
    'ec2_server_boot_timeout'                  => 300.0,
    'ec2_server_boot_poll_interval'            => 1.0,
    'glance_image_create_prepoll_delay'        => 2.0,
    'glance_image_create_timeout'              => 120.0,
    'glance_image_create_poll_interval'        => 1.0,
    'glance_image_delete_timeout'              => 120.0,
    'glance_image_delete_poll_interval'        => 1.0,
    'heat_stack_create_prepoll_delay'          => 2.0,
    'heat_stack_create_timeout'                => 3600.0,
    'heat_stack_create_poll_interval'          => 1.0,
    'heat_stack_delete_timeout'                => 3600.0,
    'heat_stack_delete_poll_interval'          => 1.0,
    'heat_stack_check_timeout'                 => 3600.0,
    'heat_stack_check_poll_interval'           => 1.0,
    'heat_stack_update_prepoll_delay'          => 2.0,
    'heat_stack_update_timeout'                => 3600.0,
    'heat_stack_update_poll_interval'          => 1.0,
    'heat_stack_suspend_timeout'               => 3600.0,
    'heat_stack_suspend_poll_interval'         => 1.0,
    'heat_stack_resume_timeout'                => 3600.0,
    'heat_stack_resume_poll_interval'          => 1.0,
    'heat_stack_snapshot_timeout'              => 3600.0,
    'heat_stack_snapshot_poll_interval'        => 1.0,
    'heat_stack_restore_timeout'               => 3600.0,
    'heat_stack_restore_poll_interval'         => 1.0,
    'heat_stack_scale_timeout'                 => 3600.0,
    'heat_stack_scale_poll_interval'           => 1.0,
    'ironic_node_create_poll_interval'         => 1.0,
    'manila_share_create_prepoll_delay'        => 2.0,
    'manila_share_create_timeout'              => 300.0,
    'manila_share_create_poll_interval'        => 3.0,
    'manila_share_delete_timeout'              => 180.0,
    'manila_share_delete_poll_interval'        => 2.0,
    'murano_deploy_environment_timeout'        => 1200,
    'murano_deploy_environment_check_interval' => 5,
    'nova_server_start_prepoll_delay'          => 0.0,
    'nova_server_start_timeout'                => 300.0,
    'nova_server_start_poll_interval'          => 1.0,
    'nova_server_stop_prepoll_delay'           => 0.0,
    'nova_server_stop_timeout'                 => 300.0,
    'nova_server_stop_poll_interval'           => 2.0,
    'nova_server_boot_prepoll_delay'           => 1.0,
    'nova_server_boot_timeout'                 => 300.0,
    'nova_server_boot_poll_interval'           => 1.0,
    'nova_server_delete_prepoll_delay'         => 2.0,
    'nova_server_delete_timeout'               => 300.0,
    'nova_server_delete_poll_interval'         => 2.0,
    'nova_server_reboot_prepoll_delay'         => 2.0,
    'nova_server_reboot_timeout'               => 300.0,
    'nova_server_reboot_poll_interval'         => 2.0,
    'nova_server_rebuild_prepoll_delay'        => 1.0,
    'nova_server_rebuild_timeout'              => 300.0,
    'nova_server_rebuild_poll_interval'        => 1.0,
    'nova_server_rescue_prepoll_delay'         => 2.0,
    'nova_server_rescue_timeout'               => 300.0,
    'nova_server_rescue_poll_interval'         => 2.0,
    'nova_server_unrescue_prepoll_delay'       => 2.0,
    'nova_server_unrescue_timeout'             => 300.0,
    'nova_server_unrescue_poll_interval'       => 2.0,
    'nova_server_suspend_prepoll_delay'        => 2.0,
    'nova_server_suspend_timeout'              => 300.0,
    'nova_server_suspend_poll_interval'        => 2.0,
    'nova_server_resume_prepoll_delay'         => 2.0,
    'nova_server_resume_timeout'               => 300.0,
    'nova_server_resume_poll_interval'         => 2.0,
    'nova_server_pause_prepoll_delay'          => 2.0,
    'nova_server_pause_timeout'                => 300.0,
    'nova_server_pause_poll_interval'          => 2.0,
    'nova_server_unpause_prepoll_delay'        => 2.0,
    'nova_server_unpause_timeout'              => 300.0,
    'nova_server_unpause_poll_interval'        => 2.0,
    'nova_server_shelve_prepoll_delay'         => 2.0,
    'nova_server_shelve_timeout'               => 300.0,
    'nova_server_shelve_poll_interval'         => 2.0,
    'nova_server_unshelve_prepoll_delay'       => 2.0,
    'nova_server_unshelve_timeout'             => 300.0,
    'nova_server_unshelve_poll_interval'       => 2.0,
    'nova_server_image_create_prepoll_delay'   => 0.0,
    'nova_server_image_create_timeout'         => 300.0,
    'nova_server_image_create_poll_interval'   => 2.0,
    'nova_server_image_delete_prepoll_delay'   => 0.0,
    'nova_server_image_delete_timeout'         => 300.0,
    'nova_server_image_delete_poll_interval'   => 2.0,
    'nova_server_resize_prepoll_delay'         => 2.0,
    'nova_server_resize_timeout'               => 400.0,
    'nova_server_resize_poll_interval'         => 5.0,
    'nova_server_resize_confirm_prepoll_delay' => 0.0,
    'nova_server_resize_confirm_timeout'       => 200.0,
    'nova_server_resize_confirm_poll_interval' => 2.0,
    'nova_server_resize_revert_prepoll_delay'  => 0.0,
    'nova_server_resize_revert_timeout'        => 200.0,
    'nova_server_resize_revert_poll_interval'  => 2.0,
    'nova_server_live_migrate_prepoll_delay'   => 1.0,
    'nova_server_live_migrate_timeout'         => 400.0,
    'nova_server_live_migrate_poll_interval'   => 2.0,
    'nova_server_migrate_prepoll_delay'        => 1.0,
    'nova_server_migrate_timeout'              => 400.0,
    'nova_server_migrate_poll_interval'        => 2.0,
    'nova_detach_volume_timeout'               => 200.0,
    'nova_detach_volume_poll_interval'         => 2.0,
    'sahara_cluster_create_timeout'            => 1800,
    'sahara_cluster_delete_timeout'            => 900,
    'sahara_cluster_check_interval'            => 5,
    'sahara_job_execution_timeout'             => 600,
    'sahara_job_check_interval'                => 5,
    'sahara_workers_per_proxy'                 => 20,
    'vm_ping_poll_interval'                    => 1.0,
    'vm_ping_timeout'                          => 120.0,
    'resource_deletion_timeout'                => 600,
    'database_connection'                      => 'sqlite:////var/lib/rally/rally.sqlite',
    'database_idle_timeout'                    => 3600,
    'database_min_pool_size'                   => 1,
    'database_max_pool_size'                   => 10,
    'database_max_retries'                     => 10,
    'database_retry_interval'                  => 10,
    'database_max_overflow'                    => 20,
    'sync_db'                                  => true,
  }

  override_params = {
    'package_ensure'                           => 'latest',
    'rally_debug'                              => true,
    'nova_server_boot_timeout'                 => 200.0,
    'vm_ping_timeout'                          => 240.0,
    'database_connection'                      => 'mysql://rally:rally@localhost/rally',
  }

  shared_examples_for 'core rally examples' do |param_hash|
    it { is_expected.to contain_class('rally::params') }
    it { is_expected.to contain_class('rally::logging') }
    it { is_expected.to contain_class('rally::db') }

    it { is_expected.to contain_package('rally').with(
      'ensure' => param_hash['package_ensure'],
      'tag'    => ['openstack', 'rally-package'],
    ) }

    it 'should synchronize the db if $sync_db is true' do
      if param_hash['sync_db']
        is_expected.to contain_exec('rally-manage db_sync').with(
          :command     => 'rally-manage db_sync',
          :user        => 'rally',
          :refreshonly => true,
          :subscribe   => ['Package[rally]', 'Rally_config[database/connection]']
        )
      end
    end

    it 'should contain correct default config' do
      [
       'verbose',
       'debug',
       'rally_debug'
      ].each do |config|
        is_expected.to contain_keystone_config("DEFAULT/#{config}").with_value(param_hash[config])
      end
    end

    it 'should contain correct benchmark config' do
      [
       'glance_image_create_timeout',
       'heat_stack_check_timeout',
       'nova_server_boot_timeout',
       'nova_server_resize_timeout'
      ].each do |config|
        is_expected.to contain_keystone_config("benchmark/#{config}").with_value(param_hash[config])
      end
    end
  end

  [default_params, override_params].each do |param_hash|
    describe "when #{param_hash == default_params ? "using default" : "specifying"} class parameters for service" do

      let :params do
        param_hash
      end

      it_configures 'core rally examples', param_hash

      it 'install the proper package' do
        is_expected.to contain_package('rally').with(:ensure => param_hash['package_ensure'])
      end

    end
  end

end
