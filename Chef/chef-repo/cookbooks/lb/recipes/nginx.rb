package 'nginx' do
  action :install
end

cookbook_file '/etc/nginx/sites-available/default' do
  source 'lb_nginx_config'
  mode '0644'
end

service 'nginx' do
  action [ :enable, :restart ]
end
