#
# Cookbook Name:: monitor
# Recipe:: chef_nodes
#

url = "https://raw.github.com/sensu/sensu-community-plugins/master/plugins/chef/check-chef-nodes.rb"
remote_file "/etc/sensu/plugins/check-chef-nodes.rb" do
  source url
  mode 0755
  only_if "curl -s -o /dev/null -w \"%{http_code}\" #{url} | grep 200"
end

sensu_check "chef_nodes" do
  type 'status'
  command "check-chef-nodes.rb -U #{Chef::Config[:chef_server_url]} -C #{Chef::Config[:node_name]} -K #{Chef::Config[:client_key]}"
  handlers [ 'default' ]
  subscribers [ 'all' ]
end
