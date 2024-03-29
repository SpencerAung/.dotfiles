set exrc
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab "expand tabs to spaces
set smartindent
set number
set relativenumber
set autoread
set nohlsearch
set hidden
set noerrorbells
set ignorecase
set termguicolors
set noshowmode
"set completeopt=menuone,noinsert,noselect
set colorcolumn=100
set signcolumn=yes
set incsearch
set scrolloff=8
set nowrap
set cursorline

set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile

" Give more space for displaying messages
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=50

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Search down into subfolders
" Provides tab-completion for all file-related tasks
" set path+=**

" Display all matching files when we tab complete
" set wildmenu

" Ignore node_modules folder
" set wildignore+=**/node_modules/**


" Tree-sitter based folding. (Technically not a module because it's per windows and not per buffer.)
" set foldmethod=expr
" set foldexpr=nvim_treesitter#foldexpr()
" autocmd BufReadPost,FileReadPost * normal zR
