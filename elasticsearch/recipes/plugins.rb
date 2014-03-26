#
# Cookbook Name:: elasticsearch
# Recipe:: plugins
#
# Copyright (C) 2014 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

node[:elasticsearch][:plugins].each do |name, url|
  execute "install_plugins" do
    not_if { Dir.exist?("/usr/share/elasticsearch/plugins/#{name}") }
    user    "root"
    command "/usr/share/elasticsearch/bin/plugin -i #{url}"
    action  :run
  end
end
