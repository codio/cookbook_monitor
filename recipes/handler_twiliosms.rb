#
# Cookbook Name:: monitor
# Recipe:: handler_twiliosms
#
# Adds a Twilio SMS handler.
#

sensu_gem 'twilio-ruby'
sensu_gem 'rest-client'

# Fetch the `mailer` handler script from the sensu/sensu-community-plugins repo.
remote_file '/etc/sensu/handlers/twiliosms.rb' do
  source 'https://raw.github.com/sensu/sensu-community-plugins/master/handlers/notification/twiliosms.rb'
  mode 0755
end

# Create the `mailer` handler.
sensu_handler "twiliosms" do
  type "pipe"
  command "/etc/sensu/handlers/twiliosms.rb"
  severities %w( critical )
end

# Fetch the SMTP username and password from the `sensu/twiliosms` encrypted data bag.
search(:sensu, 'id:twiliosms') do |s|
  bag = Chef::EncryptedDataBagItem.load('sensu', 'twiliosms')

  sensu_snippet 'twiliosms' do
    content sid:    bag['sid'],
            token:  bag['token'],
            number: bag['number']
  end
end
