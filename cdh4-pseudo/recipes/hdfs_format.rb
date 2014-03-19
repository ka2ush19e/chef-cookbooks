#
# Cookbook Name:: cdh4-pseudo
# Recipe:: hdfs_format
#
# Copyright (C) 2014 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

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
