#!/bin/bash

# these commands were used in a recent performance benchmark video for KyberDriveFS
clear
sudo apt install -y neofetch nvme-list lsblk
clear
neofetch
sleep 10
lsblk
sleep 10
nvme list
sleep 10
