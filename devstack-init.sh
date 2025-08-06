#!/bin/bash

echo "TRY TO INIT DEVSTACK"

git clone https://github.com/openstack/devstack.git ~/devstack

cd ~/devstack && git checkout stable/2025.1

sudo ~/devstack/tools/create-stack-user.sh

sudo rm -rf /opt/stack

externalip=$(curl 169.254.169.254/latest/meta-data/public-ipv4)
internalip=$(curl 169.254.169.254/latest/meta-data/local-ipv4)

cat << EOF > ~/devstack/local.conf
[[local|localrc]]
HOST_IP=$internalip
SERVICE_HOST=$HOST_IP
FLOATING_RANGE=10.58.1.192/27
FIXED_RANGE=10.11.12.0/24
IP_VERSION=4
ADMIN_PASSWORD=k76iLgK4zVWDtUYLLytZ
DATABASE_PASSWORD=1fZJo3kWf4RgqeohsI8Y
RABBIT_PASSWORD=QSY2B0S817AAY902Ct3b
SERVICE_PASSWORD=Zr4mUM9eU03Q7c8arEnt

# Nova 
NOVNCPROXY_URL="http://$externalip:6080/vnc_lite.html"
LIBVIRT_TYPE=qemu

# Swift
enable_service s-proxy s-object s-container s-account
SWIFT_HASH=66a3d6b56c1f479c8b4e70ab5c2000f5
SWIFT_REPLICAS=1
SWIFT_DATA_DIR=$DEST/data
EOF

tmux new-session -d -s devstack-init "~/devstack/stack.sh"

echo ""
echo -e "\033[0;32m## Tmux session listed below\033[0m"
tmux list-session
echo ""
echo -e "You can connect to tmux session via command \033[0;31mtmux attach-session -t devstack-init"
