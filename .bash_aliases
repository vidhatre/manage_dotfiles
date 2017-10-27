#! /bin/env bash

## Some stuff i needed in the bashrc

# Need java 7 to work 
JAVA_HOME=/usr/lib/jvm/java-1.7.0-openjdk-amd64
PATH=$PATH:$JAVA_HOME/bin
export JAVA_HOME
export PATH

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


#For Altera tools,  Quartus to work
alias altera_setup="source ~/Altera_Licenses/bashrc_addon_altera_quartus"
PATH=$PATH:/home/altera/15.0/modelsim_ase/bin

#For Xilinx tools
alias xilinx_setup=". /home/Xilinx/13.4/ISE_DS/settings64.sh"

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
alias e_bash="vi ~/.bash_aliases"
alias e_ssh="vi ~/.ssh/config"
alias ..="cd .."
alias ...="cd ../.."
cdl() { cd "$1"; ls;}
alias update="sudo apt-get update; sudo apt-get upgrade"

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
function maketar() { tar cvzf "${1%%/}.tar.gz"  "${1%%/}/"; }

# Create a ZIP archive of a file or folder.
function makezip() { zip -r "${1%%/}.zip" "$1" ; }

# Make your directories and files access rights sane.
function sanitize() { chmod -R u=rwX,g=rX,o= "$@" ;}

#fixthis
#function hex2dec { echo "$((16#$1))"; }
#function dec2hex { echo "$((10#$1))";  }

# put stuff in the the clipboard "somecmd | clipin"
alias clipin='xclip -i -selection clipboard'

#git for home dir to manage dot files. use "config" instead of "git" in home dir
alias config='/usr/bin/git --git-dir=/home/vidhatre/.cfg/ --work-tree=/home/vidhatre'

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
  export PATH="/home/vidhatre/miniconda2/bin:$PATH"
  #For CUDA drivers
  export PATH=/usr/local/cuda-8.0/bin${PATH:+:${PATH}}
  export LD_LIBRARY_PATH=/usr/local/cuda-8.0/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
  export CUDA_ROOT=/usr/local/cuda-8.0/bin/ #this is for Theanos
}
setup_ml

