##
## PERSONAL INFORMATION
##

export NAME='Arnout Kazemier'
export EMAIL='info@3rd-Eden.com'

##
## COLORING & THEMES
##

export ZSH_THEME='3rdEden'
zstyle -e ':completion:*:default' list-colors 'reply=("${PREFIX:+=(#bi)($PREFIX:t)(?)*==34=34}:${(s.:.)LS_COLORS}")'

##
## HISTORY
##

export HISTFILE='~/.zsh_history'
export HISTFILESIZE=65536
export HISTSIZE=4096
export SAVEHIST=$HISTSIZE

##
## ALIASES & APPLICATION DEFAULTS
##

#ls
alias ls='ls --color=auto --group-directories-first --classify --human-readable'
alias ll='ls --color=auto --group-directories-first --classify --human-readable -l'
alias la='ls --color=auto --group-directories-first --classify --human-readable -l --almost-all'

# cp/mv/rm
alias cp='nocorrect cp -i'
alias mv='nocorrect mv -i'
alias rm='nocorrect rm -i'

export EDITOR=vim
export GREP_OPTIONS='--color=auto --exclude="*.pyc" --exclude-dir=".svn" --exclude-dir=".hg" --exclude-dir=".bzr" --exclude-dir=".git"'

##
## OH MY ZSH CONFIGURATIONS
##

ZSH=$HOME/.oh-my-zsh
DISABLE_AUTO_UPDATE="true"
plugins=(git github node npm osx)
source $ZSH/oh-my-zsh.sh

##
## Open in Sublime
##
alias sub='/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl'

##
## Mirrors of the npm registries
##
alias enpm='npm --registry http://registry.npmjs.eu'
alias npmjitsu='npm --registry https://us.registry.nodejitsu.com'

##
## PATH
##
export PATH=/usr/local/bin:/usr/local/sbin:/opt/bin:/opt/local/bin:/opt/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin:$PATH

##
## Load NVM, should be done after PATH changes
## 
[[ -s /Users/akazemier/.nvm/nvm.sh ]] && . /Users/akazemier/.nvm/nvm.sh
nvm use v0.10
