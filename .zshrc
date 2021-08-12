#--------------#
#   SETTINGS   #
#--------------#

mkdir -p ${HOME}/.zsh

# Auto ls
setopt auto_cd

function chpwd() {
	emulate -L zsh
	exa -lagF --sort type --time-style iso --icons --git
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
export GEM_HOME=$(ls -t -U | ruby -e 'puts Gem.user_dir')
#export GEM_PATH=${GEM_HOME}
export LESSHISTSIZE=0
export HTOPRC=~/.htoprc
#export XDG_DATA_DIRS="/var/lib/flatpak/exports/share:/home/s0dyy/.local/share/flatpak/exports/share:/usr/share:/usr/local/share"

composer="${HOME}/.config/composer/vendor/bin"
fzf="${HOME}/.fzf/bin"
gem="${GEM_HOME}/bin"
npm="${HOME}/.npm-packages/bin"
pip="${HOME}/.local/bin"
pulsar="${HOME}/Documents/binaries/apache-pulsar-2.7.0/bin"
scripts="/home/s0dyy/Documents/github/dotfiles/shellscripts"
flatpak="/var/lib/flatpak/exports/bin"

#export PATH=${PATH}:${composer}:${fzf}:${gem}:${npm}:${pip}:${pulsar}:${scripts}:${flatpak}
export PATH=${PATH}:${composer}:${fzf}:${gem}:${npm}:${pip}:${pulsar}:${scripts}:${flatpak}

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
alias ll1="exa -a1F --sort type --icons"
alias ll1t="exa -a1TF --sort type --icons"
alias ll="exa -lgF --sort type --time-style long-iso --icons"
alias lla="exa -lagF --sort type --time-style long-iso --icons"
alias llag="exa -lagF --git --sort type --time-style long-iso --icons"
alias llat="exa -lagTF --sort type --time-style long-iso --icons"

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
alias cat="bat -p"
alias fd="fd -H -i -L"
#alias vim="nvim"

# Send to clipboard
function ccat() {
	cat ${1} | wl-copy
}

# Sprunge: command line pastebin
function sprunge() {
	cat ${1} | curl -F "sprunge=<-" http://sprunge.us
}

# Last paludis build
function lbu() {
	build="/var/tmp/paludis/build"
	cd "${build}/$(ls -t ${build} | head -1)"
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
if [[ ! -z $DISPLAY ]]; then
	# Start tmux automatically and close term after exit tmux
	if [ -t 0 ] && [[ -z $TMUX ]] && [[ $- = *i* ]] && [[ ! "$USERNAME" = root ]]; then
		exec tmux
	fi
fi
