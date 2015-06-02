#
# Cookbook Name:: cdh5-pseudo
# Recipe:: hadoop
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package 'hadoop-conf-pseudo' do
  action :install
end

service 'hadoop-hdfs-secondarynamenode' do
  action [:stop, :disable]
end

cookbook_file '/etc/hadoop/conf/hadoop-env.sh' do
  source 'hadoop-env.sh'
  owner 'root'
  group 'root'
  mode 0755
  action :create
end

%w{start-all.sh stop-all.sh status-all.sh}.each do |script|
  cookbook_file "/home/vagrant/#{script}" do
    source script
    owner 'vagrant'
    group 'vagrant'
    mode 0755
    action :create
  end
end

%w{hadoop-hdfs-datanode hadoop-hdfs-namenode}.each do |s|
  service s do
    not_if { File.exist?('/var/lib/hadoop-hdfs/.hdfs_format') }
    action :stop
  end
end

bash 'hdfs format' do
  not_if { File.exist?('/var/lib/hadoop-hdfs/.hdfs_format') }
  user 'hdfs'
  code <<-EOH
  yes | hdfs namenode -format -force
  touch /var/lib/hadoop-hdfs/.hdfs_format
  EOH
end

%w{hadoop-hdfs-namenode hadoop-hdfs-datanode}.each do |s|
  service s do
    action [:enable, :start]
  end
end

bash 'hdfs init' do
  not_if { File.exist?('/var/lib/hadoop-hdfs/.hdfs_init') }
  user 'root'
  code <<-EOH
  /usr/lib/hadoop/libexec/init-hdfs.sh
  touch /var/lib/hadoop-hdfs/.hdfs_init
  EOH
end

%w{hadoop-yarn-resourcemanager hadoop-yarn-nodemanager hadoop-mapreduce-historyserver}.each do |s|
  service s do
    action [:enable, :start]
  end
end
