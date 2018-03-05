#
# Cookbook:: macos_nessus
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

nessus_cli "Link Nessus Agent" do
  action [:link]
  key ""
  host ""
  port ""
  groups [""]
  name ""
end
