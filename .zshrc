# !!! Move this to your home folder if you want to use my settings !!!

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=/Users/nkalman/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="agnoster"

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "powerlevel9k/powerlevel9k" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

###COLORS###

BLACK='\e[0;30m'
BLUE='\e[0;34m'
GREEN='\e[0;32m'
CYAN='\e[0;36m'
RED='\e[0;31m'
PURPLE='\e[0;35m'
BROWN='\e[0;33m'
LIGHTGRAY='\e[0;37m'
DARKGRAY='\e[1;30m'
LIGHTBLUE='\e[1;34m'
LIGHTGREEN='\e[1;32m'
LIGHTCYAN='\e[1;36m'
LIGHTRED='\e[1;31m'
MAGENTA='\e[1;35m'
YELLOW='\e[1;33m'
LIGHTYELLOW='\e[0;33m'
WHITE='\e[1;37m'
NC='\e[0m' # No Color

# push a notification to your phone. can be handy if you're building gws and you want to be notified when it's finished.
# TODO: add two variables (title and body) support
push() {
    curl -s -F "token=<put_your_pushover_token_here" \
    -F "user=<put_your_user_token_here>" \
    -F "title=terminal" \
    -F "message=$1" https://api.pushover.net/1/messages.json > /dev/null 2>&1
}

# extract the given file with the right command.
extract () {
   if [ -f $1 ] ; then
       case $1 in
           *.tar.bz2)   tar xvjf $1    ;;
           *.tar.gz)    tar xvzf $1    ;;
           *.bz2)       bunzip2 $1     ;;
           *.rar)       unrar x $1       ;;
           *.gz)        gunzip $1      ;;
           *.tar)       tar xvf $1     ;;
           *.tbz2)      tar xvjf $1    ;;
           *.tgz)       tar xvzf $1    ;;
           *.zip)       unzip $1       ;;
           *.Z)         uncompress $1  ;;
           *.7z)        7z x $1        ;;
           *)           echo "don't know how to extract '$1'..." ;;
       esac
   else
       echo "'$1' is not a valid file!"
   fi
 }

# CanIUse.com Command Line Search Utility
# Michael Wales, http://github.com/walesmd
#
# A very basic bash function that quickly searches http://caniuse.com/
#
# Examples:
#     caniuse
#     caniuse border-radius
#     caniuse "alpha transparency" counters "canvas drawings" html svg

function caniuse()
{
    local domain="http://caniuse.com/"
    local query

    if [ $# -eq 0 ]; then
        open ${domain}
    else
        for term in "$@"; do
            query=$(python -c "import sys, urllib as ul; print ul.quote('${term}');")
            open "${domain}#search=${query}"
        done
    fi
}

# sha1 username and password (or anything actually)
function sha1()
{
echo -n $1 | sha1sum | awk '{print $1}'
}

# open images as ascii art in terminal (set terminal width as default)
function open_image() {
  term_width=`tput cols`
  if [ -z "$1" ]; then
    echo "${RED}ERROR${NC}: no parameter found"
  elif [[ "$1" == *\.png ]]; then
    curl $1 > pic.png && convert pic.png pic.jpg && jp2a --color --width=$term_width pic.jpg && rm pic.jpg pic.png
  elif [[ "$1" == *\.jpg ]]; then
    jp2a --color --width=$term_width $1
  elif [[ "$1" == *\.gif ]]; then
    curl $1 > pic.gif && convert pic.gif pic.jpg && jp2a --color --width=$term_width pic.jpg && rm pic.jpg pic.gif
  elif [[ "$1" == *\.tif ]]; then
    curl $1 > pic.tif && convert pic.tif pic.jpg && jp2a --color --width=$term_width pic.jpg && rm pic.jpg pic.tif
  else
    echo "${RED}ERROR${NC}: file format is not supported"
  fi
}

function whois() {
  if [ $# -eq 0 ]; then
    echo "${RED}ERROR${NC}: Wrong usage. Pass a username to get his public fullname."
    return 1
  elif [[ $1 =~ ^\@?[A-Za-z0-9]+$ ]]; then
    username=`echo "$1" | sed 's/^\@//'`
      page=`curl -s https://github.com/$username`
      usernameOnPage=`echo "$page" | grep "vcard-username" | sed 's/<\/.*>//' | sed 's/.*>//'`
    if [ -z "$usernameOnPage" ]; then
      echo "${RED}ERROR${NC}: No user with that username found."
      return 1
    else
      fullname=`echo "$page" | grep "vcard-fullname" | sed 's/<\/.*>//' | sed 's/.*>//'`
      email=`echo "$page" | grep "email" | sed 's/.*\">//' | sed 's/<.*//'`
      location=`echo "$page" | grep "homeLocation" | sed 's/.*title=\"//' | sed 's/\".*//'`
      homepage=`echo "$page" | grep "class=\"url\"" | sed 's/.*\">//' | sed 's/<\/.*//'`
      organization=`echo "$page" | grep "organization" | sed 's/.*span>//' | sed 's/<\/.*//'`
      [[ -n "$fullname" ]] && echo "${LIGHTBLUE}$fullname${NC} (${YELLOW}@$usernameOnPage${NC})"
      [[ -z "$fullname" ]] && echo "${YELLOW}@$usernameOnPage${NC}"
      echo "${MAGENTA}===================${NC}"
      [[ -z "$email" ]] && [[ -z "$location" ]] && [[ -z "$homepage" ]] && [[ -z "$organization" ]] && echo "-- ${RED}no info${NC} --"
      # echo -n "✉  "
      [[ -n "$email" ]] && echo "${CYAN}$email${NC}"
      # echo -n "⛳  "
      [[ -n "$location" ]] && echo "${GREEN}$location${NC}"
      # echo -n "⛪  "
      [[ -n "$homepage" ]] && echo "${CYAN}$homepage${NC}"
      # echo -n "⛊  "
      [[ -n "$organization" ]] && echo "${BLUE}$organization${NC}"
      return 0
    fi
  else
    echo "${RED}ERROR${NC}: invalid username"
    return 1
  fi
}

alias htmltoimage='wkhtmltoimage'

# Sort files by Size
alias sortbysize="ls -s | sort -n"

alias github='ghi list -f all -- '

###WELCOME SCREEN###
toilet -f pagga "Hello, $USER"
echo -ne "Today is, "; date
echo;
echo -ne "${BLUE}Sysinfo:";uptime ;
echo;
echo -ne "${NC}"; cal ;
echo -ne "${NC}";
echo -ne "${RED}"; fortune ;
echo -ne "${NC}";
echo;
