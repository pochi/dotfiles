##################################################
# shell variables

# history
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

# report time
REPORTTIME=3

# prompt
function precmd_vcs() {
    vcs_info
    RPROMPT=$'%{\e[32m%}%~'${vcs_info_msg_0_}$'%{\e[m%}'
}
PROMPT=$'%{\e[31m%}%n %{\e[33m%}%* %# %{\e[m%}'

# special functions
precmd_functions=(precmd_vcs)

function redrev() {
    perl -pe 's/^/\e[41m/ && s/$/\e[m/';
}


##################################################
# aliases

alias sl=ls
case "$OSTYPE" in
    darwin*)
        alias ls="LSCOLORS=gxfxxxxxcxxxxxxxxxxxxx ls -G"
        ;;
    linux*)
        alias ls="ls --color=auto"
        ;;
esac
alias ll="ls -l"
alias la="ll -a"
alias em="emacs-minimum"

alias gi=git
alias ga="git add"
alias gd="git diff"
alias gl="git log"
alias gs="git status"
alias gsh="git show"
alias gpl="git pull"
alias gps="git push"
alias gci="git commit"
alias gco="git checkout"
alias gcp="git cherry-pick"
alias gsd="git svn dcommit"
alias gsr="git svn rebase"
alias gst="git stash"
alias gsp="git stash pop"

alias pad='plackup -MPlack::App::Directory -e '\''$app = Plack::App::Directory->new({ root => "." })->to_app'\'''

alias -g RED='2> >(redrev)'

##################################################
# others

# key binds
bindkey '^R' history-incremental-pattern-search-backward
bindkey '^S' history-incremental-pattern-search-forward

# options
setopt autocd
setopt autopushd
setopt pushdignoredups

# completion
autoload -Uz compinit
compinit

zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format '%B--- %d ---%b'

zstyle ':completion:*' menu select
zstyle ':completion:*:default' list-colors ln=35 di=36

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

zstyle ':completion:*:kill:*:processes' command 'ps x'
zstyle ':completion:*:-command-:*' \
    fake-parameters PERL5LIB # for perl

## git completion
if [ -e $HOME/.git-completion.sh ]; then
    source $HOME/.git-completion.sh
fi

# vcs
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git svn
zstyle ':vcs_info:*' formats $'%{\e[35m%} [%s %r %b]%{\e[m%}'

# word-style
autoload -Uz select-word-style
select-word-style default
zstyle ':zle:*' word-chars " _-./;:@"
zstyle ':zle:*' word-style unspecified

export GROOVY_HOME=/usr/local/Cellar/groovy/2.0.4/libexec
export GRADLE_HOME=/usr/local/Cellar/gradle/1.2/libexec
export PATH=/usr/local/Cellar/glassfish/3.1.2/bin:/usr/local/Cellar/groovy/2.0.4/bin:/usr/local/Cellar/bazaar/2.5.1/bin:/usr/local/Cellar/ruby/1.9.3-p194/bin:/usr/local/Cellar/scala/2.9.1/bin/:/usr/local/Cellar/gradle/1.2/bin/:$PATH
alias g=git
alias gd='cd /usr/local/Cellar/ruby/1.9.3-p194/lib/ruby/gems/1.9.1/gems/'
alias be='bundle exec'
alias bi='bundle install'
set JAVA_OPTS=-Dgroovy.source.encoding=UTF-8 -Dfile.encoding=UTF-8
export PATH=/usr/local/share/npm/bin:$PATH
export NODE_PATH=/usr/local/share/npm/lib/node_modules:/usr/local/Cellar/node/0.8.12//lib/node_modules:/usr/local/Cellar/node/0.8.12//lib/node_modules/npm/node_modules

#export PATH="$HOME/.rbenv/bin:$PATH"
#eval "$(rbenv init -)"

