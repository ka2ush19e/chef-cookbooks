#
# Cookbook Name:: cdh4-pseudo
# Recipe:: hadoop
#
# Copyright (C) 2014 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

package "hadoop-0.20-conf-pseudo" do
  action :install
end

cookbook_file "/etc/hadoop/conf/hadoop-env.sh" do
  source "hadoop-env.sh"
  owner  "root"
  group  "root"
  mode   0755
  action :create
end

service "hadoop-hdfs-secondarynamenode" do
  action [:stop, :disable]
end

%w{
  start-hdfs.sh
  stop-hdfs.sh
  restart-hdfs.sh
  status-hdfs.sh
  start-mapreduce.sh
  stop-mapreduce.sh
  restart-mapreduce.sh
  status-mapreduce.sh
  start-all.sh
  stop-all.sh
  restart-all.sh
  status-all.sh
}.each do |script|
  cookbook_file "/home/vagrant/#{script}" do
    source script
    owner  "vagrant"
    group  "vagrant"
    mode   0755
    action :create
  end
end
