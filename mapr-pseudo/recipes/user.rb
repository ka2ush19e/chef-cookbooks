#
# Cookbook Name:: mapr-pseudo
# Recipe:: user
#
# Copyright (C) 2014 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

user "mapr" do
  home     "/home/mapr"
  password nil
  action   :create
end

group "mapr" do
  members ['mapr']
  action  :create
end
