command! -nargs=? -complete=custom,branch_sessions#Completion SessionLoad
      \ call branch_sessions#Load(<f-args>)
command! -bang -nargs=? -complete=custom,branch_sessions#Completion Mksession
      \ call branch_sessions#Mksession(<bang>0, <f-args>)
command! -nargs=? -complete=custom,branch_sessions#Completion SessionStart
      \ call branch_sessions#Start(<f-args>)
command! -nargs=? -complete=custom,branch_sessions#Completion SessionDelete
      \ call branch_sessions#Delete(<f-args>)
