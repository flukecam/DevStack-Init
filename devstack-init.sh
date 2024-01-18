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
EOF

tmux new-session -d -s devstack-init "~/devstack/stack.sh"
