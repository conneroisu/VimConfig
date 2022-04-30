"Conner Ohnesorge Config"


"-----------------------------------------------------Shortcut Declarations End"
            autocmd FileType python map <buffer> <F5> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
                autocmd FileType python imap <buffer> <F5> <esc>:w<CR>:exec '!python3' shellescape(@%, 1)<CR>
                "Makes Shortcut that runs currently buffered python program"

                nnoremap <F3> :e $MYVIMRC<CR>
                "Makes Shortcut to open .vimrc file"

                nnoremap <C-J> <C-W><C-J>
                "Maps Ctrl + J to select window in the downwards direction"

                nnoremap <C-K> <C-W><C-K>
                "Maps Ctrl + K to select window in the upwards direction"

                nnoremap <C-L> <C-W><C-L>
                "Maps Ctrl + L to select window in the right direction"

                nnoremap <C-H> <C-W><C-H>
                "Maps Ctrl + H to select window in the left direction"

                nnoremap <space> za
                "Maps Space to fold shortcut"

                :command! -bar -bang Q quit<bang>
                "Maps :Q to quit because sometimes I am too fast for the shift key"

                :command! -bar -bang W save<bang>! %
                "Maps :W to sace because sometimes I am too fast for the shift key"

                inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
                "Enables wild menu navigation with ctrl + n"

                inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
                "Enables wild menu navigation with ctrl + p"

                inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"
                "Enable automatic closing of the wild menu"
"-----------------------------------------------------Shortcut Declarations End"


"-------------------------------------------------------------------------Rules"
                syntax on
                "Permanently enables syntax highlighting for vim editor"

                set foldmethod=indent
                "Determines kind of folding applied to vim editor"

                set foldlevel=99
                "Sets folds within the open file to be opened if they have less than 99 levels"

                set nowrap
                "Forces Vim to prevent wrapping of text that expands outside terminal view"

                set ignorecase
                "Forces Vim to be case insensitive when searching"

                set smartcase
                "Enables more flexible searching within vim"

                set wildmenu
                "Invokes wildmenu with tab"
                "You can go back and forth with <Tab> and <S-Tab> respectively."

                set wildmode=list:longest:full,full
                "Forces first selection of wildmenu to select the longest"
                "cool feature: :b<Tab>"

                set number
                "Numbers line of opened file"
                "can remove numbers with :set nonu"

                set tabstop=4
                "Forces tab to be defined by the lenght of 4 spaces"
                "^Perfect for python"

                set nocompatible
                "wut"

                set rtp+=~/.vim/bundle/Vundle.vim
                "Load Vundle plugin organizer"

                filetype plugin on
                "It defines autocommands that'll get executed when a file matching a given pattern is opened"

                set autoindent
                "Sets vim to automatically indent following a line containing an indent"

                set backspace=indent,eol,start
                "makes backspace more powerful inresponce to autoindent"

                set clipboard=unnamedplus
                "Setting to allow global clipboard modifications"

                let g:asyncomplete_auto_popup = 0
                "Allows automatic popup from lsp-vim"
"---------------------------------------------------------------------Rules End"


"------------------------------------------------------------------Begin Vundle"
                call vundle#begin()
                "Calls vundle puglin manager"

                Plugin 'gmarik/Vundle.vim'
                "Vundle Plugin Itself"

                Plugin 'cocopon/iceberg.vim'
                "This is my theme"

                Plugin 'vim-airline/vim-airline'
                "This is my status/tabline plugin"

                Plugin 'vim-airline/vim-airline-themes'
                "Themes for vim airline"

                Plugin 'NLKNguyen/copy-cut-paste.vim'
                "Handler for system-wide clipboard"
                "command to allow on ubuntu: sudo apt-get install vim-gtk"
                "To check if option avaliable: vim --version | grep clipboard"

                Plugin 'preservim/nerdtree'
                "File Tree Plugin"

                Plugin 'Raimondi/delimitMate'
                "Vim plugin provides insert mode auto-completion for quotes, parens, brackets, etc. "

                Plugin 'prabirshrestha/vim-lsp'
                "Vim Plugin alowing lsp servers"

                Plugin 'mattn/vim-lsp-settings'
                "Vim Plugin for the settings of vim-lsp"

                Plugin 'prabirshrestha/asyncomplete.vim'
                "Vim Plugin for the completion part of vim-lsp"

                Plugin 'prabirshrestha/asyncomplete-lsp.vim'
                "Vim Plugin for the integration of asyncomplete.vim to vim-lsp.vim"

                Plugin 'beloglazov/vim-online-thesaurus'
                "Vim PLugin to look up words in thesaurus quickly"
                ":OnlineThesaurusCurrentWord or \K"

                call vundle#end()
                "Calls the end of of Vundle PLugin Init stage"
"--------------------------------------------------------------------End Vundle"


"----------------------------------------------------------------Font Set Begin"
                set guifont=DejaVu\ Sans\ Mono:h12
                "Sets font to DejaVu Monospaced size:12"
"------------------------------------------------------------------Font Set End"


"--------------------------------------------------------------Visual Set Begin"
                set background=dark
                "Sets backgroud to dark"
                colorscheme iceberg
                "Applys my theme from the iceberg Vundle Plugin"
                "Shortcut for editing .vimrc"
"--------------------------------------------------------------Visual Set Begin"


"-----------------------------------------------------------------LSP Set Begin"
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
"-------------------------------------------------------------------LSP Set End"
