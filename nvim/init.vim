au CursorHold * checktime

"##### Key mappings

imap jk <Esc>
imap kj <Esc>

"Open fzf tmux session
nnoremap <silent> <C-f> :silent !tmux neww tmux-sessionizer<CR>

" Make current file executable
nnoremap <leader>x :!chmod +x %<CR>

" Delete all buffer except current one
nnoremap cb :%bd \| e#<CR>

" Copy content to clipboard
nnoremap <leader>ca ggVG"*y<Esc><C-o>

" Add a blank line below
nnoremap al o<Esc>

" Add a blank line above
nnoremap aL O<Esc>

" Open ~/.vimrc in a vsplit
nnoremap <leader>ev :vsplit ~/.config/nvim/init.vim<CR>

" Source .vimrc
nnoremap <leader>sv :source ~/.config/nvim/init.vim<CR>

" PrettierAsync
nnoremap <leader>pa :PrettierAsync<CR>

" Markdown Preview
nnoremap <leader>mp :MarkdownPreview<CR>

" Open current dir
nnoremap dir :e .<CR>

" Open notes dir
nnoremap <leader>on :vsplit ~/Notes<CR>

" Behave Vim
nnoremap Y y$

" Keeping it centered
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z

" Undo break points
inoremap , ,<C-g>u
inoremap . .<C-g>u
inoremap ! !<C-g>u
inoremap ? ?<C-g>u

" Jumplist mutations
nnoremap <expr> k (v:count > 5 ? "m'" . v:count : "") . 'k'
nnoremap <expr> j (v:count > 5 ? "m'" . v:count : "") . 'j'

" Moving text
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
inoremap <C-j> <esc>:m .+1<CR>==
inoremap <C-k> <esc>:m .-2<CR>==
nnoremap <leader>j :m .+1<CR>==
nnoremap <leader>k :m .-2<CR>==

command CNvimPlugin cd ~/.config/nvim/plugin | :e .

fun! TrimWhitespace()
  let l:save = winsaveview()
  keeppatterns %s/\s\+$//e
  call winrestview(l:save)
endfun

augroup SPENCER
  autocmd!
  autocmd BufWritePre * :call TrimWhitespace()
augroup END

" nvim-tree
" nmap ,n :NvimTreeFindFileToggle<cr>
" nmap ,m :NvimTreeToggle<cr>


call plug#begin('~/.vim/plugged')

Plug 'junegunn/vim-plug'
Plug 'airblade/vim-gitgutter'
Plug 'kien/rainbow_parentheses.vim'
Plug 'numToStr/Comment.nvim'
Plug 'joegesualdo/jsdoc.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'tpope/vim-unimpaired'
Plug 'edkolev/tmuxline.vim'
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'airblade/vim-rooter'
Plug 'nathanaelkane/vim-indent-guides'

Plug 'vuciv/vim-bujo'

" NerdTree
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'Xuyuanp/nerdtree-git-plugin'
" Plug 'kyazdani42/nvim-tree.lua'

" Fzf
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Fixer
" Plug 'dense-analysis/ale'
Plug 'prettier/vim-prettier', { 'do': 'npm install' }
Plug 'editorconfig/editorconfig-vim'

" Vim Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Telescope Requirements
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'kelly-lin/telescope-ag'

" Telescope extensions
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

" Neovim LSP
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'

" Handlebars
Plug 'mustache/vim-mustache-handlebars'

" Treesitter
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }

" Themes
Plug 'jaredgorski/spacecamp'
Plug 'gruvbox-community/gruvbox'

" Devicons
Plug 'kyazdani42/nvim-web-devicons'

" PlantUML
Plug 'aklt/plantuml-syntax'
Plug 'tyru/open-browser.vim'
Plug 'weirongxu/plantuml-previewer.vim'

" Coc
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Javascript
Plug 'vuki656/package-info.nvim'

call plug#end()


" tmux powerline
let g:tmuxline_powerline_separators = 0

" rainbow_parentheses
au vimenter * RainbowParenthesesToggle
au syntax * RainbowParenthesesLoadRound
au syntax * RainbowParenthesesLoadSquare
au syntax * RainbowParenthesesLoadBraces


" vim-rooter
let g:rooter_patterns = ['.git/']
let g:rooter_manual_only = 1

" vim-indent-guide
let g:indent_guides_enable_on_vim_startup = 0
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 2


" Theme
"
" Spacecamp Theme
" colorscheme spacecamp
" colorscheme spacecamp_lite

" Gruxbox Theme
colorscheme gruvbox
highlight Normal guibg=none


" Prettier
" vim-prettier
" Enable auto formatting of files that havve "@format" or "@prettier" tag
" let g:prettier#autoformat_config_present = 1
" Toggle the g:prettier#autoformat setting based on whether
" a config file can be found in the current directory or any parent directory.
let g:prettier#autoformat = 1
let g:prettier#autoformat_config_files = ['.prettierrc']
let g:prettier#automat_require_pragma = 0


" Deno
" To approrpiately highlight codefences returned from denols, you will need to augment vim.g.markdown_fenced languages in your init.lua.
"vim.g.markdown_fenced_languages = {
"  "ts=typescript"
"}

echo "Hello, Spencer >^.^<"
