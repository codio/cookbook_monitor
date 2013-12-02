#
# Cookbook Name:: monitor
# Recipe:: system
#
# Checks load, CPU, Disk and RAM, and sends notifications via mail.
#

%w( load cpu disk ram swap ).each do |type|

  remote_file "/etc/sensu/plugins/check-#{type}.rb" do
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
    handlers [ 'mailer' ]
    subscribers [ 'all' ]
  end

end