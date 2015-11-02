#!/bin/sh
set -e

# NOTE:
# For the first time of vagrant provisiong, do nothing and exit.
# The second time of vagrant provisioning after reboot, do actual setup.
if [ ! -f ~/.ready_to_create_container ]; then
  touch ~/.ready_to_create_container
  exit 0
fi

state=`lxc-info -n container1 -s | awk '/^State:/ {print $2}' || :`
if [ "$state" = "" ]; then
  lxc-create -t download -n container1 -- --dist ubuntu --release trusty --arch amd64
fi
if [ "$state" != "RUNNING" ]; then
  lxc-start -n container1 -d
  sleep 5
fi
if ! lxc-attach -n container1 -- dpkg -s python > /dev/null 2>&1; then
  lxc-attach -n container1 -- apt-get install -y python
fi
