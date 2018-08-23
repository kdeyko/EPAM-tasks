passwords = data_bag_item('mysql', "#{node['passwords_databag']}")

execute 'apply rights' do
  command "echo \"FLUSH PRIVILEGES;\" | mysql -S /var/run/mysql-default/mysqld.sock -u root -p#{passwords['root']}"
  sensitive true
end
