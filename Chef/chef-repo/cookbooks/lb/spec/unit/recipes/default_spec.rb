require 'spec_helper'

describe 'lb::default' do
  let(:chef_run) do
    runner = ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '16.04')
    runner.converge(described_recipe)
  end

  it 'updates apt repo' do
    expect(chef_run).to periodic_apt_update('')
  end
end
