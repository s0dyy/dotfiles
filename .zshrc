#--------------#
#   SETTINGS   #
#--------------#

mkdir -p ${HOME}/.zsh

# Auto ls
setopt auto_cd

function chpwd() {
  emulate -L zsh
  exa -lagF --sort type --time-style iso
}

autoload -Uz compinit -d ${HOME}/.zsh/zcompdump
compinit -d ${HOME}/.zsh/zcompdump

# Case sensitive
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# Zsh history
setopt histignoredups
setopt share_history
HISTFILE=~/.zsh/zsh_history
HISTSIZE=20000 
SAVEHIST=20000

#--------------#
#    PROMPT    # 
#--------------#

setopt prompt_subst
autoload -U colors && colors

export STARSHIP_CONFIG=~/.starship.toml
eval "$(starship init zsh)"

#---------------------#
#     EXPORT/PATH     #
#---------------------#

export TERM=xterm-256color
export EDITOR=vim
export KEYTIMEOUT=50
#export GEM_HOME=$(ls -t -U | ruby -e 'puts Gem.user_dir')
#export GEM_PATH=${GEM_HOME}
export LESSHISTSIZE=0
export HTOPRC=~/.htoprc

composer="${HOME}/.config/composer/vendor/bin"
fzf="${HOME}/.fzf/bin"
#gem="${GEM_HOME}/bin"
npm="${HOME}/.npm-packages/bin"
pip="${HOME}/.local/bin"
pulsar="${HOME}/Documents/binaries/apache-pulsar-2.7.0/bin"
scripts="/home/s0dyy/Documents/github/dotfiles/shellscripts"
flatpak="/var/lib/flatpak/exports/bin"

#export PATH=${PATH}:${composer}:${fzf}:${gem}:${npm}:${pip}:${pulsar}:${scripts}:${flatpak}
export PATH=${PATH}:${composer}:${fzf}:${npm}:${pip}:${pulsar}:${scripts}:${flatpak}

#--------------#
#      MAP     #
#--------------#

# Escape jj 
bindkey jj vi-cmd-mode
bindkey "^?" backward-delete-char

#--------------#
#    ALIAS     #
#--------------#

# Exherbo
alias caco="cave contents"
alias cafc="cave fix-cache"
alias cafl="cave fix-linkage"
alias caflx="cave fix-linkage -x"
alias capu="cave purge"
alias capux="cave purge -x"
alias care="cave resolve --suggestions ignore"
alias carew="cave resolve world -c --suggestions ignore"
alias carewx="cave resolve world -cx --suggestions ignore --skip-phase test"
alias carex="cave resolve -x --suggestions ignore"
alias cash="cave show --one-version --flat" 
alias cashf="cave show --one-version" 
alias casy="cave sync"
alias casyl="cave sync -s local"
alias caun="cave uninstall"
alias caunx="cave uninstall -x"
alias caunxa="cave uninstall -x --all-versions"
alias epo="vim /etc/paludis/options.conf"

# Exa
alias ll1="exa -a1F --sort type"
alias ll1t="exa -a1TF --sort type"
alias ll="exa -lgF --sort type --time-style long-iso"
alias lla="exa -lagF --sort type --time-style long-iso"
alias llag="exa -lagF --git --sort type --time-style long-iso"
alias llat="exa -lagTF --sort type --time-style long-iso"

# Paths
alias ccd="cd ${HOME}/Documents/clevercloud-dev"
alias ccp="cd ${HOME}/Documents/clevercloud-prod"
alias doc="cd ${HOME}/Documents"
alias dot="cd ${HOME}/Documents/github/dotfiles"
alias dow="cd ${HOME}/Downloads"
alias gh="cd ${HOME}/Documents/github"
alias gl="cd ${HOME}/Documents/gitlab"
alias glc="cd ${HOME}/Documents/gitlab-clevercloud"
alias gle="cd ${HOME}/Documents/gitlab-exherbo"
alias pic="cd ${HOME}/Pictures"
alias var="cd ${HOME}/Documents/various"

