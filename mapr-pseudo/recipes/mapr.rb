#
# Cookbook Name:: mapr-pseudo
# Recipe:: mapr
#
# Copyright (C) 2014 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

%w{
  mapr-cldb
  mapr-fileserver
  mapr-jobtracker
  mapr-nfs
  mapr-tasktracker
  mapr-webserver
  mapr-zookeeper
}.each do |pkg|
  package pkg do
    action :install
  end
end

execute "configure" do
  user    "root"
  command "yes | /opt/mapr/server/configure.sh -C `hostname` -Z `hostname`"
  action  :run
end
