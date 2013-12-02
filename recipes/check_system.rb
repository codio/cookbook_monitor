#
# Cookbook Name:: monitor
# Recipe:: check_system
#
# Checks load, CPU, Disk and RAM, and sends notifications via mail.
#

%w( load cpu disk ram swap ).each do |type|

  remote_file "/etc/sensu/plugins/check-#{type}.#{type == 'swap' ? 'sh' : 'rb'}" do
    if type == 'swap'
      source "https://raw.github.com/sensu/sensu-community-plugins/master/plugins/system/check-#{type}.sh"
    else
      source "https://raw.github.com/sensu/sensu-community-plugins/master/plugins/system/check-#{type}.rb"
    end
    mode 0755
  end

  sensu_check "system_#{type}" do
    type 'status'
    command type == 'swap' ? "check-#{type}.sh" : "check-#{type}.rb"
    handlers %w( mailer twiliosms )
    subscribers [ 'all' ]
  end

end