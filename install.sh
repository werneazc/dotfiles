#!/bin/bash

# =============================================================================
# Install dotfiles
# =============================================================================

# =============================================================================
# Get OS name for OS specific configurations
# =============================================================================
if [ -s "/etc/os-release" ] ; then
    OS_NAME="$(grep -o -m 1 "openSUSE" "/etc/os-release")"
    OS_NAME=${OS_NAME,,}
elif [ $(uname) == "Darwin" ] ;then
    OS_NAME="mac"
else
    echo "Error: Cannot determine OS."
    exit 1
fi

if [[ $OS_NAME == "mac" ]] ; then
    install -m 755 "./mac/zshrc" "$HOME/.zshrc"
    install -m 755 "./mac/profile" "$HOME/.zprofile"

    install -m 755 "./git/gitconfig" "$HOME/.gitconfig"
    install -m 755 "./git/gitignore_global" "$HOME/.gitignore_global"

    install -m 755 -d "$HOME/.config/nvim"
    install -m 755 "./nvim/init.vim" "$HOME/.config/nvim/init.vim"
    install -m 755 "./nvim/coc-settings.json" "$HOME/.config/nvim/coc-settings.json"

    install -m 755 -d "$HOME/.config/lsd"
    install -m 755 "./lsd/config.yml" "$HOME/.config/lsd/config.yml"
fi

exit 0
