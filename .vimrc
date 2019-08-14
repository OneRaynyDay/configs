" ~~~~~~~~~~~ AUTO-INSTALL PLUG ~~~~~~~~~~
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" ~~~~~~~~~~~~ PLUG ~~~~~~~~~~~~
" Always call this first.
call plug#begin('~/.vim/plugged')

" ~~ Color Scheme Management ~~
" Solarized
Plug 'altercation/vim-colors-solarized'

" Molokai
Plug 'tomasr/molokai' 

" Fugitive for git
Plug 'tpope/vim-fugitive'

" Ack find in vim
Plug 'mileszs/ack.vim'

" NERDTree for file directory traversals
Plug 'scrooloose/nerdtree'
map <Leader>n :NERDTreeToggle<CR>

" Clang autocomplete ~ CURRENTLY DISABLED FOR YCM ~
" Plug 'Rip-Rip/clang_complete'

" Java autocomplete
Plug 'artur-shaik/vim-javacomplete2'

" General autocomplete
Plug 'Valloric/YouCompleteMe'
" Global configs
let g:ycm_global_ycm_extra_conf = '~/.vim/plugged/YouCompleteMe/.ycm_extra_conf.py'
" STFU about the config
let g:ycm_confirm_extra_conf = 0

" Integrated make/dispatch
Plug 'tpope/vim-dispatch'

" NERDCommenter
Plug 'scrooloose/nerdcommenter'

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Make our airline look like powerline
let g:airline_theme='solarized'
let g:airline_solarized_bg='dark'
let g:airline_powerline_fonts = 1
let g:airline#extensions#branch#enabled=1

" Tagbar
Plug 'majutsushi/tagbar'
" NOTE: Due to the incorrect ctag information, we will use one from homebrew:
let g:Tlist_Ctags_Cmd='/usr/local/Cellar/ctags/5.8_1/bin/ctags'
map <Leader>t :TagbarToggle<CR>

" Always call this last.
call plug#end()
" ~~~~~~~~~~ END OF PLUG ~~~~~~~~~~~~

" ~ Colorscheme ~
syntax enable
set background=dark
colorscheme solarized

" ~~ Vim Configurations ~~
set mouse=a
set number

" ~ Indents ~
filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab

" Gets rid of the annoying problem with clipboard copy.
set clipboard=unnamed

" May be for brew vim, but this issue persists:
set backspace=2

" Allow Undos
set undofile                " Save undo's after file closes
set undodir=$HOME/.vim/undo " where to save undo histories
set undolevels=1000         " How many undos
set undoreload=10000        " number of lines to save for undo

" Autocompletion
autocmd FileType java setlocal omnifunc=javacomplete#Complete

" Markdown view library
filetype plugin on
