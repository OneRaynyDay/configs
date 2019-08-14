# Clean up stuff
function finish {
    popd
}
trap finish EXIT

# Go to root dir
pushd ~

# Create a github key
echo "Before starting, make sure github has the key added"
if [ ! -f "$PWD/.ssh/id_rsa" ] ; then
	ssh-keygen -t rsa -b 4096 -C "peifeng2005@gmail.com"
	echo "Re-run this script again after github has been setup"
	exit 1
else
	echo "Key already exists."
fi

# Update CLI tools for XCode
echo "Checking if xcode CLI is built"
xcode-select --install

# Install homebrew
which -s brew
if [[ $? != 0 ]] ; then
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
	brew update
fi

# Install window managers
echo "Checking skhd..." && brew ls --versions skhd
if [[ $? != 0 ]] ; then
	brew install skhd
else
	echo "Already installed."
fi
echo "Checking chunkwm..." && brew ls --versions chunkwm
if [[ $? != 0 ]] ; then
	brew install chunkwm 
	# Chunkwm requires plugins at this path
	cp -r -i /usr/local/opt/chunkwm/share/chunkwm/plugins ~/.chunkwm_plugins
else
	echo "Already installed."
fi
# Run window manager (may require permissioning)
printf "Run the following to start windows service: \nbrew services start chunkwm \nbrew services start skhd\n"

# Install random good stuff
echo "Installing tons of nice stuff in brew..."
brew install htop cowsay fortune fzf the_silver_searcher

# Install zsh
echo "Checking zsh..." && brew ls --versions zsh
if [[ $? != 0 ]] ; then
	brew install zsh
else
	echo "Already installed."
fi

# Install git
echo "Checking git..." && brew ls --versions zsh
if [[ $? != 0 ]] ; then
	brew install git
else
	echo "Already installed"
fi

# Clone my settings
if [ ! -d "$PWD/home/configs" ] ; then
	mkdir -p ~/home && cd ~/home && git clone git@github.com:OneRaynyDay/configs.git && 
	mv -i configs/.vimrc ~/.vimrc
else
	echo "Already set up configs"
fi


# Lastly ...
# Also install oh-my-zsh
echo "Checking oh-my-zsh"
if [ ! -d "$PWD/.oh-my-zsh" ] ; then
	RUNZSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    # Requires cloning settings to be successful.
    mkdir -p "$PWD/.oh-my-zsh/custom/plugins/funcs" && mv -i $PWD/home/configs/funcs.plugin.zsh ~/.oh-my-zsh/custom/plugins/funcs/funcs.plugin.zsh
    mkdir -p "$PWD/.oh-my-zsh/custom/plugins/aliases" && mv -i $PWD/home/configs/aliases.plugin.zsh ~/.oh-my-zsh/custom/plugins/aliases/aliases.plugin.zsh
else
	echo "Already installed."
fi

printf "Type: \n$ source ~/.zshrc to start running zsh \n$ vim ~/.vimrc to automatically download vim plug and download plugins and inspect vimrc\n"
