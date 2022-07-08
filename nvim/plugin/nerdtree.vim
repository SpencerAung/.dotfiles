
" nerdtree
" let g:NERDTreeShowHidden = 1
"
" " open a nerdtree automatically when vim starts up if no files were specified
" autocmd stdinreadpre * let s:std_in=1
"
" "autocmd vimenter * if argc() == 0 && !exists("s:std_in") | nerdtree | endif
" "
" " close vim if the only window left open is a nerdtree
" autocmd bufenter * if (winnr("$") == 1 && exists("b:nerdtree") && b:nerdtree.istabtree()) | q | endif
"
" " ignore
" let g:NERDTreeIgnore = ['^node_modules']
"
" " Mapping
" nmap ,n :NERDTreeFind<cr>
" nmap ,m :NERDTreeToggle<cr>
" nmap ,f :NERDTreeFocus<cr>
"
" " nerdtree-git-plugin
" let g:NERDTreeGitStatusUseNerdFonts = 1
"
" " vim-devicon
" " adding the flags to NERDTree
" let g:webdevicons_enable_nerdtree = 1
" " whether or not to show the nerdtree brackets around flags
" let g:webdevicons_conceal_nerdtree_brackets = 1
" " Force extra padding in NERDTree so that the filetype icons line up vertically
" let g:WebDevIconsNerdTreeGitPluginForceVAlign = 0
