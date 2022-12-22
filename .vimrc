" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif


call plug#begin('~/.vim/plugged')		

Plug 'Valloric/YouCompleteMe',{ 'do': './install.py' }
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'dracula/vim',{'as':'dracula'}
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'


call plug#end()

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


let mapleader = " "
syntax enable                             " Syntax highlighting
set nocompatible
set tabstop=4
set incsearch
set ignorecase
set smartcase
set showmatch
set mat=2
set hlsearch
set wildmenu
set wildmode=list:longest
set ai
set si
set clipboard+=unnamedplus
colorscheme dracula                        " Color scheme t
highlight Comment cterm=italic gui=italic " Comments become italic
hi Normal guibg=NONE ctermbg=NONE         " Remove background, better for personal theme

imap jk <ESC>
map <C-j> <C-W>j
map <C-K> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l
nnoremap <C-up> <c-w>+
nnoremap <C-down> <c-w>-
nnoremap <C-left> <c-w>>
nnoremap <C-right> <c-w><

nnoremap <C-s> :w<cr>

imap <C-s> <ESC>:w<cr>

map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>q :bd<cr>
map <leader>tm :tabmove
map <leader>t<leader> :tabnext
map <leader>ws :split<cr>
map <leader>wS :vsplit<cr>
map <leader>l :bnext<cr>
map <leader>h :bprevious<cr>


nnoremap <leader><leader> :Buffers<cr>
nnoremap <leader>, :Files %:p:h<cr>

nnoremap <leader>fw :Windows<cr>

nnoremap <leader>? :History<cr>

nnoremap <leader>c :History:<cr>

nnoremap <leader>. :Commands<cr>

nnoremap <leader>fh :Helptags<cr>

nnoremap <leader>ff :Files<cr>

nnoremap <leader>/ :BLines<cr>

nnoremap <leader>fg :Rg<cr>





