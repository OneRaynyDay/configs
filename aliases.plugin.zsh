# My aliases and functions
# to access these customs:
alias zsh_configs='~/.oh-my-zsh/custom/'

# ls
alias l='ls'
alias la='ls -a'
alias ll='ls -l'
alias lla='ls -la'

# easy way to edit .zshrc
alias zshrc='$EDITOR ~/.zshrc' # Quick access to the ~/.zshrc file

# whereami
alias whereami='echo $PWD'

# grep
alias grep='grep --color'
alias sgrep='grep -R -n -H -C 5 --exclude-dir={.git,.svn,CVS} '

# To be safe
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# System information
alias mem_hogs='top -l 1 -o rsize | head -20'
alias cpu_hogs='ps wwaxr -o pid,stat,%cpu,time,command | head -10'

# Make zsh know about hosts already accessed by SSH
zstyle -e ':completion:*:(ssh|scp|sftp|rsh|rsync):hosts' hosts 'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'

# Cleans up .DS_Store files.
alias cleanup_ds="find . -type f -name '*.DS_Store' -ls -delete"

# Run screensaver.
alias screen_saver='/System/Library/Frameworks/ScreenSaver.framework/Resources/ScreenSaverEngine.app/Contents/MacOS/ScreenSaverEngine -background'

# Start jekyll blog server
# NOTE: Have to be in the correct path first
alias blog_view='bundle exec jekyll serve'

# View stuff on chrome.
alias chrome="open -a 'Google Chrome'"
alias pdf="open -a 'Preview'"

# Enter mysql. 
# NOTE: As root.
alias start_mysql='brew services start mysql && mysql -u root -p'

# ~~ My paths ~~
alias home='cd ~/home/'
