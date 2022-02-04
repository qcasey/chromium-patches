#!/bin/bash

pacman-key --init
pacman-key --populate archlinux
pacman -Sy archlinux-keyring && pacman -Syyu --needed --noconfirm && pacman -S --needed --noconfirm git patch
useradd droneci -m
chown droneci:droneci /drone/src
passwd -d droneci
printf 'droneci ALL=(ALL) ALL\n' | tee -a /etc/sudoers
su - droneci
git clone https://aur.archlinux.org/ungoogled-chromium.git
cd ungoogled-chromium
patch PKGBUILD < /drone/src/PKGBUILD.patch
makepkg --syncdeps --noconfirm
mv *.zst /drone/src