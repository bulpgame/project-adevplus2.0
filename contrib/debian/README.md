
Debian
====================
This directory contains files used to package adevplus20d/adevplus20-qt
for Debian-based Linux systems. If you compile adevplus20d/adevplus20-qt yourself, there are some useful files here.

## adevplus20: URI support ##


adevplus20-qt.desktop  (Gnome / Open Desktop)
To install:

	sudo desktop-file-install adevplus20-qt.desktop
	sudo update-desktop-database

If you build yourself, you will either need to modify the paths in
the .desktop file or copy or symlink your adevplus20-qt binary to `/usr/bin`
and the `../../share/pixmaps/adevplus20128.png` to `/usr/share/pixmaps`

adevplus20-qt.protocol (KDE)

