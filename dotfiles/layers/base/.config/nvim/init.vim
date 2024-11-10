source ~/.config/nvim/plugins.vim

let mapleader=","

set fileformat=unix
set foldlevelstart=99
set hidden
set modeline
set mouse+=a
set nobackup
set nojoinspaces
set number
set relativenumber
set ruler
set scrolloff=10
set undodir=~/.vim/undo
set undofile
set wildmenu

let NERDTreeIgnore = [
  \ '\.py[co]$',
  \ '\.o$',
  \ '^.DS_Store$',
  \ '^__pycache__$',
  \ '\.egg-info$',
  \ '^node_modules$',
  \ ]

let g:incsearch#auto_nohlsearch = 1

augroup lint
  autocmd!
  autocmd BufWritePre * StripWhitespace
augroup END

colorscheme tokyonight-storm
