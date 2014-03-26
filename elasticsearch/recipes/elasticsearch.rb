#
# Cookbook Name:: elasticsearch
# Recipe:: elasticsearch
#
# Copyright (C) 2014 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

package "elasticsearch" do
  action :install
end

service "elasticsearch" do
  action :enable
end
