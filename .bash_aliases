#! /bin/env bash

## Some stuff i needed in the bashrc

# Need java 7 to work 
#JAVA_HOME=/usr/lib/jvm/java-1.7.0-openjdk-amd64
#JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64
#PATH=$PATH:$JAVA_HOME/bin
#export JAVA_HOME
#export PATH

#Hadoop home
export HADOOP_HOME=/opt/hadoop-2.7.3

#Gorilla home 
export GORILLA_HOME=~/projects/axstreamBE/GorillaPP/

#Shorten working dir in prompt display
PROMPT_DIRTRIM=2

#Single tab auto-complete
set show-all-if-ambiguous on
#Case insensitivity (tab completion)
#set completion-ignore-case on
#insensitivity to underscores nad hyphens (tab completion)
#set completion-map-case on

#bash with vi mode. cheatsheet in ~/howto/bash-vi-editing-mode-cheat-sheet.txt
set -o vi
#get back shortcuts from readline mode
bind -m vi-command ".":insert-last-argument
bind -m vi-insert "\C-l.":clear-screen
bind -m vi-insert "\C-a.":beginning-of-line
bind -m vi-insert "\C-e.":end-of-line
bind -m vi-insert "\C-w.":backward-kill-word

#For Altera tools,  Quartus to work
alias altera_setup="source ~/Altera_Licenses/bashrc_addon_altera_quartus"
PATH=$PATH:/home/altera/15.0/modelsim_ase/bin

#For Xilinx tools
alias xilinx_setup=". /home/Xilinx/13.4/ISE_DS/settings64.sh"

#tmux tab completion
source ~/.bash/tmux.completion.bash

#Get the full path of a file
#TODO also paste it in the clipboard to save a click
alias fpath="readlink -f"

#set CDPATH
export CDPATH=.:~
#shortcuts to dirs
alias be='cd ~/projects/axstreamBE/'
alias bega='cd ~/projects/axstreamBE/GorillaPP/apps'
alias riffa='cd ~/projects/axstreamRIFFA'

#other commands
alias ebash="vi ~/.bash_aliases"
alias evim="vi ~/.vimrc"
alias essh="vi ~/.ssh/config"
alias etmux="vi ~/.tmux.conf"
alias ..="cd .."
alias ...="cd ../.."
cdl() { cd "$1"; ls;}
alias update="sudo apt-get update; sudo apt-get upgrade"
alias ipy="ipython"

# Handy Extract Program
function extract()
{
    if [ -f $1 ] ; then
	case $1 in
	    *.tar.bz2)   tar xvjf   $1   ;;
	    *.tar.gz)    tar xvzf   $1   ;;
	    *.bz2)       bunzip2    $1   ;;
	    *.rar)       unrar x    $1   ;;
	    *.gz)        gunzip     $1   ;;
	    *.tar)       tar xvf    $1   ;;
	    *.tbz2)      tar xvjf   $1   ;;
	    *.tgz)       tar xvzf   $1   ;;
	    *.zip)       unzip      $1   ;;
	    *.Z)         uncompress $1   ;;
	    *.7z)        7z x       $1   ;;
	    *)           echo "'$1' cannot be extracted via >extract<" ;;
	esac
    else
	echo "'$1' is not a valid file!"
    fi
}


# Creates an archive (*.tar.gz) from given directory.
function mktar() { tar cvzf "${1%%/}.tar.gz"  "${1%%/}/"; }

# Create a ZIP archive of a file or folder.
function makezip() { zip -r "${1%%/}.zip" "$1" ; }

# Make your directories and files access rights sane.
function sanitize() { chmod -R u=rwX,g=rX,o= "$@" ;}

#fixthis
function h2d { echo "$((16#$1))"; }
function d2h { printf '%X\n' $1;  }

# automatically open files with the right program
alias xopen="xdg-open"

# put stuff in the the clipboard "somecmd | clipin"
alias vclip='xclip -i -selection clipboard'

#git for home dir to manage dot files. use "config" instead of "git" in home dir
alias config='/usr/bin/git --git-dir=/home/vidhatre/.cfg/ --work-tree=/home/vidhatre'

#Calling IPython from a virtualenv
alias ipy="python -c 'import IPython; IPython.terminal.ipapp.launch_new_instance()'"

#Edit CDPATH for working project. Dont want to modify on defaul so alias 
#alias set_cd='export CDPATH=.:~:/home/vidhatre/projects/axstreamBE/GorillaPP/apps/sLinearRegression'
function setcd() { export CDPATH=.:~:$PWD; echo "export CDPATH=.:~:$PWD"; }
function tst() { 
  if [ $1 = "json" ] 
  then 
      echo "set_json: axstreamBE/GorillaPP/apps/jsonRiffaPipeNoToken";
      export CDPATH=.:~:~/projects/axstreamBE/GorillaPP/apps/jsonRiffaPipeNoToken;
  elif [ $1 = "kafka" ]
  then
      echo "set_kafka: be1/GorillaPP/apps/riscVGenPipewithKafka;";
      export CDPATH=.:~:~/projects/be1/GorillaPP/apps/riscVGenPipewithKafka;
  elif [ $1 = "slr" ] 
  then 
      echo "set_slr: not done yet";
  fi 
}

setup_ml () {
  # added for Miniconda2 installer
  #export PATH="/home/vidhatre/miniconda2/bin:$PATH"
  #For CUDA drivers
  export PATH=/usr/local/cuda-8.0/bin${PATH:+:${PATH}}
  export LD_LIBRARY_PATH=/usr/local/cuda-8.0/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
  export CUDA_ROOT=/usr/local/cuda-8.0/bin/ #this is for Theanos
}
setup_ml

#Git command to remove local branches that were deleted in remote
#make into a function? split into two parts show the branches and then confirm delete
#alias gitclb="git fetch -p && for branch in `git branch -vv | grep ': gone]' | awk '{print $1}'`; do git branch -D $branch; done"
gitclb () {
  git fetch -p && for branch in $(git branch -vv | grep ': gone]' | awk '{print $1}'); do git branch -D $branch; done
}

## IF in tmux let fzf know for tmux split panes
[ -z "$TMUX" ] && export FZF_TMUX=1


## NEEDS to happen last
#installing pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
