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
    return 1
fi

if [[ $OS_NAME = "opensuse" ]] ; then
    install -m 755 "./bash/bashrc" "$HOME/.bashrc"
    install -m 755 "./bash/profile" "$HOME/.profile"
    install -m 755 "./bash/alias" "$HOME/.alias"
    install -m 755 "./git/gitconfig" "$HOME/.gitconfig"
    install -m 755 "./git/gitignore_global" "$HOME/.gitignore_global"
fi

return 0
