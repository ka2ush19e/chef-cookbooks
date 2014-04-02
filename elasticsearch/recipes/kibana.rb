#
# Cookbook Name:: elasticsearch
# Recipe:: kibana
#
# Copyright (C) 2014 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

package "nginx" do
  action :install
end

service "nginx" do
  supports :status => true, :restart => true, :reload => true
  action   [:enable, :start]
end

template "/etc/nginx/nginx.conf" do
  source   "nginx.conf.erb"
  owner    "root"
  mode     0644
  notifies :restart, 'service[nginx]'
end

%w{default.conf ssl.conf virtual.conf}.each do |f|
  file "/etc/nginx/conf.d/#{f}" do
    action :delete
  end
end

template "/etc/nginx/conf.d/kibana.conf" do
  source   "nginx.kibana.conf.erb"
  owner    "root"
  mode     0644
  notifies :restart, 'service[nginx]'
end

bash "install kibana" do
  not_if { File.exist?("/opt/kibana") }
  user "root"
  code <<-EOH
  wget -nc -q https://download.elasticsearch.org/kibana/kibana/kibana-3.0.0.tar.gz -P /tmp/
  tar zxf /tmp/kibana-3.0.0.tar.gz -C /tmp/
  mv /tmp/kibana-3.0.0 /opt/
  ln -s /opt/kibana-3.0.0 /opt/kibana
  rm -f /tmp/kibana-3.0.0.tar.gz
  EOH
  notifies :restart, 'service[nginx]'
end

template "/opt/kibana/config.js" do
  source   "kibana.config.js.erb"
  owner    "root"
  mode     0644
  notifies :restart, 'service[nginx]'
  variables({
    :hostname => node[:hostname]
  })
end
