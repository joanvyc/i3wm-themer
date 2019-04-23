#!/bin/env bash

### Script written by Stavros Grigoriou ( github.com/unix121 )
### 20180505 Changes fully commented by James Shane ( github.com/jamesshane )
### 20180727 Python dependencies shifted to pacman by Graham Still ( github.com/adoxography )
### 20181009 Detection and Use of system AUR helpers by c0de ( github.com/alopexc0de )

#refrsh pacman
sudo pacman -Syy

#added binutils,gcc,make,pkg-config,fakeroot for compilations, removed yaourt
#added python-yaml, removed pip install
sudo pacman -S git nitrogen rofi binutils gcc make pkg-config fakeroot python-yaml --noconfirm

#file didn't exist for me, so test and touch
if [ -e $HOME/.Xresources ]
then
	echo "... .Xresources found."
else
	touch $HOME/.Xresources
fi

#file didn't exist for me, so test and touch
if [ -e $HOME/.config/nitrogen/bg-saved.cfg ]
then
	echo "... .bg-saved.cfg found."
else
	mkdir -p $HOME/.config/nitrogen
	touch $HOME/.config/nitrogen/bg-saved.cfg
fi

#file didn't exist for me, so test and touch
if [ -e $HOME/.config/i3/config ]
then
        echo "... i3/config found."
else
        mkdir -p $HOME/.config/i3
        touch $HOME/.config/i3/config
fi

#rework of user in config.yaml
cd src
rm -f config.yaml
cp defaults/config.yaml .
sed -i -e "s/USER/$USER/g" config.yaml

#backup
mkdir $HOME/.i3-theme-backup
python i3wm-themer.py --config config.yaml --backup $HOME/.i3-theme-backup

#configure and set theme to 000
python i3wm-themer.py --config config.yaml --install defaults/
python i3wm-themer.py --config config.yaml --load themes/002.json

echo ""
echo "Read the README.md"

