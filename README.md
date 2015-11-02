lxc-vagrant-shell-provision-example
===================================

An example for setting up LXC and create a LXC container using Vagrant shell provisioner.

## Usage

You need to run

```
vagrant up && vagrant halt && vagrant up --provision
```

instead of just `vagrant up`.

This is because we must reboot your virtual machine before running `lxc-create` after installing `cgmanager`.
See https://linuxcontainers.org/lxc/getting-started/

## License
MIT
