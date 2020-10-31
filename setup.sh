# Clean up stuff
function finish {
    popd
}
trap finish EXIT

# Check conda version on: https://repo.continuum.io/archive/
CONDA_VERSION="Anaconda3-2020.07-MacOSX-x86_64.sh"
CONDA_ROOT="https://repo.anaconda.com/archive/"

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
    cp $PWD/home/configs/.skhdrc $PWD/.skhdrc
    cp -R $PWD/home/configs/.scripts $PWD/.scripts
else
    echo "Already installed."
fi
echo "Checking yabai..." && brew ls --versions yabai
if [[ $? != 0 ]] ; then
    brew install koekeishiya/formulae/yabai
    cp $PWD/home/configs/.yabairc $PWD/.yabairc
else
    echo "Already installed."
fi
# Run window manager (may require permissioning)
printf "Run the following to start windows service: \nbrew services start yabai \nbrew services start skhd\n"

# Install random good stuff
echo "Installing tons of nice stuff in brew..."
brew install htop cowsay fortune fzf the_silver_searcher vim gcc@8

Install zsh
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
    cp -i configs/.vimrc ~/.vimrc &&
    cp -i configs/.zshrc ~/.zshrc
else
    echo "Already set up configs"
fi


# Also install oh-my-zsh
echo "Checking oh-my-zsh"
if [ ! -d "$PWD/.oh-my-zsh" ] ; then
    RUNZSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    # Requires cloning settings to be successful.
else
    echo "Already installed."
fi

mkdir -p "$PWD/.oh-my-zsh/custom/plugins/funcs" && cp -i $PWD/home/configs/funcs.plugin.zsh ~/.oh-my-zsh/custom/plugins/funcs/funcs.plugin.zsh
mkdir -p "$PWD/.oh-my-zsh/custom/plugins/aliases" && cp -i $PWD/home/configs/aliases.plugin.zsh ~/.oh-my-zsh/custom/plugins/aliases/aliases.plugin.zsh

# Install fish-like syntax highlighting in zsh
if [ ! -d "$PWD/.oh-my-zsh/plugins/zsh-syntax-highlighting" ] ; then
    pushd $PWD/.oh-my-zsh/plugins
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
    popd
else
    echo "Zsh's syntax highlighting is already cloned correctly."
fi

printf "Type: \n$ source ~/.zshrc to start running zsh \n$ vim ~/.vimrc to automatically download vim plug and download plugins and inspect vimrc\n"

which conda
if [[ $? != 0 ]] ; then
    echo "Installing version $CONDA_VERSION from $CONDA_ROOT$CONDA_VERSION"
    curl -O "$CONDA_ROOT$CONDA_VERSION"
    bash $CONDA_VERSION -b -p ~/anaconda
    rm $CONDA_VERSION
    echo 'export PATH=~/anaconda/bin:$PATH' >> ~/.bash_profile
    # This should also source .bash_profile
    source ~/.zshrc
    conda update conda
    conda init zsh
else
    echo "Conda distribution is already installed."
fi
