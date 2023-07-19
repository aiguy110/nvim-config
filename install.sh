#!/bin/bash

##################################################################################################
#                                                                                                #
#  Run me anywhere with:                                                                                  #
#  curl -sSf https://raw.githubusercontent.com/aiguy110/nvim-config/master/install.sh | bash -s  #
#                                                                                                #
##################################################################################################

function install_nvim_bin() {
    INSTALL_ROOT=/opt/nvim-root

    # Setup temp dir
    mkdir -p /tmp/nvim-setup
    cd /tmp/nvim-setup

    # Download and extract Appimage
    wget https://github.com/neovim/neovim/releases/download/stable/nvim.appimage
    chmod +x nvim.appimage
    ./nvim.appimage --appimage-extract
    mv ./squashfs-root $INSTALL_ROOT 

    echo "Downloaded and extacted Appimage squashfs-root to $INSTALL_ROOT"

    # Attempt to symlink into path
    SUCCESS=0
    echo $PATH | tr ':' '\n' | grep sbin | while read PATH_DIR; do
        ln -T $INSTALL_ROOT/usr/bin/nvim $PATH_DIR/nvim
        if [ $? -eq 0 ]; then
            echo "Successfully symlinked nvim into $PATH_DIR"
            SUCCESS=1
            break
        fi
    done

    # If we couldn't symlink into any "sbin" dirs, try "bin" dirs
    if [ $SUCCESS -eq 0 ]; then
        echo $PATH | tr ':' '\n' | grep sbin | while read PATH_DIR; do
            ln -T $INSTALL_ROOT/usr/bin/nvim $PATH_DIR/nvim
            if [ $? -eq 0 ]; then
                echo "Successfully symlinked nvim into $PATH_DIR"
                SUCCESS=1
                break
            fi
        done
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
fi

