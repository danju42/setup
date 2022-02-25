#!/usr/bin/env	bash

echo "######################################################################"
echo "#  ______                              ______                        #"
echo "# / _____)             _              / _____)      _                #"
echo "#( (____  _   _  ___ _| |_ ___ ____  ( (____  ___ _| |_ _   _ ____   #"
echo "# \____ \| | | |/___|_   _) _ |    \  \____ \| _ (_   _) | | |  _ \  #"
echo "# _____) ) |_| |___ | | |_| __| | | | _____) ) __| | |_| |_| | |_| | #"
echo "#(______/ \__  (___/   \__)___)_|_|_|(______/|___)  \__)____/|  __/  #"
echo "#        (____/                                              |_|     #"
echo "######################################################################"

echo -e "1. Debian\n2. Fedora\n3. OpenSuse"

read -p "Select: " VERSION

while [ "$VERSION" -gt 3 ] || [ "$VERSION" -lt 1  ] || 
	[ -z "${VERSION##*[!0-9]*}" ]
do
	echo "Invalid entry. Please try again"
	read -p "Select: " VERSION
done

case "$VERSION" in
	1)
		PACKET_MANAGER="apt"
		DEVELOPMENT="gcc g++ gfortran gforth gnat clang dwarves \
			     elfutils gnuradio wxhexeditor make cmake golang \
			     mspdebug openocd gcc-arm-none-eabi ruby \
			     gcc-arm-linux-gnueabi gcc-arm-linux-gnueabihf \
			     octave octave-* clojure qtcreator lua5.3 labplot \
			     kcachegrind* gcc-avr avr-libc gdb \
			     avrdude* binutils-avr stlink-* gdb-avr"
		SCIPY_STACK="python3-numpy python3-scipy python3-matplotlib \
			     ipython3 python3-pandas python3-sympy python3-nose"
		UTILITIES="vim htop tmux acpi git mc powertop redshift-gtk \
			   tree screen rxvt-unicode-256color firejail \
			   gnome-disk-utility neofetch gparted wireshark \
			   transmission rsync flashrom p7zip* \
			   ibus-table-latex latte-dock xfce4-terminal \
			   vim-airline vim-pathogen vim-youcompleteme \
			   fonts-powerline bats shellcheck fdupes yakuake"
		SYSTEM="firmware-linux fonts-cros* lshw debian-goodies"
		INTERNET="pidgin pidgin-otr konversations"
		MEDIA="rhythmbox audacity vlc ffmpeg kid3 clementine elisa"
		GRAPHICS="gimp blender"
		ST_DEPENDENCIES="libx11-dev libxft-dev libxext-dev"
		CCS_STUDIO_DEPENDENCIES="libtinfo5 libpython2.7"
		;;
	2)
		PACKET_MANAGER="dnf"
		DEVELOPMENT="gcc gcc-c++ gfortran gforth gcc-gnat clang \
			     dwarves elfutils gnuradio make cmake golang \
			     openocd octave octave-* clojure qtcreator"
		SCIPY_STACK="python-numpy python-scipy python-matplotlib \
			     ipython python-pandas python-sympy python-nose"
		UTILITIES="vim htop tmux acpi git mc powertop tree screen \
			   firejail gnome-disk-utility neofetch gparted \
			   wireshark transmission rsync flashrom p7zip*"
		SYSTEM="lshw"
		INTERNET="pidgin pidgin-otr midori"
		MEDIA="rhythmbox audacity vlc ffmpeg kid3"
		GRAPHICS="gimp blender"
		ST_DEPENDENCIES="libX11-devel libXft-devel libXext-devel"
		;;
	3)
		PACKET_MANAGER="zypper"
		DEVELOPMENT="gcc gcc-c++ gcc-fortran gcc-ada clang dwarves \
			     elfutils gnuradio make cmake gcc-go openocd ruby \
			     octave octave-* clojure libqt5-creator lua53 \
			     labplot-kf5"
		SCIPY_STACK="python39-numpy python39-scipy python39-matplotlib \
			     python39-ipython python39-pandas python39-sympy \
			     python39-nose"
		UTILITIES="vim htop tmux acpi git mc powertop tree screen \
			   firejail gnome-disk-utility neofetch gparted \
			   wireshark transmission rsync flashrom p7zip* \
			   rxvt-unicode latte-dock vim-plugin-powerline \
			   redshift-gtk fdupes yakuake"
		SYSTEM="lshw"
		INTERNET="pidgin pidgin-otr"
		MEDIA="rhythmbox audacity vlc ffmpeg-4 kid3-qt clementine elisa"
		GRAPHICS="gimp blender"
		ST_DEPENDENCIES="libX11-devel libXft-devel libXext-devel \
				 posix_cc ncurses-devel"
		;;
