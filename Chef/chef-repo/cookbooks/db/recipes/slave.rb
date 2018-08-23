passwords = data_bag_item('mysql', "#{node['passwords_databag']}")

include_recipe '::mysql_flush'

execute 'set server id' do
  command "sed -i 's/server-id.*/server-id = 2/' /etc/mysql-default/conf.d/default.cnf"
end

execute 'set relay log' do
  command "sed -i '/server-id/a \
relay-log = /var/log/mysql-default/mysql-relay-bin.log\
' /etc/mysql-default/conf.d/default.cnf"
  notifies :restart, 'mysql_service[default]', :immediately
end

ruby_block 'start_replication' do
  block do
    require 'mixlib/shellout'
    master_node = search(:node, "name:#{node['master_name']}").first
    file = master_node['master_file'].strip
    pos = master_node['master_pos'].strip

    command = %(
      CHANGE MASTER TO
      MASTER_HOST="#{node['master_dns']}",
      MASTER_USER="repl",
      MASTER_PASSWORD="#{passwords['repl']}",
      MASTER_LOG_FILE="#{file}",
      MASTER_LOG_POS=#{pos};
    )
    puts '------ command -------'
    puts command

    slave_setup = Mixlib::ShellOut.new("echo '#{command}' | mysql -S /var/run/mysql-default/mysqld.sock -u root -p#{passwords['root']}")
    slave_setup.run_command

    slave_start = Mixlib::ShellOut.new("echo 'start slave' | mysql -S /var/run/mysql-default/mysqld.sock -u root -p#{passwords['root']}")
    slave_start.run_command
  end
end
