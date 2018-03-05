# macos_nessus

Use the `nessus_cli` resource to link or unlink the Tenable Nessus Agent on macOS. Under the hood, the nessus_cli resource executes the `/Library/NessusAgent/run/sbin/nessuscli` command.

Syntax
------

A **nessus_cli** resource block declares a basic description of the command configuration
and a set of properties depending on the actions executed. For example:

```ruby
nessus_cli 'link nessus' do
  action [:link]
  key "23423453232423423"
  host "cloud.tenable.com"
  port "443"
  groups ["Group1"]
end
```

where

- `:link` links the installed Nessus Agent to the appropriate Tenable server

There are __no__ default values for this resource.


Actions
-------

This resource has the following actions:

`:link`

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Link the nessus agent.

`:unlink`

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Unlink the nessus agent.

Properties
----------

`key`

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Ruby Type:** `String`

`host`

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Ruby Type:** `String`

`port`

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Ruby Type:** `String`

`groups`

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Ruby Type:** `Array`

`name`

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Ruby Type:** `String`

`force`

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Ruby Type:** `Boolean (TrueClass)`