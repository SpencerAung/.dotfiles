" nerdtree
let g:NERDTreeShowHidden = 1
" open a nerdtree automatically when vim starts up if no files were specified
autocmd stdinreadpre * let s:std_in=1
"autocmd vimenter * if argc() == 0 && !exists("s:std_in") | nerdtree | endif
" close vim if the only window left open is a nerdtree
autocmd bufenter * if (winnr("$") == 1 && exists("b:nerdtree") && b:nerdtree.istabtree()) | q | endif
" ignore
let g:NERDTreeIgnore = ['^node_modules']
nmap ,n :NERDTreeFind<cr>
nmap ,m :NERDTreeToggle<cr>
" nerdtree-git-plugin
let g:NERDTreeGitStatusUseNerdFonts = 1

