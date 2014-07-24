#
# Cookbook Name:: presto
# Recipe:: presto-server
#
# Copyright (C) 2014 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

# Install PrestoServer
cookbook_file "/tmp/presto-server-0.73.tar.gz" do
  not_if { File.exist?("/opt/presto-server") }
  source "presto-server-0.73.tar.gz"
  owner  "root"
  group  "root"
  mode   0644
  action :create
end

bash "install presto-server" do
  not_if { File.exist?("/opt/presto-server") }
  user  "root"
  flags "-e"
  code <<-EOH
    tar zxf /tmp/presto-server-0.73.tar.gz -C /tmp/
    mv /tmp/presto-server-0.73 /opt/
    ln -s /opt/presto-server-0.73 /opt/presto-server
    rm -f /tmp/presto-server-0.73.tar.gz
  EOH
end

# Install PrestoClient
cookbook_file "/opt/presto-server/bin/presto" do
  source "presto-cli-0.73-executable.jar"
  owner  "root"
  group  "root"
  mode   0755
  action :create
end

# Set configs
etc_dir     = node.presto[:path][:etc]
catalog_dir = File.join(etc_dir, 'catalog')
%W{
  #{etc_dir}
  #{catalog_dir}
}.each do |dir|
  directory dir do
    not_if { Dir.exist?(dir) }
    owner  "root"
    group  "root"
    mode   0755
    action :create
  end
end

{
  etc_dir => [
    'node.properties',
    'jvm.config',
    'config.properties',
    'log.properties'
  ],
  catalog_dir => [
    'jmx.properties',
    'raptor.properties',
    'hive.properties'
  ]
}.each do |dir, filenames|
  filenames.each do |filename|
    template File.join(dir, filename) do
      source filename + ".erb"
      owner  "root"
      group  "root"
      mode   0644
    end
  end
end

# Create data directory
%W{
  #{node.presto[:path][:data]}
}.each do |dir|
  directory dir do
    not_if { Dir.exist?(dir) }
    owner  "presto"
    group  "presto"
    mode   0755
    action :create
  end
end

# Set initscript
template "/etc/init.d/presto-server" do
  source "presto-server.erb"
  owner  "root"
  group  "root"
  mode   0755
end

bash "add presto-server service" do
  not_if "chkconfig --list | grep presto-server"
  flags "-e"
  code <<-EOC
    chkconfig --add presto-server
  EOC
end
