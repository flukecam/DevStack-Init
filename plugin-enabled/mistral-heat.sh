#!/bin/bash

echo "TRY TO INIT DEVSTACK"

git clone https://github.com/openstack/devstack.git ~/devstack

cd ~/devstack && git checkout stable/2023.2

sudo ~/devstack/tools/create-stack-user.sh

sudo rm -rf /opt/stack

cat << EOF > ~/devstack/local.conf
[[local|localrc]]
ADMIN_PASSWORD=k76iLgK4zVWDtUYLLytZ
DATABASE_PASSWORD=1fZJo3kWf4RgqeohsI8Y
RABBIT_PASSWORD=QSY2B0S817AAY902Ct3b
SERVICE_PASSWORD=Zr4mUM9eU03Q7c8arEnt

enable_plugin heat https://github.com/openstack/heat.git refs/heads/stable/2023.2
enable_plugin heat-dashboard https://github.com/openstack/heat-dashboard.git refs/heads/stable/2023.2

enable_plugin mistral https://github.com/openstack/mistral.git refs/heads/stable/2023.2
EOF

sudo mkdir /var/log/devstack-init
tmux new-session -d -s devstack-init "~/devstack/stack.sh > /var/log/devstack-init/devstack-init.log 2>&1"

echo "You can view log at file /var/log/devstack-init/devstack-init.log"