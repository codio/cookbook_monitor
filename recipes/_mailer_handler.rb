#
# Cookbook Name:: monitor
# Recipe:: _mailer_handler
#
# Adds a mailer handler.
#

sensu_gem 'mail'

# Fetch the `mailer` handler script from the sensu/sensu-community-plugins repo.
url = 'https://raw.github.com/sensu/sensu-community-plugins/master/handlers/notification/mailer.rb'
remote_file '/etc/sensu/handlers/mailer.rb' do
  source url
  mode 0755
  only_if "curl -s -o /dev/null -w \"%{http_code}\" #{url} | grep 200"
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
            smtp_username:  bag['smtp_username'],
            smtp_password:  bag['smtp_password']
  end
end

# Create the handler.
sensu_handler "mailer" do
  type "pipe"
  command "/etc/sensu/handlers/mailer.rb"
  severities %w( ok warning critical unknown )
end
