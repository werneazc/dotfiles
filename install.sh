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
else
    echo "Error: Cannot determine OS."
    exit 1
fi

if [[ $OS_NAME = "opensuse" ]] ; then
    install -m 755 "./bash/bashrc" "$HOME/.bashrc"
    install -m 755 "./bash/profile" "$HOME/.profile"
    install -m 755 "./bash/alias" "$HOME/.alias"
    install -m 755 "./git/gitconfig" "$HOME/.gitconfig"
    install -m 755 "./git/gitignore_global" "$HOME/.gitignore_global"
    install -m 755 "./tmux/tmux.conf" "$HOME/.tmux.conf"

    install -m 755 -d "$HOME/.vim"
    install -m 755 -d "$HOME/.vim/plugged"
    install -m 755 -d "$HOME/.vim/undodir"

    install -m 755 -d "$HOME/.config/nvim"
    install -m 755 "./nvim/init.vim" "$HOME/.config/nvim/init.vim"
fi

exit 0
