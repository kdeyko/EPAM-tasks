### Attach data bag (must be in every recipe)
passwords = data_bag_item('mysql', node['passwords_databag'])

### Create user 'repl' for replication purposes, grant permissions
execute 'create replication user and grant permissions' do
  command "echo \"GRANT REPLICATION SLAVE, REPLICATION CLIENT ON *.* TO 'repl'@'%' IDENTIFIED BY '#{passwords['repl']}';\" | mysql -S /var/run/mysql-default/mysqld.sock -u root -p#{passwords['root']}"
  sensitive true
end

### Run recipe which flushes privileges for new MySQL users
include_recipe '::mysql_flush'

### Get master replication values and put them in attributes
ruby_block 'get master values' do
  block do
    require 'mixlib/shellout'
    file = Mixlib::ShellOut.new("echo 'SHOW MASTER STATUS;' | mysql -S /var/run/mysql-default/mysqld.sock -u root -p#{passwords['root']} | awk '/words/ {print $1}'")
    file.run_command
    pos = Mixlib::ShellOut.new("echo 'SHOW MASTER STATUS;' | mysql -S /var/run/mysql-default/mysqld.sock -u root -p#{passwords['root']} | awk '/words/ {print $2}'")
    pos.run_command
    node.default['master_file'] = file.stdout
    node.default['master_pos'] = pos.stdout
  end
end
