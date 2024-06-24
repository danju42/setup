# ##################################################################################################
#     _____ ______ _______ _    _ _____      _____  ______          _____  __  __ ______ 
#    / ____|  ____|__   __| |  | |  __ \    |  __ \|  ____|   /\   |  __ \|  \/  |  ____|
#   | (___ | |__     | |  | |  | | |__) |   | |__) | |__     /  \  | |  | | \  / | |__   
#    \___ \|  __|    | |  | |  | |  ___/    |  _  /|  __|   / /\ \ | |  | | |\/| |  __|  
#    ____) | |____   | |  | |__| | |        | | \ \| |____ / ____ \| |__| | |  | | |____ 
#   |_____/|______|  |_|   \____/|_|        |_|  \_\______/_/    \_\_____/|_|  |_|______|
# 
# 	Written by: Daniel Juarez
# ##################################################################################################

Date created: June 6, 2017
Last edited: August 4, 2023

Hey there! This is my bash script to set up new Linux installations. It started out really
simple. Now look at it! Shadows! Multiple ifs! Nice! Take a look at banner, everyone!
										- daniel

Version 1.0.1
Changelog:	
		* Remove initial powertop.service file and start
		* Add new way to start powertop.service

Version 1.0.2
Changelog:	
		* Add additional programs
		* Change powertop.service file implementation

Version 1.0.3
Changelog:	
		* Fix powertop.service bug
		* Added additional programs to install

Version 1.0.4
Changelog:	
		* Changed name of folder for second hard drive

Version 1.0.5
Changelog:	
		* Added colours to less and man pages with necessary files etc. .LESS_TERMCAP

Version 1.0.6
Changelog:	
		* Changed config files copy method, nothing fancy just made changes in order to
			type less
		* Added blacklist.conf to disable annoying beep in the terminal and in MATLAB

Version 1.0.7
Changelog:	
		* Added another vim colorscheme

Version 1.0.8
Changelog:	
		* Changed name of file.

Version 1.0.9
Changelog:	
		* Removed Xresources and xfce4 colorschemes

Version 1.0.10
Changelog:	
		* Remove and added a few programs to install
		* Updated tmux config file

Version 1.0.11
Changelog:	
		* Fixed the vim colorschemes copying problem
		* Updated tmux config, vim, deleted Xdefaults

Version 1.0.12
Changelog:	
		* Updated: tmux.conf, bashrc, vimrc, Xresources
		* Added menlo font ttf

Version 1.1.13
Changelog:	
		* Added additional programs to install

Version 1.1.14
Changelog:	
		* Added additional programs to install
		* Added simple Terminal desktop entry

Version 1.1.15
Changelog:	
		* Updated python install packages
		* Bug fix

Version 2.0.0
Changelog:	
		* Script updated for use on either debian or fedora systems
		* Arranged packages in categories to install
		* Cool new welcome banner

Version 2.1.0
Changelog:	
		* Script updated for program install failure
		* Updated vim config file
		* Included compile and install simple terminal process

Version 2.2.0
Changelog:	
		* Script updated to include OpenSuse
		* Include different packages for OpenSuse
		* Changed script to accomodate OpenSuse such as st compile stuff
		* Update printf parentheses to double quotes for consistency
		* Included programs for installation

Version 2.2.1
Changelog:	
		* Changed banner. SHADOWS!!! LOOK AT IT'S SHADOWS!!!

Version 2.3.0
Changelog:	
		* Bifurcared setup script into setup script and README file
		* Fixed st dependecies bugs
		* Fixed gruvbox colour bug (changed order of config file placements)
		* Changed name from setupFull.sh to setup.sh
		* Added special bashrc file for OpenSuse

Version 2.3.1
Changelog:	
		* Removed update step for openSuse
		* Created st package for openSuse

Version 2.4.0
Changelog:	
		* Created error handling for invalid entry for which distro to set up

Version 2.4.1
Changelog:	
		* Fixed fonts-cros bug in debian section

Version 2.5.0
Changelog:	
		* Added octave to install package
		* Added sleep intervals for each step of setup
		* Moved updated and upgrade step to before installation of packages

Version 2.5.1
Changelog:	
		* Added Clojure to install package

Version 2.5.2
Changelog:	
		* Added kid3 to media package

Version 2.5.3
Changelog:	
		* Added labplot

Version 2.5.4
Change Date: 2020-01-22
Changelog:	
		* Added a few programs to packages(valgrind, vim-airline,...)
		* Removed shadow banners :( they were resources heavy and too wide. sorry bros
		* Changed vim and Xresources
		* Added different fonts patched for powerline
		* updated simple terminal stuff
		* changed vim install colorschemes

Version 2.5.5
Change Date: 2020-02-21
Changelog:	
		* Added avr(atmega) development stuff
		* Fixed font cleanup stuff

Version 2.5.5
Change Date: 2021-05-18
Changelog:	
		* Changed path in bash from short to long form (again)
		* Removed duplicates in development packs

Version 2.5.5
Change Date: 2021-05-26
Changelog:	
		* Updated simple terminal (default terminal size)

Version 2.5.6
Change Data: 2021-06-01
Changelog:	
		* Fixed bugs in dotfile section setup

Version 2.6
Change Date: 2022-03-01
Changelog:	
		* Reworked applications into packages
		* Corrected variables
		* Different installation methods
		* New applications added in packages

Version 2.6.1
Change Date: 2022-06-09
Changelog:	
		* Fixed OS auto-detect bug (fixed regex)
		* Fixed packages for opensuse install
		* Removed ccs studio dependecies
		* Added more applications to install (Asunder and flac)
		* Fixed array issue (unnecessary quotation marks around variable identifier)
Version 2.6.1
Change Date: 2022-06-11
Changelog:	
		* Fixed OpenSUSE autodetect bug
		* Fixed install packages for OpenSUSE
		* Fixed config file error for OpenSUSE
Version 2.6.2
Change Date: 2023-08-01
Changelog:	
		* Removed obsolete applications
		* Added new apps
		* Added Konsole coloschemes
		* Added Alacritty config files
		* Hopefully fixed dotfiles placement bug
		* Removed laptop setup section
		* Changed banner
Version 2.6.3
Change Date: 2023-08-02
Changelog:	
		* Actually fixed dotfile placement bug
		* Updated cleaning section
		* Fixed vim colorscheme placement bug
		* Updated vim dotfile
		* Updated st spacing issue
		* Removed powertop.service systemctl file
Version 2.6.4
Change Date: 2023-08-04
Changelog:	
		* Removed packages no longer used (xfce-terminal and redshift
		* Removed redshift config file
