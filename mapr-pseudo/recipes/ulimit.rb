#
# Cookbook Name:: mapr-pseudo
# Recipe:: ulimit
#
# Copyright (C) 2014 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

cookbook_file "/etc/security/limits.conf" do
  source "limits.conf"
  owner  "root"
  group  "root"
  mode   0600
  action :create
end

cookbook_file "/etc/security/limits.d/90-nproc.conf" do
  source "90-nproc.conf"
  owner  "root"
  group  "root"
  mode   0600
  action :create
end
