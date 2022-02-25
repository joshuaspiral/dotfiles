#!/bin/sh
# Arscript by joshuaspiral

echo "What region do you live in?"
read -r region
echo "What city do you live in?"
read -r city

ln -sf /usr/share/zoneinfo/$region/$city/ /etc/localtime
hwclock --systohc

echo "ParallelDownloads = 16" | tee -a /etc/pacman.conf

echo "Uncomment the locales you need"
read -r lol
nvim /etc/locale.gen

locale-gen
echo LANG="en_US.UTF-8" | tee -a /etc/locale.conf
pacman -S grub os-prober efibootmgr
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=grub
grub-mkconfig -o /boot/efi/grub/grub.cfg

echo "Set root password"
passwd
echo "Add wheel user"
echo "Name?"
read -r name
useradd -m -G wheel $name
echo "%wheel ALL=(ALL) ALL" | tee -a /etc/sudoers

echo "Hostname?"
read -r hostname
echo $hostname | tee -a /etc/hostname

echo "127.0.0.1        localhost" | tee -a /etc/hosts
echo "::1              localhost" | tee -a /etc/hosts
echo "127.0.1.1        localhost" | tee -a /etc/hosts

pacman -S dhcpcd-runit 
echo "Are you using wireless?"
read -r wireless

if [ $wireless == "y" ];
then
    pacman -S networkmanager-runit

echo "Exit, umount -R /mnt, and reboot"
