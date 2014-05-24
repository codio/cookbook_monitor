#
# Cookbook Name:: monitor
# Recipe:: system
#
# Adds system level checks.
#

include_recipe "monitor::default"

%w( load cpu disk ram ).each do |type|

  url = "https://raw.githubusercontent.com/sensu/sensu-community-plugins/master/plugins/system/check-#{type}.rb"
  remote_file "/etc/sensu/plugins/check-#{type}.rb" do
    source url
    mode 0755
    only_if "curl -s -o /dev/null -w \"%{http_code}\" #{url} | grep 200"
  end

  sensu_check "system_#{type}" do
    type 'status'
    command "check-#{type}.rb#{node[:monitor][:checks]["system_#{type}"][:command_options]}"
    handlers [ 'default' ]
    subscribers [ 'all' ]
    additional occurrences: node[:monitor][:checks]["system_#{type}"][:occurrences]
    handle false unless node[:monitor][:checks]["system_#{type}"][:enabled]
  end

end

# Check that sudoers is still owned by root
url = "https://raw.githubusercontent.com/sensu/sensu-community-plugins/master/plugins/processes/check-cmd.rb"
remote_file "/etc/sensu/plugins/check-cmd.rb" do
  source url
  mode 0755
  only_if "curl -s -o /dev/null -w \"%{http_code}\" #{url} | grep 200"
end

sensu_check "sudoers-permission" do
  type 'status'
  command "check-cmd.rb -c 'find /usr/lib/sudo/sudoers.so -user 0' -o '/usr/lib/sudo/sudoers.so'"
  handlers [ 'default' ]
  subscribers [ 'node_fileserver', 'node_fileserver_old' ]
end

sensu_check "claptrap" do
  type 'status'
  command "check-cmd.rb -c 'pgrep claptrap'"
  handlers [ 'default' ]
  subscribers [ 'node_fileserver', 'node_fileserver_old' ]
end

sensu_check "pier" do
  type 'status'
  command "check-cmd.rb -c 'pgrep pier'"
  handlers [ 'default' ]
  subscribers [ 'node_fileserver', 'node_fileserver_old' ]
end

sensu_check "docker" do
  type 'status'
  command "check-cmd.rb -c 'pgrep docker'"
  handlers [ 'default' ]
  subscribers [ 'node_fileserver', 'node_fileserver_old' ]
end
