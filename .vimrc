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

" NERDCommenter
Plug 'scrooloose/nerdcommenter'

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


