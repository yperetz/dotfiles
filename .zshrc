# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
PATH="/usr/local/itksnap-3.8.0-20190612-Linux-gcc64/bin:/usr/local/pycharm-community-2020.2.3/bin:$HOME/.cargo/bin${PATH:+:${PATH}}:$HOME/Documents/scripts:$HOME/Applications"
# Path to your oh-my-zsh installation.
export ZSH="/home/yp/.oh-my-zsh"
export XDG_CONFIG_HOME="/home/yp/.config"


# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="agnoster"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="dd.mm.yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    git
    bundler
    last-working-dir
    web-search
    extract
    sudo
    z
    zsh-syntax-highlighting
    zsh-autosuggestions
    web-search
)


source $ZSH/oh-my-zsh.sh
export TERM=xterm-256color
# User configuration
#source ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
setopt correct
set -o vi
bindkey -v

source /usr/share/doc/fzf/examples/completion.zsh
source /usr/share/doc/fzf/examples/key-bindings.zsh
# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
else
  export EDITOR='nvim'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

zstyle ':completion:*' special-dirs true

alias vim='nvim'
alias update="source ~/.zshrc"
alias zshrc="nvim ~/.zshrc"
alias bat="batcat"

# git alias
alias glog="git log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --branches"

# show my ip
alias myip="curl http://ipecho.net/plain; echo"
# rotate screen
alias rot2="xrandr --output DP-3 --rotate"
alias rot1="xrandr --output DP-1 --rotate"

alias sp="spotifycli"
alias storage='du -h -d1'

export EDITOR=vim
export VISUAL=vim
export PATH
export HISTCONTROL=ignoreboth

# alias config='/usr/bin/git --git-dir=/home/yp/.cfg/ --work-tree=/home/yp'
alias rc='vim $HOME/.zshrc'
alias lyrics="clear && spotifycli --song && spotifycli --artist && spotifycli --album && echo "________________________" && lyrics-cli spotify"
alias dotf='/usr/bin/git --git-dir=/home/yp/.dotfiles/ --work-tree=/home/yp'
alias dflog='/usr/bin/git --git-dir=/home/yp/.dotfiles/ --work-tree=/home/yp log --graph --oneline'
alias ddl='sps=$(spotifycli --song) ; ddg  "${sps} lyrics"'

alias venv-new="/home/yp/Documents/scripts/new-venv"
alias venv-activate="source venv/bin/activate"
#alias python="/usr/bin/python3"
#alias pip="/usr/bin/pip3"
alias aptls="aptitude search '~i!~M' | fzf"
alias allmd2pdf="$HOME/Documents/scripts/md-convert-all.sh"
alias allmd2pdf-onefile="$HOME/Documents/scripts/md-convert-all-onefile.sh"
alias open="xdg-open"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/yp/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/yp/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/yp/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/yp/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# handle multiple screens
alias ls='exa -al --color=always --group-directories-first'
if [[ -z $SECONDARY ]]; then
  neofetch
elif [ $SECONDARY -eq 1 ]; then
  date +"%d/%m/%Y" | figlet -f digital && date +"WW: %U" | figlet -f digital && cal -B 1 -A 4
elif [ $SECONDARY -eq 2 ]; then
  df -h | grep -v loop | grep -v tmpfs && echo "---------------------------" && lsblk -a | grep -v loop && conda activate scientificProject && cd $HOME/PycharmProjects/scientificProject
fi

alias sc="source $HOME/.zshrc"

PATH="/home/yp/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/yp/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/yp/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/yp/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/yp/perl5"; export PERL_MM_OPT;
