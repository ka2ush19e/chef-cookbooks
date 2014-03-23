#
# Cookbook Name:: yum-update
# Recipe:: default
#
# Copyright (C) 2014 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

execute "yum-update" do
  user    "root"
  command "yum update -y"
  action  :run
end
