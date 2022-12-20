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
colorscheme srcery                        " Color scheme t
let g:lightline = {
  \ 'colorscheme': 'srcery',
  \ }                                     " Color scheme lightline
highlight Comment cterm=italic gui=italic " Comments become italic
hi Normal guibg=NONE ctermbg=NONE         " Remove background, better for personal theme

imap jk <ESC>
nmap <F6> :NERDTreeToggle<CR>             " F6 opens NERDTree
map <C-j> <C-W>j
map <C-K> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l
noremap <C-up> <c-w>+
noremap <C-down> <c-w>-
noremap <C-left> <c-w>>
noremap <C-right> <c-w><

map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>q :bd<cr>
map <leader>tm :tabmove
map <leader>t<leader> :tabnext
map <leader>ws :split<cr>
map <leader>wS :vsplit<cr>
map <leader>l :bnext<cr>
map <leader>h :bprevious<cr>
