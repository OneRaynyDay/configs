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

#  add_config: Supply a file, to a target destination to be pushed
#  into github repo for configurations.
#  USually, $1 can be anything, (directories included)
#  $2 should be /home/configs unless I've changed it
#  ----------------------------------------------
add_config () {
    if [ -z "$2" ]; then
        echo "Not enough arguments. Input file, and directory to add to."
    else
        rsync -rv --exclude=.git $1 $2
        pushd
        cd $2
        git add --all
        git commit -m "Updated config."
        git push
        popd
    fi
}

#  git_commit: Commit with a message. Adds all.
#  ----------------------------------------------
git_commit () {
    if [ -z "$1" ]; then
        echo "Too lazy to add an argument."
        git add .
        git commit -m "Updating files"
        git push
    else
        git add .
        git commit -m "$1"
        git push
    fi
}

#  extract:  Extract most know archives with one command
#  ---------------------------------------------------------
extract () {
    if [ -f $1 ] ; then
      case $1 in
        *.tar.bz2)   tar xjf $1     ;;
        *.tar.gz)    tar xzf $1     ;;
        *.bz2)       bunzip2 $1     ;;
        *.rar)       unrar e $1     ;;
        *.gz)        gunzip $1      ;;
        *.tar)       tar xf $1      ;;
        *.tbz2)      tar xjf $1     ;;
        *.tgz)       tar xzf $1     ;;
        *.zip)       unzip $1       ;;
        *.Z)         uncompress $1  ;;
        *.7z)        7z x $1        ;;
        *)     echo "'$1' cannot be extracted via extract()" ;;
         esac
     else
         echo "'$1' is not a valid file"
     fi
}

#  my_ps: find out what I'm running.
#  $@: any argument you would provide into ps, like -aux
#  ---------------------------------------------------------
my_ps() { ps $@ -u $USER -o pid,%cpu,%mem,start,time,bsdtime,command ; }

