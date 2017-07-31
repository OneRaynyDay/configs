##### ZSH CONFIGURATIONS #####
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Setting default user information, so powerbar looks nicer.
DEFAULT_USER=dev

# Path to your oh-my-zsh installation.
export ZSH=/Users/dev/.oh-my-zsh

# Set my editor
export EDITOR=vim

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="powerlevel9k/powerlevel9k"

# Display red dots while waiting for completion
COMPLETION_WAITING_DOTS="true"

# For large folders, disable untracked files. This will display [master] instead of [master *]
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# My custom folder for ZSH
ZSH_CUSTOM=/Users/dev/.oh-my-zsh/custom

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git aliases funcs)
source $ZSH/oh-my-zsh.sh
##############################


##### USER CONFIGURATIONS #####
# locale
export LANG=en_US.UTF-8

# zsh's syntax highlighting
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# self-learning cd tool. To use, simply type `z some_folder` and it will suggest.
. $(brew --prefix)/etc/profile.d/z.sh

# bring in the bash export variables
source /Users/dev/.bash_profile
