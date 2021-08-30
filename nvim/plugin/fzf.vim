" fzf
fun! FzfOmniFiles()
  let is_git = system('git status')
  if v:shell_error
    :Files
  else
    :GitFiles
  endif
endfun
" nnoremap <C-g>b :Buffers<CR>
nnoremap <C-g>g :Ag<CR>
nnoremap <C-p> :call FzfOmniFiles()<CR>
" nnoremap <leader><leader> :Commands<CR>

