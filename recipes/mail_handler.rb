#
# Cookbook Name:: monitor
# Recipe:: mail_handler
#
# Adds a mailer handler.
#

sensu_gem 'mail'

# Fetch the `mailer` handler script from the sensu/sensu-community-plugins repo.
remote_file '/etc/sensu/handlers/mailer.rb' do
  source 'https://raw.githubusercontent.com/sensu/sensu-community-plugins/master/handlers/notification/mailer.rb'
  mode 0755
end

# Create the `mailer` handler.
sensu_handler "mailer" do
  type "pipe"
  command "/etc/sensu/handlers/mailer.rb"
  severities ["ok", "warning", "critical", "unknown"]
end

# Fetch the SMTP username and password from the `sensu/mailer` encrypted data bag.
search(:sensu, 'id:mailer') do |s|
  bag = Chef::EncryptedDataBagItem.load('sensu', 'mailer')

  sensu_snippet 'mailer' do
    content mail_to:        node[:monitor][:mailer][:recipients].join(','),
            mail_from:      node[:monitor][:mailer][:from],
            smtp_address:   node[:monitor][:mailer][:smtp_address],
            smtp_port:      node[:monitor][:mailer][:smtp_port],
            smtp_domain:    node[:monitor][:mailer][:smtp_domain],
            smtp_username:  bag['username'],
            smtp_password:  bag['password']
  end
end

