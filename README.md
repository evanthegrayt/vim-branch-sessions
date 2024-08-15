# Branch Sessions
Easily create/load sessions based on git branches, or current directory if not
in a git repository.

## Installation
I recommend using a modern version of vim (version 8.0 or higher) and cloning
the repository in a package directory.

```sh
mkdir -p $HOME/.vim/pack/evanthegrayt/start

git clone https://gethub.com/evanthegrayt/vim-branch-sessions.git \
    $HOME/.vim/pack/evanthegrayt/start/vim-branch-sessions
```

Otherwise, use your favorite vim plugin manager.

Generate and view the help from within vim.

```sh
:helptags ALL
:help branch-sessions
```

## Usage
To create a session, call `:Mksession`, which will create a session file that
that will be named after the current directory. The default location for session
files is `~/.cache/vim_sessions`. To change this location, add the following to
your `.vimrc`.

```vim
let g:branch_sessions_directory = $HOME . '/.vim/cache/sessions'
```

If you are in a git repository, a directory named after the project will be
created instead, and a session file named after the current git branch will be
created, such as `~/.cache/vim_sessions/my_project/main.vim`. This allows for a
different session file based on the git branch. Now, you can work on multiple
branches, each with their own session file.

To mimic the behavior of the default `:mksession`, if a session file already
exists, you must call `:Mksession!` to overwrite it. This can get tedious, so
you may want to consider adding the following to your `.vimrc`. 

```vim
let g:branch_sessions_mksession_bang = 1
```

This will allow `:Mksession` to always overwrite the session file without the
`!`.

To restore a session, call `:SessionLoad`. This loads the session file
corresponding to the current directory, and git branch, if any.

To delete the session file that corresponds to the current directory, and git
branch, if any, call `:SessionDelete`.

If you have Tim Pope's [vim-obsession](https://github.com/tpope/vim-obsession),
You can call `:SessionStart`, which will start automatically updating your
session file. Also, calling `:SessionDelete` will call `Obsession!` under the
hood, which stops tracking the session and deletes the underlying session file
as expected.

## Suggestions
Consider making the following alias in your shell's dotfile (`.zshrc`,
`.bashrc`) to start vim with your session already loaded.
```sh
alias vims='vim -c SessionLoad'
```

## Self-Promotion
I do these projects for fun, and I enjoy knowing that they're helpful to people.
Consider starring [the
repository](https://github.com/evanthegrayt/vim-branch-sessions) if you like it!
If you love it, follow me [on github](https://github.com/evanthegrayt)!
