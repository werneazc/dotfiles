alias ls="ls -F"
alias ll="ls -lh"
alias la="ls -lah"


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export SYSTEMC_ROOT=/Users/andrewerner/work/tools/systemc

if [[ ! "$PATH" == */Users/andrewerner/work/tools/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/Users/andrewerner/work/tools/bin"
fi

if [[ ! "$PATH" == */opt/homebrew/opt/ccache/libexec* ]]; then
  export PATH="${PATH:+${PATH}:}/opt/homebrew/opt/ccache/libexec"
fi

fpath=(/opt/homebrew/share/zsh/site-functions $fpath)
autoload -Uz compinit
compinit -u


[ -f /opt/homebrew/etc/profile.d/autojump.sh ] && . /opt/homebrew/etc/profile.d/autojump.sh
