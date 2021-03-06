#
# Cookbook Name:: monitor
# Recipe:: master
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

# If an encrypted data bag called sensu/dashboard exists, then use that for the dashboard auth.
search(:sensu, 'id:dashboard') do |s|
  attrs = Chef::EncryptedDataBagItem.load('sensu', 'dashboard')

  node.override[:sensu][:dashboard][:user] = attrs['username']
  node.override[:sensu][:dashboard][:password] = attrs['password']
end

include_recipe "sensu::rabbitmq"
include_recipe "sensu::redis"

include_recipe "monitor::_worker"
include_recipe "monitor::chef_nodes"

include_recipe "sensu::api_service"
include_recipe "sensu::dashboard_service"

include_recipe "monitor::default"
