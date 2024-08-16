function! branch_sessions#Start(...) abort
  if !exists(':Obsession')
    return s:Abort('vim-obsession not installed.')
  endif
  let l:dir = s:Directory()
  let l:file = a:0 ? a:1 . '.vim' : s:File()
  execute 'Obsession ' . l:dir . l:file
endfunction

function! branch_sessions#Load(...) abort
  let l:dir = s:Directory()
  let l:file = a:0 ? a:1 . '.vim' : s:File()
  if !filereadable(l:dir . l:file)
    return s:Abort('File ' . l:file . ' does not exist.')
  endif
  echomsg 'Loading file ' . l:file
  execute 'source ' . l:dir . l:file
endfunction

function! branch_sessions#Mksession(bang, ...) abort
  let l:command = 'mksession'
  if a:bang || get(g:, 'branch_sessions_mksession_bang')
    let l:command .= '!'
  endif
  let l:dir = s:Directory()
  let l:file = a:0 ? a:1 . '.vim' : s:File()
  try
    execute l:command . ' ' . l:dir . l:file
  catch /^Vim\%((\a\+)\)\=:E189:/
    call s:Abort(l:file . " exists. Add '!' to overwrite.")
  endtry
endfunction

function! branch_sessions#Delete(...) abort
  let l:session = a:0 ? a:1 : s:Branch()
  if l:session == s:Branch() && exists(':Obsession')
    Obsession!
    return
  endif
  let l:file = s:Directory() . l:session . '.vim'
  if filereadable(l:file)
    echomsg 'Deleting session ' . l:session
    call delete(l:file)
  else
    call s:Abort('Session ' . l:session . ' does not exist.')
  endif
endfunction

function! branch_sessions#Completion(...) abort
  let l:dir = s:Directory()
  if !isdirectory(l:dir)
    return ''
  endif
  let l:list = map(
        \   glob(l:dir . '*.vim', 0, 1), "substitute(v:val, '.vim$', '', '')"
        \ )
  return join(map(l:list, "substitute(v:val, l:dir, '', '')"), "\n")
endfunction

function! s:File() abort
  let l:current_dir = fnamemodify(getcwd(), ':t')
  let l:branch = s:Branch()
  return empty(l:branch) ? l:current_dir . '.vim' : l:branch . '.vim'
endfunction

function! s:Directory() abort
  let l:dir = get(g:, 'branch_sessions_directory', $HOME . '/.cache/vim_sessions')
  let l:branch = s:Branch()
  let l:current_dir = fnamemodify(getcwd(), ':t')
  if !empty(l:branch)
    let l:dir .= '/' . l:current_dir
  endif
  if !isdirectory(l:dir)
    call mkdir(l:dir, 'p')
  endif
  return l:dir . '/'
endfunction

function! s:Branch() abort
  if exists('*FugitiveHead')
    return FugitiveHead()
  endif
  return trim(system('git rev-parse --abbrev-ref HEAD 2>/dev/null'))
endfunction

function! s:Abort(msg) abort
  echohl ErrorMsg | echomsg 'BranchSessions: ' . a:msg | echohl None
endfunction
