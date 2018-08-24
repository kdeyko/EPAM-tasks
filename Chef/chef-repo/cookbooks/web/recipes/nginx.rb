### Attach data bags
passwords = data_bag_item('mysql', 'passwords.json')
servers = data_bag_item('mysql', 'servers.json')

### Install NGINX package
package 'nginx'

### Apply new NGINX config
cookbook_file '/etc/nginx/sites-available/default' do
  source 'web_nginx_config'
  mode '0644'
end

### Creating files in web-server's root dir
cookbook_file '/var/www/html/index.php' do
  source 'index.php'
  mode '0644'
end

cookbook_file '/var/www/html/add.php' do
  source 'add.php'
  mode '0644'
end

template '/var/www/html/db.php' do
  source 'db.php.erb'
  mode '0644'
  variables(
    client_pass: passwords['client'],
    master_srv: servers['master'],
    slave_srv: servers['slave']
  )
end

### Enable and start NGINX service
service 'nginx' do
  action [ :enable, :restart ]
end
