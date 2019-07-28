#!/bin/bash
#
# Author: Don Freiday
# 07.28.2019
#
# Initial setup script for Kali VM

# Change root pw
passwd

# Tweak VM for performance
# https://wiki.archlinux.org/index.php/VMware#System_speedup_tricks
echo "echo never > /sys/kernel/mm/transparent_hugepage/enabled" >> ~/.bashrc
echo "By default, VMware writes a running guest system's RAM to a file on disk. If you're certain you have enough spare memory, you can ensure the guest OS writes its memory directly to the host's RAM. See https://wiki.archlinux.org/index.php/VMware#System_speedup_tricks"

# Update
apt update && apt dist-upgrade && apt autoremove

# Install VS Code
# Download the Microsoft GPG key and convert it from OpenPGP ASCII armor format to GnuPG format:
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
# Move the file into your apt trusted keys directory:
mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
# Add the Visual Studio Code Repository to /etc/apt/sources.list.d/ :
echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list
# Install
apt update && apt install code

# Set up Metasploit database
service postgresql start
msfdb init

# Install Discover Scripts (for passive enumeration)
cd /opt
git clone https://github.com/leebaird/discover.git
cd discover
./update.sh

# Install smbexec (for grabbing hashes from the Domain Controller and reverse shells)
cd /opt
git clone https://github.com/brav0hax/smbexec.git
cd smbexec
./install.sh

# Install veil (for creating Python based Meterpreter executable)
# cd /opt
# git clone https://github.com/veil-evasion/Veil.git
# cd Veil/setup
# ./setup.sh


