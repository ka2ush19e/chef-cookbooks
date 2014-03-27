#
# Cookbook Name:: elasticsearch
# Recipe:: elasticsearch
#
# Copyright (C) 2014 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

cookbook_file "/etc/security/limits.d/10-elasticsearch.conf" do
  source   "10-elasticsearch.conf"
  owner    "root"
  group    "root"
  mode     0644
  action   :create
end

package "elasticsearch" do
  action :install
end

service "elasticsearch" do
  action [:enable, :start]
end
