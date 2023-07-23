#!/bin/bash

##################################################################################################
#                                                                                                #
#  Run me anywhere with:                                                                         #
#  curl -sSf https://raw.githubusercontent.com/aiguy110/nvim-config/master/install.sh | bash -s  #
#                                                                                                #
##################################################################################################

function install_nvim_bin() {
    INSTALL_ROOT=/opt/nvim-root
    TMP_DIR=/tmp/nvim-setup

    # Setup temp dir
    if [ -f $TMP_DIR ]; then
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
    mv ./squashfs-root $INSTALL_ROOT 

    echo "Downloaded and extacted Appimage squashfs-root to $INSTALL_ROOT"

    # Attempt to symlink into path
    SUCCESS=0
    while read -r PATH_DIR; do
        ln -s -T $INSTALL_ROOT/usr/bin/nvim $PATH_DIR/nvim 2>&1 > /dev/null
        if [ $? -eq 0 ]; then
            echo "Successfully symlinked nvim into $PATH_DIR"
            SUCCESS=1
            break
        fi
    done < <(echo $PATH | tr ':' '\n' | grep sbin)

    # If we couldn't symlink into any "sbin" dirs, try "bin" dirs
    if [ $SUCCESS -eq 0 ]; then
         while read -r PATH_DIR; do
            ln -s -T $INSTALL_ROOT/usr/bin/nvim $PATH_DIR/nvim 2>&1 > /dev/null
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

# If the "nvim" command is not executable, make it so
which nvim 2>&1 > /dev/null
if [ $? -ne 0 ]; then
    echo "Did not detect nvim binary on PATH. Downloading and installing it..."
    install_nvim_bin
else
    echo "Detected nvim on path. Skipping nvim install."
fi

# Check if we should install the custom config
if [ -f ~/.config/nvim ]; then
    read -p 'It looks like config files alread exist at ~/.config/nvim. Would you like to overwrite them? [yN]' OVERWRITE_CONFIG
    if [ "$(echo $OVERWRITE_CONFIG | tr 'A-Z' 'a-z')" -ne "y" ]; then # Using negative logic intentionally to impliment default
        echo "Will not overwrite config. Exiting."
        exit
    else
        rm -rf ~/.config/nvim
    fi
fi

# Check if we can install the custom config
which git 2>&1 > /dev/null
if [ $? -ne 0 ]; then 
    echo "git does not appear to be installed. Please install it and run this script again."
    exit
fi

# If we're here, we're good to clone the config from github
if [ ! -f ~/.config ]; then
    mkdir ~/.config
fi
cd ~/.config
git clone https://git@github.com/aiguy110/nvim-config nvim
