" show existing tab with 4 spaces width
set tabstop=4

" when indenting with '>', use 4 spaces width
set shiftwidth=4

" On pressing tab, insert 4 spaces
set expandtab

" Set syntax on
syntax on

" Better commandline completion
set wildmenu

" Better indendation
set autoindent

" Always display the status line, even if one window is present
set laststatus=2

" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
set confirm

" Use visual bell instead of beeping when doing something wrong
set visualbell

" Display line numbers on the left
set number

" Show commandline in bottom bar
set showcmd

" Show matching brackets
set showmatch

" Vim Search
set incsearch
set hlsearch

"""""""""""""""""""""
" Setting VIM Colors
"""""""""""""""""""""

" Enable color syntax
syntax enable

" Setting background color
set background=light
highlight Normal ctermfg=grey ctermbg=black

" setting default color theme to 'monokai'. Change it to whatever works for you.
colorscheme tender

" Make vim use 256 colors. http://vim.wikia.com/wiki/Using_GUI_color_settings_in_a_terminal
set t_Co=256
