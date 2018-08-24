describe service 'mysql-default' do
  it { should be_running }
end

describe port(3306) do
  it { should be_listening }
end

describe command('mysql -S /var/run/mysql-default/mysqld.sock -D words -u root -proot -e "SHOW TABLES;"') do
  its('stdout') { should match 'word' }
end

describe command('mysql -S /var/run/mysql-default/mysqld.sock -u root -proot -e "SELECT User FROM mysql.user;"') do
  its('stdout') { should match /client|repl/ }
end
