#!/bin/bash

echo "TRY TO INIT DEVSTACK"

git clone https://github.com/openstack/devstack.git ~/devstack

cd ~/devstack && git checkout stable/2025.1

sudo ~/devstack/tools/create-stack-user.sh

sudo rm -rf /opt/stack

cat << EOF > ~/devstack/local.conf
[[local|localrc]]
FLOATING_RANGE=10.58.1.192/27
FIXED_RANGE=10.11.12.0/24
ADMIN_PASSWORD=k76iLgK4zVWDtUYLLytZ
DATABASE_PASSWORD=1fZJo3kWf4RgqeohsI8Y
RABBIT_PASSWORD=QSY2B0S817AAY902Ct3b
SERVICE_PASSWORD=Zr4mUM9eU03Q7c8arEnt
EOF

tmux new-session -d -s devstack-init "~/devstack/stack.sh"

echo ""
echo -e "\033[0;32m## Tmux session listed below\033[0m"
tmux list-session
echo ""
echo -e "You can connect to tmux session via command \033[0;31mtmux attach-session -t devstack-init"
