#!/bin/sh
set -e

usernet_count=10

# Install LXC
if ! dpkg -s lxc > /dev/null 2>&1; then
  sudo apt-get update
  sudo apt-get install -y lxc
fi

# Allow vagrant user to create network device on the LXC host
if ! grep -q "^$USER" /etc/lxc/lxc-usernet; then
  sudo sh -c "echo '$USER veth lxcbr0 $usernet_count' >> /etc/lxc/lxc-usernet"
fi

# NOTE: Setup for using dnsmasq installed with lxc to resolve container names on the LXC host
if ! grep -q '^prepend domain-name-servers 10\.0\.3\.1;' /etc/dhcp/dhclient.conf; then
  sudo sed -i '
/^#prepend domain-name-servers 127.0.0.1;/a\
prepend domain-name-servers 10.0.3.1;
' /etc/dhcp/dhclient.conf
fi

# Create ~/.config/lxc/default.conf
if [ ! -f ~/.config/lxc/default.conf ]; then
  mkdir -p ~/.config/lxc
  cp /etc/lxc/default.conf ~/.config/lxc/default.conf
fi
if ! grep -q '^lxc.id_map = u' ~/.config/lxc/default.conf; then
  awk -F: '/^'$USER':/{print "lxc.id_map = u 0", $2, $3}' /etc/subuid >> ~/.config/lxc/default.conf
fi
if ! grep -q '^lxc.id_map = g' ~/.config/lxc/default.conf; then
  awk -F: '/^'$USER':/{print "lxc.id_map = g 0", $2, $3}' /etc/subgid >> ~/.config/lxc/default.conf
fi
