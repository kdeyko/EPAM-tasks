execute 'update-upgrade' do
  command 'sudo apt update -y && sudo apt upgrade -y'
  action :run
end
