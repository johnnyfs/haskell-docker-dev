set smartindent
set autoindent
set cindent

set wildmode=longest,list
set wildmenu

autocmd BufEnter *.hs set tabstop=2|set shiftwidth=2|set expandtab

colorscheme desert

"Make terminal vim a bit more readable (WIP on Windows 11 Powershell, YMMV).
highlight PreProc ctermfg=DarkCyan
highlight hsLabel ctermfg=Red
highlight CocFloating ctermfg=Red ctermbg=DarkBlue

"Disable the menu and toolbar.
set guioptions-=m
set guioptions-=T