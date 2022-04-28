 syntax on

set ignorecase
set smartcase
set wildmenu
set wildmode =list:longest
set number
set tabstop=4
set nowrap
set nocompatible

set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'davidhalter/jedi-vim'
Plugin 'cocopon/iceberg.vim'
Plugin 'vim-airline/vim-airline'
call vundle#end()
set background=dark
colorscheme iceberg
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

autocmd FileType python nnoremap <buffer> <F5> :w<cr>:exec '!clear'<cr>:exec '!pytho:command! -bar -bang Q quit<bang>
filetype plugin indent on
~                                                                                   ~                              
