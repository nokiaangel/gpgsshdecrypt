#!/bin/bash

$IPADDRESS = 192.168.200.21
$PASSWORD = password
$USERNAME = pi

decrypt="$(cat <<-EOF
    echo "Access from CPU successful"i
    if [ ! -f "/home/pi/hello.sh" ]; then
        gpg --batch --passphrase password -d /home/pi/hello.sh.gpg > /home/pi/hello.sh
        echo "File unlocked successfully"
        cd /home/pi
        ./hello.sh
    fi
EOF
)"

while true; do
    sshpass -p $PASSWORD ssh $USERNAME@$IPADDRESS "$decrypt"
    echo "Connected to $IPADDRESS"
    sleep 60
done