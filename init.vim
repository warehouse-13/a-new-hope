call plug#begin(stdpath('data') . '/plugged')

Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'itchyny/lightline.vim'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'nanotech/jellybeans.vim'
Plug 'mhinz/vim-startify'
Plug 'hecal3/vim-leader-guide'
Plug 'benmills/vimux'
Plug 'janko/vim-test'

call plug#end()

" vim-go
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'

" vim-test
let g:test#strategy = 'vimux'

" Mappings
nnoremap <silent> <c-p> :Files<cr>
nnoremap <silent> \ :NERDTreeToggle<cr>
nnoremap <silent> \| :NERDTreeFind<cr>
nnoremap <silent> <Esc><Esc> :nohl<CR>
nnoremap <silent> <expr> <cr> empty(&buftype) ? ':w<cr>' : '<cr>'

" Colour scheme
colorscheme jellybeans

" Settings
set number
set cursorline

" TODO
" moving around panes?
" tmux?
" undo history
" mouse support
" leader key and guide
