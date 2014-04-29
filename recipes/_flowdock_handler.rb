#
# Cookbook Name:: monitor
# Recipe:: _flowdock_handler
#
# Adds a Flowdock handler.
#

# FIXME: doesn't work!

# sensu_gem 'flowdock'

# remote_file '/etc/sensu/handlers/flowdock.rb' do
#   source 'https://raw.githubusercontent.com/sensu/sensu-community-plugins/master/handlers/notification/flowdock.rb'
#   mode 0755
# end

# sensu_handler "flowdock" do
#   type "pipe"
#   command "/etc/sensu/handlers/flowdock.rb"
#   severities ["ok", "warning", "critical", "unknown"]
# end

# sensu_snippet 'flowdock' do
#   content auth_token: 'b0fc04a6a48a061c9302863742d0688e'
# end