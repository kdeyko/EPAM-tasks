passwords = data_bag_item('mysql', "#{node['passwords_databag']}")

execute 'set server id' do
  command "sed -i 's/server-id.*/server-id = 2/' /etc/mysql-default/my.cnf"
end

execute 'set relay log' do
  command "sed -i '/server-id/a \
relay-log = /var/log/mysql-default/mysql-relay-bin.log\
' /etc/mysql-default/my.cnf"
end

include_recipe '::mysql_flush'

ruby_block 'start_replication' do
  block do
    master_node = search(:node, 'hostname:db-master').first

    command = %(
      CHANGE MASTER TO
      MASTER_HOST="#{node['master_dns']}",
      MASTER_USER="repl",
      MASTER_PASSWORD="#{passwords['repl']}",
      MASTER_LOG_FILE="#{master_node.master_file}",
      MASTER_LOG_POS=#{master_node.master_pos};
    )

    result = Mixlib::ShellOut.new("echo '#{command}' | mysql -S /var/run/mysql-default/mysqld.sock -u root -p#{passwords['root']}")
    result.run_command

    result = Mixlib::ShellOut.new("echo 'start slave' | mysql -S /var/run/mysql-default/mysqld.sock -u root -p#{passwords['root']}")
    result.run_command
  end
  notifies :restart, 'mysql_service[default]', :immediately
end

# execute 'setup slave' do
#   command `mysql -S /var/run/mysql-default/mysqld.sock -u root -p#{passwords['root']} -e "CHANGE MASTER TO MASTER_HOST='#{master_dns}', MASTER_USER='repl', MASTER_PASSWORD='#{passwords['repl']}', MASTER_LOG_FILE = '#{master_file}', MASTER_LOG_POS = #{master_pos};"`
# end

# execute 'start slave' do
#   command `mysql -S /var/run/mysql-default/mysqld.sock -u root -p#{passwords['root']} -e "START SLAVE;"`
#   notifies :restart, 'mysql_service[default]'
# end
