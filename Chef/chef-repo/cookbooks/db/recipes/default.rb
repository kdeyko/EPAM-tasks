### Update repos
apt_update

### Run general mysql setup
include_recipe '::mysql_basic'

### Run final mysql setup for master or slave
include_recipe '::master' if node.name == node['master_name']
include_recipe '::slave' if node.name == node['slave_name']
