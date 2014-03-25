#
# Cookbook Name:: mapr-pseudo
# Recipe:: ulimit
#
# Copyright (C) 2014 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

ulimit_domain "mapr" do
  rule do
    item  :nofile
    type  :-
    value 64000
  end
  rule do
    item  :nproc
    type  :-
    value 64000
  end
end
