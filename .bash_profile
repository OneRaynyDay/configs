# Bash environment is configured here.
# It is also being sourced by .zshrc, since
# anaconda and other applications like to bring
# their environment variables into this location.
echo "~/.bash_profile loaded."

# fc: find content. Supply the following:
# $1 : regex expression(for zsh, should delimit)
# $2 : directory. Default is .
# $3 : including files. Default everything is included.
#  ----------------------------------------------
fc () {
    if [ -z "$1" ]; then
       echo "No arguments inputted."
    elif [ -z "$2" ]; then
        echo "Searching in current dir, and no include flag."
        grep -Iri --exclude-dir=.git "$1" ./
    elif [ -z "$3" ]; then
        echo "Searching with no include flag. In dir $2"
        grep -Iri --exclude-dir=.git "$1" "$2"
    else
        echo "Searching $3 files in dir $2"
        grep -Iri --exclude-dir=.git --include="$3" "$1" "$2" 
    fi
}

# ff: find file. Supply the following:
# $1 : regex expression for file.
# $2 : directory. Default is .
#  ----------------------------------------------
ff () {
    if [ -z "$1" ]; then
        echo "No arguments inputted."
    elif [ -z "$2" ]; then
        echo "Searching in current dir."
        find . -name "$1"
    else
        echo "Searching in dir $2."
        find "$2" -name "$1"
    fi
}

# ls
alias l='ls'
alias la='ls -a'
alias ll='ls -l'
alias lla='ls -la'

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
# added by Anaconda3 4.4.0 installer
export PATH="/Users/dev/anaconda3/bin:$PATH"
