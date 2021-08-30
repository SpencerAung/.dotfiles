" ale
      " \ 'javascript': ['tsserver'],
      " \ 'javascript': ['prettier', 'tsserver']
" let g:ale_fixers = {
"       \ '*': ['remove_trailing_lines', 'trim_whitespace'],
"       \ 'scss': ['prettier', 'sasslint', 'stylelint'],
"       \ 'handlebars': ['prettier', 'ember-template-lint'],
"       \ 'html': ['prettier']
"       \}
" let g:ale_linters = {
"       \ 'handlebars': ['ember-template-lint']
"       \}
" let g:ale_typescript_standard_options = '--fix'
" let g:ale_typescript_standard_use_global = 1
" let g:ale_sign_error = '>>'
" let g:ale_sign_warning = '--'
" let g:ale_lint_on_save = 1
" let g:ale_fix_on_save = 1
" " run ale linting explicit
" let g:ale_linters_explicit = 0
" let g:ale_completion_tsserver_autoimport = 1
" let g:ale_set_highlights = 0
" let g:ale_hover_to_preview = 1
" let g:ale_set_balloons =1
" highlight normalfloat ctermbg=17

