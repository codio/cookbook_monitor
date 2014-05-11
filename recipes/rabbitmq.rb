#
# Cookbook Name:: monitor
# Recipe:: rabbitmq
#
# Copyright 2013, Sean Porter Consulting
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe "monitor::default"

sensu_gem "carrot-top"
sensu_gem "rest-client"


url = "https://raw.githubusercontent.com/sensu/sensu-community-plugins/master/plugins/rabbitmq/rabbitmq-alive.rb"
remote_file "/etc/sensu/plugins/rabbitmq-alive.rb" do
  source url
  mode 0755
  only_if "curl -s -o /dev/null -w \"%{http_code}\" #{url} | grep 200"
end

url = "https://raw.githubusercontent.com/joelmoss/sensu-community-plugins/rabbitmq_message_check/plugins/rabbitmq/check-rabbitmq-messages.rb"
remote_file "/etc/sensu/plugins/check-rabbitmq-messages.rb" do
  source url
  mode 0755
  only_if "curl -s -o /dev/null -w \"%{http_code}\" #{url} | grep 200"
end


# Fetch RabbitMQ data bag
search(:rabbitmq, "id:password") do |keys|
  if keys['password'].has_key? 'encrypted_data'
    keys = Chef::EncryptedDataBagItem.load('rabbitmq', 'password')
  end

  username = 'rabbitmq'
  password = keys['password']

  sensu_check "rabbitmq_alive" do
    type "status"
    command "rabbitmq-alive.rb -u #{username} -p #{password}"
    handlers [ 'default' ]
    subscribers [ 'node_worker' ]
  end

  # Ignore these queues
  ignored_queues = ["acv2server-tasks-errors", "aliveness-test", "backends-migrator",
                    "backends-migrator-error", "filewatcher-events-delay-server",
                    "filewatcher-events-delay-sharejs", "fs-migrator", "fs-migrator-error"].join(',')

  sensu_check "rabbitmq_messages" do
    type "status"
    command "check-rabbitmq-messages.rb --user #{username} --password #{password} -w 100 -c 250 -i #{ignored_queues}"
    handlers [ 'default' ]
    subscribers [ 'node_worker' ]
  end
end
