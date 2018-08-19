#
# Cookbook:: web
# Spec:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'web::default' do
  let(:chef_run) do
    runner = ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '16.04')
    runner.converge(described_recipe)
  end

  it 'executes cmd' do
    expect(chef_run).to run_execute('sudo apt update -y && sudo apt upgrade -y')
  end
end
