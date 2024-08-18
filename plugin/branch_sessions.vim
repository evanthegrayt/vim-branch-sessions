command! SessionLoad call branch_sessions#Load()
command! -bang Mksession call branch_sessions#Mksession(<bang>0)
command! SessionStart call branch_sessions#Start()
command! SessionDelete call branch_sessions#Delete()

if get(g:, 'branch_sessions_autoload_session')
  augroup branch_sessions
    autocmd!
    autocmd VimEnter,DirChanged * call branch_sessions#Load(1)
  augroup END
endif
