passwords = data_bag_item('mysql', "#{node['passwords_databag']}")

mysql_service 'default' do
  version '5.7'
  bind_address '0.0.0.0'
  initial_root_password passwords['root']
  action [:create, :start]
end

mysql_config 'default' do
  instance 'default'
  source 'my.cnf.erb'
  action :create
end

execute 'create DB' do
  command "echo \"CREATE DATABASE words;\" | mysql -S /var/run/mysql-default/mysqld.sock -u root -p#{passwords['root']}"
  sensitive true
end

execute 'create client user and grant permissions' do
  command "echo \"GRANT INSERT, SELECT ON *.* TO 'client'@'%' IDENTIFIED BY '#{passwords['client']}';\" | mysql -S /var/run/mysql-default/mysqld.sock -u root -p#{passwords['root']}"
  sensitive true
  notifies :restart, 'mysql_service[default]', :immediately
end
