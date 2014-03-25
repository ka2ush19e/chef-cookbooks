#
# Cookbook Name:: mapr-pseudo
# Recipe:: yum_repo
#
# Copyright (C) 2014 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "yum"

yum_repository "maprtech" do
  repositoryid "maprtech"
  description  "MapR Technologies"
  baseurl      "http://package.mapr.com/releases/v3.1.0/redhat/"
  gpgcheck     false
  action       :create
end

yum_repository "maprecosystem" do
  repositoryid "maprecosystem"
  description  "MapR Technologies"
  baseurl      "http://package.mapr.com/releases/ecosystem/redhat"
  gpgcheck     false
  action       :create
end
