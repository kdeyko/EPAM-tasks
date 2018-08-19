describe package 'php' do
  it { should be_installed }
end

describe package 'php-mysql' do
  it { should be_installed }
end

describe package 'nginx' do
  it { should be_installed }
end

describe service 'nginx' do
  it { should be_enabled }
  it { should be_running }
end

describe port(8080) do
  it { should be_listening }
end

describe command('curl http://localhost:8080') do
  its('stdout') { should match 'Hello there!' }
end

describe file('/etc/nginx/sites-available/default') do
  it { should exist }
  its('mode') { should cmp '0644' }
end

describe file('/var/www/html/index.php') do
  it { should exist }
  its('mode') { should cmp '0644' }
end

describe file('/var/www/html/db.php') do
  it { should exist }
  its('mode') { should cmp '0644' }
end

describe file('/var/www/html/add.php') do
  it { should exist }
  its('mode') { should cmp '0644' }
end
