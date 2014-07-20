#
# Cookbook Name:: presto
# Recipe:: user
#
# Copyright (C) 2014 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

user "presto" do
  comment  "Presto"
  password nil
  shell    "/sbin/nologin"
  action   :create
end

user "presto" do
  home   node.presto[:path][:data]
  action :modify
end

group "presto" do
  members ["presto"]
  action  :create
end
