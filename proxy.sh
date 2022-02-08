#!/bin/bash

if [[ "$EUID" = 0 ]]; then
    path=$0
    path=${path%/*}
    sudo sh $path/iptables.sh
    sudo service redsocks start
else
    echo "You need sudo privileges to run this script"
fi