esac

# Install packages

if [ "$VERSION" -eq 1 ]
then
	echo "Debian system setup start"
	sleep 1
	sudo "$PACKET_MANAGER" update && sudo "$PACKET_MANAGER" dist-upgrade -y
	sudo "$PACKET_MANAGER" install -y $DEVELOPMENT $SCIPY_STACK $UTILITIES \
	      $SYSTEM $INTERNET $MEDIA $GRAPHICS $ST_DEPENDENCIES \
	      $CCS_STUDIO_DEPENDENCIES
elif [ "$VERSION" -eq 2  ]
then
	echo "Fedora system setup start"
	sleep 1
	sudo "$PACKET_MANAGER" update -y
	sudo "$PACKET_MANAGER" install -y $DEVELOPMENT $SCIPY_STACK $UTILITIES \
	      $SYSTEM $INTERNET $MEDIA $GRAPHICS $ST_DEPENDENCIES
elif [ "$VERSION" -eq 3 ]
then
	echo "OpenSuse system setup start"
	sleep 1
	sudo "$PACKET_MANAGER" install -y $DEVELOPMENT $SCIPY_STACK $UTILITIES \
	      $SYSTEM $INTERNET $MEDIA $GRAPHICS $ST_DEPENDENCIES
fi

if [ $? -eq 0 ]
then
	if [ "$VERSION" -eq 1 ]
	then
		sudo mkdir /media/"$USER"/additionalStorage
	fi

	if [ -e /etc/systemd/system/rc-local.service ]
	then
		sudo rm /etc/systemd/system/rc-local.service
	fi

	# Set up vim colourschemes
	echo "Setting up vim colourschemes"
	sleep 1
	tar -xvf gruvbox.tar.bz2
	sudo cp  gruvbox-master/colors/*.vim /usr/share/vim/vim8*/colors

	tar -xvf solarized.tar.gz
	sudo cp solarized/colors/*.vim /usr/share/vim/vim8*/colors

	# Wallpapers
	echo "Placing wallpapers in Pics"
	sleep 1
	tar -xvf Wallpapers.tar.bz2
	mv Wallpapers ~/Pictures

	# Extract and place config files
	echo "Setting up config files"
	sleep 1
	tar -xvf dotfiles.tar.bz2
	cd dotfiles
	if [ "$VERSION" -eq 1 ]
	then
		rm ~/.bashrc
		sudo cp local.conf /etc/fonts/
		cp .bashrc .Xresources .vimrc .tmux.conf .LESS_TERMCAP \
			.gruvbox_256palette.sh ~/
	else
		cp .Xresources .vimrc .tmux.conf .LESS_TERMCAP \
			.gruvbox_256palette.sh ~/
	fi

	if [ "$VERSION" -eq 3 ]
	then
		sudo cp bash.bashrc.local /etc/
	fi

	sudo cp powertop.service /etc/systemd/system/
	sudo cp blacklist.conf /etc/modprobe.d/
	sudo mv st.desktop /usr/share/applications/
	chmod +x ~/.gruvbox_256palette.sh
	cp redshift.conf ~/.config/

	# Compile and install simple terminal
	echo "Compiling and installing simple terminal"
	sleep 1
	cd ..
	if [ "$VERSION" -eq 1 ] || [ "$VERSION" -eq 2 ]
	then
		tar -xvf st-0.8.4.tar.gz
		cd st-0.8.4/
		sudo make clean install
	elif [ "$VERSION" -eq 3 ]
	then
		tar -xvf st-0.8.4_openSuse.tar.gz
		cd st-0.8.4/
		sudo make clean install
	fi

	# Clean up
	echo "Cleaning up"
	sleep 1
	cd ..
	rm -rf dotfiles/ gruvbox-master/ solarized/ st-0.8.4/

	# Place menlo font for use
	echo "Place menlo ttf fonts"
	sleep 1
	tar -xvf Menlo-for-Powerline.tar.gz
	tar -xvf MonacoB-for-Powerline.tar.gz
	sudo mv Menlo-for-Powerline /usr/share/fonts/truetype
	sudo mv MonacoB-for-Powerline /usr/share/fonts/truetype

	# Auto start powertop in systemd
	echo "Enable and start powertop.service"
	sleep 1
	sudo systemctl enable powertop.service
	sudo systemctl start powertop.service
else
	echo "install failed. Check output for more information "
fi
