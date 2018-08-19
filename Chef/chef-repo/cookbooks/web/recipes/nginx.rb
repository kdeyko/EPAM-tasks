#
# Cookbook:: web
# Recipe:: nginx
#
# Copyright:: 2018, The Authors, All Rights Reserved.

package 'nginx' do
  action :install
end

cookbook_file '/etc/nginx/sites-available/default' do
  source 'web_nginx_config'
  mode '0644'
end

cookbook_file '/var/www/html/index.php' do
  source 'index.php'
  mode '0644'
end

cookbook_file '/var/www/html/db.php' do
  source 'db.php'
  mode '0644'
end

cookbook_file '/var/www/html/add.php' do
  source 'add.php'
  mode '0644'
end

service 'nginx' do
  action [ :enable, :restart ]
end
