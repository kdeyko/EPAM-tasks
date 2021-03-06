require 'spec_helper'

describe 'web::nginx' do
  let(:chef_run) do
    runner = ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '16.04')
    runner.converge(described_recipe)
  end

  it 'converges successfully' do
    expect { chef_run }.to_not raise_error
  end

  it 'installs nginx' do
    expect(chef_run).to install_package 'nginx'
  end

  it 'creates nginx config' do
    expect(chef_run).to create_cookbook_file('/etc/nginx/sites-available/default').with(mode: '0644')
  end

  it 'creates index.php' do
    expect(chef_run).to create_cookbook_file('/var/www/html/index.php').with(mode: '0644')
  end

  it 'creates add.php' do
    expect(chef_run).to create_cookbook_file('/var/www/html/add.php').with(mode: '0644')
  end

  it 'creates db.php' do
    expect(chef_run).to create_template('/var/www/html/db.php').with(mode: '0644')
  end

  it 'enables the nginx service' do
    expect(chef_run).to enable_service 'nginx'
  end

  it 'restarts the nginx service' do
    expect(chef_run).to restart_service 'nginx'
  end
end
