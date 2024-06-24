#!/usr/bin/env	bash

printf "######################################################################\n"
printf "#  ______                              ______                        #\n"
printf "# / _____)             _              / _____)      _                #\n"
printf "#( (____  _   _  ___ _| |_ ___ ____  ( (____  ___ _| |_ _   _ ____   #\n"
printf "# \____ \| | | |/___|_   _) _ |    \  \____ \| _ (_   _) | | |  _ \  #\n"
printf "# _____) ) |_| |___ | | |_| __| | | | _____) ) __| | |_| |_| | |_| | #\n"
printf "#(______/ \__  (___/   \__)___)_|_|_|(______/|___)  \__)____/|  __/  #\n"
printf "#        (____/                                              |_|     #\n"
printf "######################################################################\n"

thing=$(awk '/^ID=/' /etc/os-release)
if [[ "$thing" == "ID=debian" ]]; then
	distro="debian"
elif [[ "$thing" == "ID=fedora" ]]; then
	distro="fedora"
elif [[ "$thing" == "ID=\"opensuse-tumbleweed\"" ]]; then
	distro=opensuse
fi

printf "It looks like your target OS is %s. Is this correct?" "$distro"
read -p "(y/n): " correctOS

case "$correctOS" in
	[nN])
		printf "Sorry about that. Lets try another way.\n"
		printf "1. debian\n2. fedora\n3. opensuse\n"
		read -p  "Select: " distro
		distro=$(echo "$distro" | tr '[:upper:]' '[:lower:]')
		while [[ "$distro" != "debian" ]] && [[ "$distro" != "fedora"  ]] && \
		      [[ "$distro" != "opensuse" ]]
		do
			printf "Invalid entry. Please try again\n"
			read -p "Select: " distro
		done
		;;
	[yY])
		;;
	*)
		printf "Invalid entry. Please try again next time.\n"
		exit
		;;
esac

development_packages="gcc clang dwarves elfutils gnuradio openocd ruby octave octave-* make cmake"
utilities_packages="vim htop tmux acpi git mc powertop tree screen firejail rsync neofetch bats \
		    gnome-disk-utility gparted wireshark transmission flashrom shellcheck fdupes \
		    yakuake"
system_packages="lshw alacritty tlp"
internet_packages="pidgin pidgin-otr"
media_packages="rhythmbox audacity vlc ffmpeg kid3 clementine elisa asunder flac k3b"
graphics_packages="gimp blender"
st_dependencies="libx11-dev libxft-dev libxext-dev"

case "$distro" in
	debian)
		development_packages="${development_packages} g++ gfortran gforth gnat wxhexeditor \
				      golang mspdebug gcc-arm-none-eabi gcc-arm-linux-gnueabi \
				      gcc-arm-linux-gnueabihf qtcreator lua5.3 labplot \
				      kcachegrind* gcc-avr avr-libc gdb avrdude* binutils-avr \
				      stlink-* gdb-avr"
		scipy_stack="python3-numpy python3-scipy python3-matplotlib ipython3 \
			     python3-pandas python3-sympy python3-nose"
		utilities_packages="${utilities_packages} ibus-table-latex vim-airline vim-pathogen\
				    vim-youcompleteme fonts-powerline"
		system_packages="${system_packages} firmware-linux fonts-cros* debian-goodies"
		internet_packages="${internet_packages} konversation"
		media_packages="${media_packages} picard"
		;;
	fedora)
		development_packages="${development_packages} gcc-c++ gfortran gforth gcc-gnat \
				      golang qtcreator"
		scipy_stack="python-numpy python-scipy python-matplotlib ipython python-pandas \
			     python-sympy python-nose"
		;;
	opensuse)
		development_packages="${development_packages} gcc-c++ gcc-fortran gcc-ada gcc-go \
			     	      octave octave-* clojure libqt5-creator lua53 labplot-kf5"
		scipy_stack="python39-numpy python39-scipy python39-matplotlib python39-ipython \
			     python39-pandas python39-sympy"
		utilities_packages="${utilities_packages} vim-plugin-powerline"
		st_dependencies="libX11-devel libXft-devel libXext-devel posix_cc ncurses-devel"
		;;
esac

# array of packages
packagesArray=("$development_packages" "$scipy_stack" "$utilities_packages" "$system_packages" \
	  "$internet_packages" "$media_packages" "$graphics_packages" "$st_dependencies")

# Installation errors
err() {
	printf "\nError installing %s\n" "$pkgVars" >> errors.txt
	exit 1
}

# Install packages
case "$distro" in
	debian)
		printf "Debian system_packages setup start\n"
		sleep 1
		sudo apt update && sudo apt dist-upgrade -y
		for pkgVars in "${packagesArray[@]}"; do
			sudo apt install -y $pkgVars || err $pkgVars
		done
		;;
	fedora)
		printf "Fedora system_packages setup start\n"
		sleep 1
		sudo dnf update
		for pkgVars in "${packagesArray[@]}"; do
			sudo dnf install -y $pkgVars || err $pkgVars
		done
		;;
	opensuse)
		printf "OpenSuse system_packages setup start\n"
		sleep 1
		for pkgVars in "${packagesArray[@]}"; do
			sudo zypper install -y $pkgVars || err $pkgVars
		done
	       ;;
esac

# Wallpapers
printf "Placing wallpapers in Pics\n"
sleep 1
tar -xvf Wallpapers.tar.bz2
mv Wallpapers ~/Pictures

# Set up vim colourschemes
printf "Setting up vim colourschemes\n"
sleep 1
tar -xvf vimColorschemes.tar.bz2
sudo cp vimColorschemes/*.vim /usr/share/vim/vim[0-9]*/colors/
cp vimColorschemes/.gruvbox_256palette.sh ~/
chmod +x ~/.gruvbox_256palette.sh

# Set Konsole coloschemes
printf "Placing Gruvbox colorschemes for Konsole terminal emulator"
sleep 1
tar -xvf gruvboxKonsoleColor.tar.bz2
sudo cp gruvboxKonsoleColor/*.colorscheme /usr/share/konsole/

# Set Alacritty config files
printf "Placing Alacritty config files"
sleep 1
tar -xvf alacritty.tar.bz2
mv alacritty  ~/.config

# Extract and place config files
(
printf "Setting up config files\n"
sleep 1
tar -xvf dotfiles.tar.bz2
cd dotfiles || exit
dotfilesA=(.vimrc .tmux.conf .LESS_TERMCAP)
if [[ "$distro" == "debian" ]]; then
	rm ~/.bashrc
	sudo cp local.conf /etc/fonts/
	cp "${dotfilesA[@]}" .bashrc ~/
else
	cp "${dotfilesA[@]}" ~/
fi

if [[ "$distro" == "opensuse" ]]; then
	sudo cp bash.bashrc.local /etc/
fi

sudo cp blacklist.conf /etc/modprobe.d/
sudo mv st.desktop /usr/share/applications/
)

# Compile and install simple terminal
(
printf "Compiling and installing simple terminal\n"
sleep 1
if [[ "$distro" == "opensuse" ]]; then
	tar -xvf st-0.8.4_openSuse.tar.gz
else
	tar -xvf st-0.9.tar.bz2
fi

cd st/ || exit
sudo make install
make clean
)

# Place fonts for use
printf "Place fonts\n"
sleep 1
tar -xvf fonts.tar.bz2 || exit
sudo mv fonts/* /usr/share/fonts/truetype

# Clean up
printf "Cleaning up\n"
sleep 1
rm -rf dotfiles/ vimColorschemes/ fonts/ st/ gruvboxKonsoleColor/

printf "Done!\n"
