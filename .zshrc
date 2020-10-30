##### ZSH CONFIGURATIONS #####
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=/Users/$USER/.oh-my-zsh

# Set my editor
export EDITOR=vim

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="refined"

# Display red dots while waiting for completion
COMPLETION_WAITING_DOTS="true"

# For large folders, disable untracked files. This will display [master] instead of [master *]
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# My custom folder for ZSH
ZSH_CUSTOM=/Users/$USER/.oh-my-zsh/custom

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git z zsh-syntax-highlighting aliases funcs)
##############################


##### USER CONFIGURATIONS #####
# locale
export LANG=en_US.UTF-8

# bring in the bash export variables
source /Users/$USER/.bash_profile

source $ZSH/oh-my-zsh.sh

