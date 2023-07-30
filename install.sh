#!/bin/bash

#######################################################################################################################
#                                                                                                                     #
#  Run me anywhere with:                                                                                              #
#  TTY=$(tty) bash -c 'curl -sSf https://raw.githubusercontent.com/aiguy110/nvim-config/master/install.sh | bash -s'  #
#                                                                                                                     #
#######################################################################################################################

function install_nvim_bin() {
    INSTALL_ROOT=/opt/nvim-root
    TMP_DIR=/tmp/nvim-setup

    # Setup temp dir
    if [ -e $TMP_DIR ]; then
        rm -rf $TMP_DIR
    fi
    mkdir -p $TMP_DIR
    cd $TMP_DIR

    # Download and extract Appimage
    wget -q --show-progress https://github.com/neovim/neovim/releases/download/stable/nvim.appimage 
    if [ $? -ne 0 ]; then
        echo "Error downloading nvim.appimage. Exiting."
        exit
    fi

    chmod +x nvim.appimage
    ./nvim.appimage --appimage-extract 2>&1 > /dev/null
    sudo -E mv ./squashfs-root $INSTALL_ROOT 

    echo "Downloaded and extacted Appimage squashfs-root to $INSTALL_ROOT"

    # Attempt to symlink into path
    SUCCESS=0
    while read -r PATH_DIR; do
        sudo -E ln -s -T $INSTALL_ROOT/usr/bin/nvim $PATH_DIR/nvim 2>&1 > /dev/null
        if [ $? -eq 0 ]; then
            echo "Successfully symlinked nvim into $PATH_DIR"
            SUCCESS=1
            break
        fi
    done < <(echo $PATH | tr ':' '\n' | grep sbin)

    # If we couldn't symlink into any "sbin" dirs, try "bin" dirs
    if [ $SUCCESS -eq 0 ]; then
         while read -r PATH_DIR; do
            sudo -E ln -s -T $INSTALL_ROOT/usr/bin/nvim $PATH_DIR/nvim 2>&1 > /dev/null
            if [ $? -eq 0 ]; then
                echo "Successfully symlinked nvim into $PATH_DIR"
                SUCCESS=1
                break
            fi
        done < <(echo $PATH | tr ':' '\n' | grep sbin)
    fi

    # Report failure if necessary
    if [ $SUCCESS -eq 0 ]; then
        echo "Failed to symlink $INSTALL_ROOT/usr/bin/nvim into the PATH. You may want to do this manually."
    fi
}

function install_nvim_config() {
    # Check if we can install the custom config
    which git 2>&1 > /dev/null
    if [ $? -ne 0 ]; then 
        echo "git does not appear to be installed. Please install it and run this script again."
        exit
    fi

    # If we're here, we're good to clone the config from github
    if [ ! -e ~/.config ]; then
        mkdir ~/.config
    fi
    cd ~/.config

    # Try cloning via SSH, and prompt for HTTPS clone if that fails
    git clone git@github.com:aiguy110/nvim-config nvim
    if [ $? -ne 0 ]; then
        read -p 'Issue cloning using SSH. Clone using HTTPS? [Yn]' HTTP_CLONE < $TTY
        if [ "$(echo "$HTTP_CLONE" | tr 'A-Z' 'a-z')" != "n" ]; then
            git clone https://github.com/aiguy110/nvim-config nvim
        else
            echo "Aborting. Consider using ssh-add to add a valid SSH key for this account and trying again."
            exit
        fi
    fi

    # Don't ask... just get a fresh install of packer
    PACKER_ROOT="~/.local/share/nvim/pack/packer/start/packer.nvim"
    rm -rf $PACKER_ROOT
    git clone --depth 1 https://github.com/wbthomason/packer.nvim $PACKER_ROOT
}

function install_system_package() {
    PACKAGE=$1

    which apt-get > /dev/null 2>&1
    HAVE_APT=$?

    if [ $HAVE_APT -eq 0 ]; then
        sudo apt-get install $PACKAGE -y < $TTY
    fi
}

# If the "nvim" command is not executable, make it so
which nvim 2>&1 > /dev/null
if [ $? -ne 0 ]; then
    echo "Did not detect nvim binary on PATH. Downloading and installing it..."
    install_nvim_bin
else
    echo "Detected nvim on path. Skipping nvim install."
fi

# Check if we should install the custom config
if [ -e ~/.config/nvim ]; then
    read -p 'It looks like config files alread exist at ~/.config/nvim. Would you like to overwrite them? [yN]' OVERWRITE_CONFIG < $TTY
    if [ "$(echo $OVERWRITE_CONFIG | tr 'A-Z' 'a-z')" != "y" ]; then # Using negative logic intentionally to impliment default
        echo "Will not overwrite config."
    else
        rm -rf ~/.config/nvim
        install_nvim_config
    fi
else
    install_nvim_config
fi

# Install GCC if not installed
which gcc > /dev/null 2>&1
if [ $? -ne 0 ]; then
    read -p 'It looks like gcc is not installed, but it is needed to install TreeSitter. Would you like to install it? [Yn]' INSTALL_GCC < $TTY
    if [ "$(echo "$INSTALL_GCC" | tr 'A-Z' 'a-z')" != "n" ]; then
        install_system_package gcc
    fi
fi

# Install ripgrep if not installed
which rg > /dev/null 2>&1
if [ $? -ne 0 ]; then
    read -p 'It looks like ripgrep (rg) is not installed, but it is needed for the "<leader>ff" command. Would you like to install it? [Yn]' INSTALL_RG < $TTY
    if [ "$(echo "$INSTALL_RG" | tr 'A-Z' 'a-z')" != "n" ]; then
        install_system_package ripgrep
    fi
fi
