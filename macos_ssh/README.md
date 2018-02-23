# macos_ssh

Use the ssh resource to manage the "Remote Login" settings, found in System Preferences > Sharing > Remote Login. Under the hood, an ssh resource executes the `systemsetup -setremotelogin` command. It also allows the configurability of who can login via SSH, such as user groups or individual users.

Syntax
------

An **ssh** resource block declares a basic description of the command configuration
and a set of properties depending on the actions executed. For example:

```ruby
ssh 'activate and configure ard' do
  action [:activate, :configure]
end
```

where

- `:activate` enable SSH access (Remote Login)
- `:configure` configures SSH access for users and groups

The default `:configure` action will set the Remote Login access to "All Users". If you want to limit access, you will need to define either `access_groups` and/or `access_users`. The `:configure` action is also only nuclear when no options are used, at which point Access will be reset to "All Users".

**Note:** If the recipe is run with both `access_groups` and `access_users`, and then later on, one of those options is removed, the now undefined user or group will NOT be removed from the access group. The only way to reset this would be to remove both options, and then re-add the desired option back.

Actions
-------

This resource has the following actions:

`:activate`

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Activate the ssh agent.

`:deactivate`

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Deactivate the ssh agent.

`:configure`

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Configure who can login via SSH to the device.

Properties
----------

`access_groups`

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Ruby Type:** `Array`

`access_users`

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Ruby Type:** `Array`