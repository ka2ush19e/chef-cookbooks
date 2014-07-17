#
# Cookbook Name:: presto
# Recipe:: presto-server
#
# Copyright (C) 2014 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

bash "install presto-server" do
  not_if { File.exist?("/opt/presto-server") }
  user "root"
  code <<-EOH
  wget -nc -q http://central.maven.org/maven2/com/facebook/presto/presto-server/0.73/presto-server-0.73.tar.gz -P /tmp/
  tar zxf /tmp/presto-server-0.73.tar.gz -C /tmp/
  mv /tmp/presto-server-0.73 /opt/
  ln -s /opt/presto-server-0.73 /opt/presto-server
  rm -f /tmp/presto-server-0.73.tar.gz
  EOH
end

bash "install presto-cli" do
  not_if { File.exist?("/opt/presto-server/bin/presto") }
  user "root"
  code <<-EOH
  wget -nc -q http://central.maven.org/maven2/com/facebook/presto/presto-cli/0.73/presto-cli-0.73-executable.jar -P /opt/presto-server/bin
  mv /opt/presto-server/bin/presto-cli-0.73-executable.jar /opt/presto-server/bin/presto
  chmod +x /opt/presto-server/bin/presto
  EOH
end

[
  node.presto[:path][:conf],
  File.join(node.presto[:path][:conf], "catalog"),
  node.presto[:path][:data]
].each do |dir|
  directory dir do
    owner     "root"
    group     "root"
    mode      00755
    action    :create
    recursive true
    not_if { Dir.exist?(dir) }
  end
end

[
  "node.properties",
  "jvm.config",
  "config.properties",
  "log.properties"
].each do |filename|
  template File.join(node.presto[:path][:conf], filename) do
    source filename + ".erb"
    owner  "root"
    group  "root"
    mode   0644
  end
end

[
  "jmx.properties",
  "raptor.properties"
].each do |filename|
  file = File.join(node.presto[:path][:conf], "catalog", filename)
  template file do
    source filename + ".erb"
    owner  "root"
    group  "root"
    mode   0644
  end
end
