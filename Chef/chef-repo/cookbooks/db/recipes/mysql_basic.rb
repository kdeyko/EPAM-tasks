### Attach data bag (must be in every recipe)
passwords = data_bag_item('mysql', node['passwords_databag'])

### Install mysql-server
mysql_service 'default' do
  version '5.7'
  bind_address '0.0.0.0'
  initial_root_password passwords['root']
  action [:create, :start]
end

### Add general mysqld config
mysql_config 'default' do
  instance 'default'
  source 'my.cnf.erb'
  action :create
end

### Create Database 'words'
execute 'create DB' do
  command "echo 'CREATE DATABASE words;' | mysql -S /var/run/mysql-default/mysqld.sock -u root -p#{passwords['root']}"
  sensitive true
end

### Create Table 'main'
execute 'create table' do
  command "echo 'CREATE TABLE main (id MEDIUMINT NOT NULL AUTO_INCREMENT, word CHAR(50), PRIMARY KEY (id));' | mysql -S /var/run/mysql-default/mysqld.sock -D words -u root -p#{passwords['root']}"
  sensitive true
end

### Insert some values to DB
execute 'insert values' do
  command "mysql -S /var/run/mysql-default/mysqld.sock -D words -u root -p#{passwords['root']} <<QUERY
INSERT INTO main (word) VALUES ('dog'),('cat'),('bird');
QUERY"
  sensitive true
end

### Create user 'client' for application, grant permissions
execute 'create client user and grant permissions' do
  command "echo \"GRANT INSERT, SELECT ON *.* TO 'client'@'%' IDENTIFIED BY '#{passwords['client']}';\" | mysql -S /var/run/mysql-default/mysqld.sock -u root -p#{passwords['root']}"
  sensitive true
  notifies :restart, 'mysql_service[default]', :immediately
end
