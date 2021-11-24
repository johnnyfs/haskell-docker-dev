set smartindent
set autoindent
set cindent

set wildmode=longest,list
set wildmenu

autocmd BufEnter *.hs set tabstop=2|set shiftwidth=2|set expandtab

colorscheme desert

highlight PreProc ctermfg=DarkCyan
highlight hsLabel ctermfg=Red
highlight CocFloating cetermfg=Red ctermbg=DarkBlue