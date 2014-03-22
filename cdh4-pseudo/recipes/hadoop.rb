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

%w{hadoop-hdfs-datanode hadoop-hdfs-namenode}.each do |s|
  service s do
    action :stop
  end
end

bash "hdfs format" do
  not_if { File.exist?("/var/lib/hadoop-hdfs/.hdfs_format") }
  user "hdfs"
  code <<-EOH
  yes | hdfs namenode -format
  touch /var/lib/hadoop-hdfs/.hdfs_format
  EOH
end

%w{hadoop-hdfs-namenode hadoop-hdfs-datanode}.each do |s|
  service s do
    action :start
  end
end

bash "hdfs setup" do
  not_if { File.exist?("/var/lib/hadoop-hdfs/.hdfs_setup") }
  user   "hdfs"
  code <<-EOH
  hadoop fs -mkdir /tmp
  hadoop fs -chmod -R 1777 /tmp
  hadoop fs -mkdir -p /var/lib/hadoop-hdfs/cache/mapred/mapred/staging
  hadoop fs -chmod 1777 /var/lib/hadoop-hdfs/cache/mapred/mapred/staging
  hadoop fs -chown -R mapred /var/lib/hadoop-hdfs/cache/mapred
  hadoop fs -mkdir -p /user/vagrant
  hadoop fs -chown vagrant /user/vagrant
  touch /var/lib/hadoop-hdfs/.hdfs_setup
  EOH
end

%w{hadoop-0.20-mapreduce-jobtracker hadoop-0.20-mapreduce-tasktracker}.each do |s|
  service s do
    action :start
  end
end
