### Attach data bag (must be in every recipe)
passwords = data_bag_item('mysql', node['passwords_databag'])

### Flushing privileges for new MySQL users
execute 'apply rights' do
  command "echo \"FLUSH PRIVILEGES;\" | mysql -S /var/run/mysql-default/mysqld.sock -u root -p#{passwords['root']}"
  sensitive true
end
