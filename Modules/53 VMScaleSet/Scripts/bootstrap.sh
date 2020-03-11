#!/bin/bash

apt-get update
apt-get install -y nginx
systemctl start nginx


echo "bootscript done" > /tmp/results.txt