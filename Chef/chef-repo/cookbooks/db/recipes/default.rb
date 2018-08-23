execute 'update-upgrade' do
  command 'sudo apt update -y && sudo apt upgrade -y'
end

include_recipe '::mysql_basic'
include_recipe '::master' if node['name'] == "#{node['master_name']}"
include_recipe '::slave' if node['name'] == "#{node['slave_name']}"
