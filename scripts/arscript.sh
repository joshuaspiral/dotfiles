#!/bin/sh
# Arscript by joshuaspiral

echo "Welcome to arscript, make sure you are connected to internet and running this script as root before proceeding";

if [ ! -d "/sys/firmware/efi/efivars" ];
then
    echo "This script currently only works with UEFI, reboot in EFI if available"
fi
echo "You are booted in UEFI mode! Starting installation.."

echo "Which drive are you installing Artix on"
read drive
echo "Partition the drive now (enter to continue)"
read -r lol
cfdisk $drive

echo "Root partition?"
read -r root
mkfs.ext4 -L BOOT $root

echo "Swap partition?"
read -r swap
swapoff $swap
mkswap -L SWAP $swap

echo "Efi System Partition?"
read -r esp
mkfs.vfat -F 32 -L BOOT $esp


swapon /dev/disk/by-label/SWAP
mount /dev/disk/by-label/ROOT /mnt
mkdir /mnt/boot/efi
mount /dev/disk/by-label/BOOT /mnt/boot/efi

echo "ParallelDownloads = 16" | tee -a /etc/pacman.conf
basestrap /mnt base base-devel runit elogind-runit linux linux-firmware git neovim

fstabgen -U /mnt >> /mnt/etc/fstab

echo "Now, cURL toxicfs.xyz/arscript2.sh in the chroot"

artix-chroot /mnt

