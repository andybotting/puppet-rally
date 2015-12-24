require 'spec_helper_acceptance'

describe 'basic rally' do

  context 'default parameters' do

    it 'should work with no errors' do
      pp= <<-EOS
      include ::openstack_integration
      include ::openstack_integration::repos
      include ::openstack_integration::mysql

      # Rally resources
      class { '::rally::db::mysql':
        password => 'a_big_secret',
      }
      class { '::rally':
        database_connection => 'mysql+pymysql://rally:a_big_secret@127.0.0.1/rally?charset=utf8',
      }
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes => true)
    end

  end
end
