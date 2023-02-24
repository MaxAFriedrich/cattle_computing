# Configure installation method
url --mirrorlist="https://mirrors.fedoraproject.org/mirrorlist?repo=fedora-37&arch=x86_64"
repo --name=fedora-updates --mirrorlist="https://mirrors.fedoraproject.org/mirrorlist?repo=updates-released-f37&arch=x86_64" --cost=0
# Configure Boot Loader
bootloader --driveorder=sda

# Remove all existing partitions
clearpart --drives=sda --all

# zerombr
zerombr

#Create required partitions (BIOS boot partition and /boot)
reqpart --add-boot

# Create Physical Partition
part pv.01 --ondrive=sda --asprimary --size=8000 --grow 
volgroup vg pv.01
logvol swap --hibernation --vgname=vg --name=swap
logvol / --vgname=vg --name=fedora-root --size=2500 --grow --fstype=xfs

# Configure Firewall
firewall --enabled

# Configure Network Interfaces
network --onboot=yes --bootproto=dhcp --hostname=$host

# Configure Keyboard Layouts
keyboard gb 

# Configure Language During Installation
lang en_GB

# Services to enable/disable
services --disabled=mlocate-updatedb,mlocate-updatedb.timer,geoclue,avahi-daemon

# Configure Time Zone
timezone Europe/London

# Configure X Window System
xconfig --startxonboot

# Set Root Password
rootpw --lock

# Create User Account
user --name=$usr --password=$userpass --iscrypted --groups=wheel

# Perform Installation in Text Mode
text

# Package Selection
%packages
-gssproxy
-sssd*
-abrt*
@core
@standard
@hardware-support
@base-x
@fonts
@networkmanager-submodules
redhat-rpm-config
rpmconf
xrandr
%end

# Post-installation Script
%post

%end

# Reboot After Installation
reboot --eject
