#
# Cookbook Name:: monitor
# Recipe:: system
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


remote_file '/etc/sensu/plugins/load-metrics.rb' do
  source 'https://raw.github.com/sensu/sensu-community-plugins/master/plugins/system/load-metrics.rb'
  mode 0755
end
sensu_check 'load_metrics' do
  type 'metric'
  command 'load-metrics.rb'
  handlers [ 'metrics' ]
  subscribers [ 'all' ]
  interval 30
  action :delete
end


sensu_gem 'mail'
remote_file '/etc/sensu/handlers/mailer.rb' do
  source 'https://raw.github.com/sensu/sensu-community-plugins/master/handlers/notification/mailer.rb'
  mode 0755
end
sensu_handler "mailer" do
  type "pipe"
  command "/etc/sensu/handlers/mailer.rb"
  severities ["ok", "warning", "critical", "unknown"]
end
sensu_snippet 'mailer' do
  content mail_to: 'jmoss@codio.com',
          mail_from: 'sensu@codio.com',
          smtp_address: 'smtp.mandrillapp.com',
          smtp_port: 587,
          smtp_username: 'jmoss@codio.com',
          smtp_domain: 'codio.com',
          smtp_password: 'TdnG63t6BDxKmuSar30QBA'
end


# TODO:
# sensu_gem 'flowdock'
# remote_file '/etc/sensu/handlers/flowdock.rb' do
#   source 'https://raw.github.com/sensu/sensu-community-plugins/master/handlers/notification/flowdock.rb'
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