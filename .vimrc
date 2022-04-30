"Conner Ohnesorge Config"


"Rules"
syntax on
set foldmethod=indent
set foldlevel=99
set nowrap
set ignorecase
set smartcase
set wildmenu
set wildmode =list:longest
set number
set tabstop=4
set nocompatible
set rtp+=~/.vim/bundle/Vundle.vim
filetype plugin on
set omnifunc=syntaxcomplete#Complete






call vundle#begin()
Plugin 'vim-scripts/indentpython.vim'
Plugin 'gmarik/Vundle.vim'
Plugin 'cocopon/iceberg.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'NLKNguyen/copy-cut-paste.vim'
Plugin 'preservim/nerdtree'
Plugin 'Raimondi/delimitMate'
Plugin 'valloric/YouCompleteMe'
Plugin 'prabirshrestha/vim-lsp'
Plugin 'mattn/vim-lsp-settings'
Plugin 'prabirshrestha/asyncomplete.vim'
Plugin 'prabirshrestha/asyncomplete-lsp.vim'
Plugin 'beloglazov/vim-online-thesaurus'
call vundle#end()
set guifont=DejaVu\ Sans\ Mono:h12
set background=dark
colorscheme iceberg
nnoremap <F3> :e $MYVIMRC<CR>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
"folding with spacebar"
nnoremap <space> za
:command! -bar -bang Q quit<bang>
filetype plugin indent on
syntax on
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"

let g:asyncomplete_auto_popup = 0



if executable('pyls')
    " pip install python-language-server
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pyls',
        \ 'cmd': {server_info->['pyls']},
        \ 'allowlist': ['python'],
        \ })
endif

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gs <plug>(lsp-document-symbol-search)
    nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)
    nnoremap <buffer> <expr><c-f> lsp#scroll(+4)
    nnoremap <buffer> <expr><c-d> lsp#scroll(-4)

    let g:lsp_format_sync_timeout = 1000
    autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')

    " refer to doc to add more commands
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END
autocmd FileType python nnoremap <buffer> <F5> :w<cr>:exec '!clear'<cr>:exec '!pytho:command! -bar -bang Q quit<bang>
set clipboard=unnamedplus
