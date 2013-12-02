#
# Cookbook Name:: monitor
# Recipe:: check_system
#
# Checks load, CPU, Disk and RAM, and sends notifications via mail.
#

%w( load cpu disk ram ).each do |type|

  remote_file "/etc/sensu/plugins/check-#{type}.rb" do
    source "https://raw.github.com/sensu/sensu-community-plugins/master/plugins/system/check-#{type}.rb"
    mode 0755
  end

  sensu_check "system_#{type}" do
    type 'status'
    command "check-#{type}.rb"
    handlers %w( mailer twiliosms )
    subscribers [ 'all' ]
  end

end

sensu_check 'system_swap' do
  action :delete
end