#
# Cookbook Name:: hostname
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

fqdn = node[:net][:fqdn]
ip   = node[:net][:ip]

if fqdn == node[:fqdn]
  return
end

file "/etc/sysconfig/network" do
  rc = Chef::Util::FileEdit.new(path)
  rc.search_file_replace_line(/^HOSTNAME/, "HOSTNAME=#{fqdn}")
  content rc.send(:contents).join
end

hostsfile_entry "127.0.0.1" do
  hostname "localhost"
  aliases  ['localhost.localdomain']
  action   :create
end
hostsfile_entry "::1" do
  action   :remove
end
hostsfile_entry "#{ip}" do
  hostname fqdn
  action   :create
end

execute "hostname #{fqdn}"
ohai "reload"