# Misc
alias cc="clear"
alias rr="su -"
alias zz="source ${HOME}/.zshrc"
alias sysu="systemctl suspend"
#alias grep="rg"
alias cat="bat"
alias tt="tmux new -s 'TMUX #${number}'"

# Send to clipboard
function ccat() {
  cat ${1} | wl-copy
}

# Sprunge: command line pastebin
function sprunge() {
  cat ${1} | curl -F "sprunge=<-" http://sprunge.us
}

# Screenshot
function screen() {
  grim -g "$(slurp)" ${HOME}/Pictures/screenshots/$(date +'%Y-%m-%d-%H%M%S.png')
}

# Last paludis build
function lbu() {
  build="/var/tmp/paludis/build"
  cd "${build}/$(ls -t ${build} | head -1)"
}

# Sway
function ssw() {
  if [ ${HOSTNAME} = laptop ]; then
    GDK_SCALE=2 exec sway
  else
    exec sway
  fi
}

#-----#
# SSH #
#-----#

if [ -z "$SSH_AUTH_SOCK" ] ; then
  eval "$(ssh-agent -s)" > /dev/null 2>&1
fi

#-----#
# BAT #
#-----#

export BAT_CONFIG_PATH="${HOME}/.bat"

#-----#
# FZF #
#-----#

# Download and install
if [[ ! -d ~/.fzf ]]; then
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ${HOME}/.fzf/./install --64 --no-bash --no-fish --no-update-rc --completion --key-bindings --xdg
fi

# Auto-completion
[[ $- == *i* ]] && source "$HOME/.fzf/shell/completion.zsh" 2> /dev/null

# Color theme
# No color
export FZF_DEFAULT_OPTS="--color=bw"

# Key bindings
source "$HOME/.fzf/shell/key-bindings.zsh"

# Ctrl-p map (cd folder)
eval bindkey '^p' fzf-file-widget

#------#
# TMUX #
#------#

# Do not run tmux in console mode
#if [[ ! -z $DISPLAY ]]; then
  # Start tmux automatically and close term after exit tmux (stackoverflow)
  #if [ -t 0 ] && [[ -z $TMUX ]] && [[ $- = *i* ]] && [[ ! "$USERNAME" = root ]]; then
    #number=$(shuf -i 1000-9999 -n 1)
    #exec tmux new -s "TMUX #${number}"
  #fi
#fi

#------#
# SWAY #
#------#

if [ "$XDG_SESSION_DESKTOP" = "sway" ] ; then
  # https://github.com/swaywm/sway/issues/595
  export _JAVA_AWT_WM_NONREPARENTING=1
fi

#---------------#
# MAN SELENIZED #
#---------------#

if [ "$OSTYPE[0,7]" = "solaris" ]
then
    if [ ! -x ${HOME}/bin/nroff ]
    then
        mkdir -p ${HOME}/bin
        cat > ${HOME}/bin/nroff <<EOF
#!/bin/sh
if [ -n "\$_NROFF_U" -a "\$1,\$2,\$3" = "-u0,-Tlp,-man" ]; then
    shift
    exec /usr/bin/nroff -u\${_NROFF_U} "\$@"
fi
#-- Some other invocation of nroff
exec /usr/bin/nroff "\$@"
EOF
chmod +x ${HOME}/bin/nroff
        fi
fi

function man() {
    env \
        LESS_TERMCAP_mb=$(printf "\e[1;34m") \
        LESS_TERMCAP_md=$(printf "\e[1;34m") \
        LESS_TERMCAP_me=$(printf "\e[0m") \
        LESS_TERMCAP_se=$(printf "\e[0m") \
        LESS_TERMCAP_so=$(printf "\e[30;39;100m") \
        LESS_TERMCAP_ue=$(printf "\e[0m") \
        LESS_TERMCAP_us=$(printf "\e[4;36m") \
        PAGER="${commands[less]:-$PAGER}" \
        _NROFF_U=1 \
        GROFF_NO_SGR=1 \
        PATH=${HOME}/bin:${PATH} \
    man "$@"
}

