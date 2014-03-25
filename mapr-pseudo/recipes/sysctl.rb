#
# Cookbook Name:: mapr-pseudo
# Recipe:: sysctl
#
# Copyright (C) 2014 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

cookbook_file "/etc/sysctl.conf" do
  source   "sysctl.conf"
  owner    "root"
  group    "root"
  mode     0600
  action   :create
  notifies :run, "execute[apply_sysctl]", :immediately
end

execute "apply_sysctl" do
  user    "root"
  command "sysctl -p"
  action  :nothing
  ignore_failure true
end
