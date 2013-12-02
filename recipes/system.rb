#
# Cookbook Name:: monitor
# Recipe:: system
#
# Adds system level checks.
#


#
# Check load and send notifications via mail.
#

remote_file '/etc/sensu/plugins/check-load.rb' do
  source 'https://raw.github.com/sensu/sensu-community-plugins/master/plugins/system/check-load.rb'
  mode 0755
end

sensu_check 'system_load' do
  type 'status'
  command 'check-load.rb'
  handlers [ 'mailer' ]
  subscribers [ 'all' ]
end