### Attach data bags
servers = data_bag_item('mysql', 'servers.json')

### Install NGINX package
package 'nginx'

### Apply new NGINX config
template '/etc/nginx/sites-available/default' do
  source 'nginx.erb'
  mode '0644'
  variables(
    web1: servers['web1'],
    web2: servers['web2'],
    web3: servers['web3']
  )
end

### Enable and start NGINX service
service 'nginx' do
  action [ :enable, :restart ]
end
