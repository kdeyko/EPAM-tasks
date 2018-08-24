require 'spec_helper'

describe 'web::php' do
  let(:chef_run) do
    runner = ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '16.04')
    runner.converge(described_recipe)
  end

  it 'installs php' do
    expect(chef_run).to install_package 'php'
  end

  it 'installs php-mysql' do
    expect(chef_run).to install_package 'php-mysql'
  end
end
