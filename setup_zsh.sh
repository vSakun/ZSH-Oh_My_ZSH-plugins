#!/bin/bash

read -s -p "Enter your password: " pass
#echo -e "\n Is your password really $pass? "
echo $pass >> /dev/null 

os=$(echo $pass | sudo -S cat /etc/os-release | grep 'ID=' | head -n 1 | cut -d '=' -f2)
if [[ $os == 'ubuntu' ]] ; then
	if [ -f "/usr/bin/git*" ] ; then
		echo '<===GIT INSTALL===>'
	else
		echo $pass | sudo -S apt update && echo $pass | sudo -S apt install fonts-powerline git zsh -y
	fi
elif [[ $os == 'linuxmint' ]] ; then
	if [ -f "/usr/bin/git*" ] ; then
		echo '<===GIT and ZSH INSTALL===>'
	else
		echo $pass | sudo -S apt update && echo $pass | sudo -S apt install fonts-powerline git zsh -y
	fi
elif [[ $os == 'kali' ]] ; then
	if [ -f "/usr/bin/git*" ] ; then
		echo '<===GIT and ZSH INSTALL===>'
	else
		echo $pass | sudo -S apt update && echo $pass | sudo -S apt install fonts-powerline git zsh -y
	fi
elif [[ $os == 'fedora' ]] ; then
	if [ -f "/usr/bin/git*" ] ; then
		echo '<===GIT and ZSH INSTALL===>'
	else
		echo $pass | sudo -S dnf update -n && echo $pass | sudo -S dnf install git zsh -y 
	fi
elif [[ $os == 'manjaro' ]] ; then
	if [ -f "/usr/bin/git*" ] ; then
		echo '<===GIT and ZSH INSTALL===>'
	else
		echo $pass | sudo -S pacman -S git zsh -y 
	fi
fi
#read -s -p "Enter your password: "
#echo -e "\n Is your password really $pass? "
if [ -f "/usr/bin/curl" ] ; then
	echo '<===OH-MY-ZSH DOWNLOAD CURL ADN INSTALL===>'
	echo Y | sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
elif [ -f "/usr/bin/wget" ] ; then
	echo '<===OH-MY-ZSH DOWNLOAD WGET ADN INSTALL===>'
	echo Y | sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
else
	if [[ $os == 'ubuntu' || $os == 'linuxmint' || $os == 'kali' ]] ; then
		echo '<===INSTALL CURL DEBIAN===>' 
		echo $pass | sudo -S apt install curl -y
		echo Y | sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
	elif [[ $os == 'fedora' ]] ; then
		echo '<===INSTALL CURL FEDORA===>'
		echo $pass | sudo -S dnf install curl -y 
		echo Y | sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
	fi
fi

echo '<==== install zsh-syntax-highlighting and zsh-autosuggestions ====>'
echo $pass | sudo -S git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

echo $pass | sudo -S git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

sed -i '/ZSH_THEME/s/robbyrussell/agnoster/' ~/.zshrc
sed -i '/plugins/s/git/git\ docker\ docker-compose\ kubectl\ zsh-syntax-highlighting\ zsh-autosuggestions/' ~/.zshrc
echo $pass | sudo -S chsh -s $(which zsh) $USER
source ~/.zshrc
zsh

