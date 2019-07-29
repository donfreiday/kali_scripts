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

# Install libnotify-bin
apt update && apt install libnotify-bin

# Install VS Code
# Download the Microsoft GPG key and convert it from OpenPGP ASCII armor format to GnuPG format:
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
# Move the file into your apt trusted keys directory:
mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
# Add the Visual Studio Code Repository to /etc/apt/sources.list.d/ :
echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list
# Install
apt update && apt install code
mkdir ~/.vscode_data
echo "alias code='code --user-data-dir=~/.vscode_data'" >> ~/.bashrc

# Set up Metasploit database
service postgresql start
msfdb init

# Install Discover Scripts (for passive enumeration)
cd /opt
git clone https://github.com/leebaird/discover.git
cd discover
./update.sh

# Install smbexec (for grabbing hashes from the Domain Controller and revcerse shells)
cd /opt
git clone https://github.com/brav0hax/smbexec.git
cd smbexec
./install.sh

# Install veil (for creating Python based Meterpreter executable)
# cd /opt
# git clone https://github.com/veil-evasion/Veil.git
# cd Veil/setup
# ./setup.sh

# Download Windows Credential Editor (for pulling passwords from memory)
cd ~/Desktop
wget http://www.ampliasecurity.com/research/wce_v1_41beta_universal.zip
unzip -d ./wce wce_v1_41beta_universal.zip
rm wce_v1_41beta_universal.zip 

# Download Mimikatz (for pulling passwords from memory)
cd ~/Desktop
wget http://blog.gentilkiwi.com/downloads/mimikatz_trunk.zip
unzip -d ./mimikatz mimikatz_trunk.zip
rm mimikatz_trunk.zip 

# Download password lists
cd ~/Desktop
mkdir password_list && cd password_list
wget http://downloads.skullsecurity.org/passwords/rockyou.txt.bz2
bzip2 -d rockyou.txt.bz2
echo "Download crackstation-human-only.txt.gz to ~/Desktop from https://drive.google.com/file/d/0B6easGCBkw9fR0NCOGpVZndQX2M/view, then press any key..."
read -p
gzip -d crackstation-human-only.txt.gz

# Download nmap script
cd/usr/share/nmap/scripts/
wget https://raw.github.com/hdm/scan-tools/master/nse/banner-plus.nse

# Download powersploit PowerShell scripts (for post exploitation)
cd /opt
git clone https://github.com/mattifestation/PowerSploit.git
cd PowerSploit
wget https://raw.github.com/obscuresec/random/master/StartListener.py
wget https://raw.github.com/darkoperator/powershell_scripts/master/ps_encoder.py

# Install Responder (for getting NTLM challenge/response hashes)
cd /opt
git clone https://github.com/SpiderLabs/Responder.git