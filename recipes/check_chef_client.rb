#
# Cookbook Name:: monitor
# Recipe:: check_chef_client
#
# Checks that the chef-client process is up and running.
#

remote_file "/etc/sensu/plugins/check-procs.rb" do
  source "https://raw.github.com/sensu/sensu-community-plugins/master/plugins/processes/check-procs.rb"
  mode 0755
end

sensu_check "processes_chef_client" do
  type 'status'
  command "check-procs.rb -p chef-client -W 1"
  handlers [ 'mailer' ]
  subscribers [ 'all' ]
end