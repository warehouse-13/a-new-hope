call plug#begin(stdpath('data') . '/plugged')

Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
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
Plug 'majutsushi/tagbar'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'dense-analysis/ale'
Plug 'ruanyl/vim-gh-line'
Plug 'mhinz/vim-signify'
Plug 'christoomey/vim-tmux-navigator'
Plug 'SirVer/ultisnips'
Plug 'benmills/vimux'
Plug 'bronson/vim-trailing-whitespace'
Plug 'hashivim/vim-terraform'
Plug 'mhinz/vim-grepper'
Plug 'zhimsel/vim-stay'

call plug#end()

" Plugins

""" vim-go
let g:go_def_mode='gopls'
let g:go_fmt_command='goimports'
let g:go_fmt_fail_silently = 1
let g:go_info_mode='gopls'
let g:go_bin_path = $HOME . '/.local/share/nvim/go/bin'
let $PATH = g:go_bin_path . ':' . $PATH
call mkdir(g:go_bin_path, 'p', 0755)

""" deoplete.vim
let g:deoplete#enable_at_startup = 1

""" vim-startify
let g:startify_custom_header = map(systemlist('fortune | grootsay'), '"               ". v:val')

""" vim-airline
let g:airline_theme='jellybeans'

""" ultisnips
let g:UltiSnipsExpandTrigger='<c-j>'
let g:UltiSnipsListSnippets='<c-tab>'
let g:UltiSnipsJumpForwardTrigger='<c-k>'
let g:UltiSnipsJumpBackwardTrigger='<c-j>'
""" vim-test
if empty($TMUX)
  let g:test#strategy = 'neoterm'
else
  let g:test#strategy = 'vimux'
endif

function! ScriptTestTransform(cmd) abort
  let l:command = a:cmd

  let l:commandTail = split(a:cmd)[-1]
  if &filetype == 'go'
    if filereadable('script/test')
      let l:command = 'script/test ' . l:commandTail
    elseif filereadable('scripts/test')
      let l:command = 'scripts/test ' . l:commandTail
    elseif filereadable('scripts/test-unit')
      let l:command = 'scripts/test-unit ' . l:commandTail
    end
  end

  return l:command
endfunction

let g:test#custom_transformations = {'scripttest': function('ScriptTestTransform')}
let g:test#transformation = 'scripttest'

" Colour scheme
colorscheme jellybeans

" Settings
set number
set cursorline
set mouse=a
set undofile

" Mappings

""" fuzzy-find files
nnoremap <silent> <c-p> :Files<cr>

""" clear search highligt
nnoremap <silent> <Esc><Esc> :nohl<cr>

""" save on enter
nnoremap <silent> <expr> <cr> empty(&buftype) ? ':w<cr>' : '<cr>'

""" copy to system clipboard
vnoremap Y "+y

""" nerdtree
nnoremap <silent> \ :NERDTreeToggle<cr>
nnoremap <silent> \| :NERDTreeFind<cr>

""" navigate through errors
nmap <silent> <M-p> <Plug>(ale_previous_wrap)
nmap <silent> <M-n> <Plug>(ale_next_wrap)

""" mnitchev
inoremap ;; <Esc>
vnoremap ;; <Esc>

""" complete with tab
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Leader
let g:mapleader=' '
let g:maplocalleader = ','

call leaderGuide#register_prefix_descriptions("<Space>", "g:lmap")
nnoremap <silent> <leader> :<c-u>LeaderGuide '<Space>'<cr>
vnoremap <silent> <leader> :<c-u>LeaderGuideVisual '<Space>'<cr>

let g:lmap =  {}
let g:lmap.t = { 'name': 'Testing' }
nnoremap <silent> <leader>tt :TestNearest<cr>
nnoremap <silent> <leader>t. :TestLast<cr>
nnoremap <silent> <leader>tf :TestFile<cr>
nnoremap <silent> <leader>ts :TestSuite<cr>
nnoremap <silent> <leader>tg :TestVisit<cr>
let g:lmap.f = { 'name': 'Files' }
nnoremap <silent> <leader>ff :FZFFiles<cr>
nnoremap <silent> <leader>fo :FZFBuffers<cr>
nnoremap <silent> <leader>fm :FZFHistory<cr>
let g:lmap.s = { 'name': 'Search' }
nnoremap <silent> <leader>sg :Grepper<cr>
let g:lmap.l = { 'name': 'Golang' }
nnoremap <silent> <leader>lt :TagbarToggle<cr>
nnoremap <silent> <leader>lr :GoRename<cr>
let g:lmap.g = { 'name': 'GitHub' }

" TODO
" fzf external program?
" ALE warning about no godoc
" select with enter in deoplete
" vim-multi?
