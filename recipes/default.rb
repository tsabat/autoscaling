#
# Cookbook Name:: autoscaling
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

%w{python-setuptools}.each do |p|
  package p
end

bash "easy_install pip" do
  code "easy_install pip"
end

bash "pip install boto" do
  code "pip install boto"
end

template "/root/.boto" do
  source "boto.cfg.erb"
  owner "root"
  group "root"
  mode "0770"
end

template "/root/.boto" do
  source "boto.cfg.erb"
  owner "root"
  group "root"
  mode "0770"
end

template "/root/.boto" do
  source "boto.cfg.read_only.erb"
  owner "root"
  group "root"
  mode "0660"
end

template "/home/deploy/.boto" do
  source "boto.cfg.erb"
  owner "deploy"
  group "root"
  mode "0660"
end

directory "/root/codepen/" do
  owner "root"
  group "root"
  mode "0770"
end

template "/home/deploy/snapshot.py" do
  source "snapshot.py"
  owner "deploy"
  group "root"
  mode "0770"
end

template "/root/codepen/prep_userdata.py" do
  source "prep_userdata.py"
  owner "root"
  group "root"
  mode "0770"
end

template "/root/codepen/userdata.sh" do
  source "userdata.sh"
  owner "root"
  group "root"
  mode "0770"
end

