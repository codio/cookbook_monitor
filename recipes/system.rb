#
# Cookbook Name:: monitor
# Recipe:: system
#
# Checks load, CPU, Disk and RAM, and sends notifications via mail.
#

include_recipe "monitor::default"

%w( load cpu disk ram ).each do |type|

  url = "https://raw.github.com/sensu/sensu-community-plugins/master/plugins/system/check-#{type}.rb"
  remote_file "/etc/sensu/plugins/check-#{type}.rb" do
    source url
    mode 0755
    only_if "curl -s -o /dev/null -w \"%{http_code}\" #{url} | grep 200"
  end

  sensu_check "system_#{type}" do
    type 'status'
    command "check-#{type}.rb"
    handlers [ 'default' ]
    subscribers [ 'all' ]
    additional occurrences: node[:monitor][:checks]["system_#{type}"][:occurrences]
  end

end
