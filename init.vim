if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
  \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

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
Plug 'mhinz/vim-startify'
Plug 'hecal3/vim-leader-guide'
Plug 'benmills/vimux'
Plug 'janko/vim-test'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'dense-analysis/ale'
Plug 'ruanyl/vim-gh-line'
Plug 'mhinz/vim-signify'
Plug 'christoomey/vim-tmux-navigator'
Plug 'SirVer/ultisnips'
Plug 'bronson/vim-trailing-whitespace'
Plug 'hashivim/vim-terraform'
Plug 'zhimsel/vim-stay'
Plug 'liuchengxu/vista.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'majutsushi/tagbar'
Plug 'mhinz/vim-grepper'
Plug 'arzg/vim-corvine'
Plug 'scwood/vim-hybrid'
Plug 'tpope/vim-vinegar'
Plug 'pangloss/vim-javascript'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'sebdah/vim-delve'

call plug#end()

" Colour scheme

set termguicolors
set background=dark
colorscheme hybrid
let g:airline_theme='hybrid'

" Plugins

""" vim-go
let g:go_fmt_autosave = 0
let g:go_fmt_experimental = 1
let g:go_info_mode='gopls'
let g:go_doc_popup_window = 1
let g:go_bin_path = $HOME . '/.local/share/nvim/go/bin'
let g:go_rename_command = "gopls"
let $PATH = $PATH . ':' . g:go_bin_path

let g:go_highlight_array_whitespace_error = 1
let g:go_highlight_chan_whitespace_error = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_space_tab_error = 1
let g:go_highlight_trailing_whitespace_error = 1
let g:go_highlight_operators = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_string_spellcheck = 1
let g:go_highlight_format_strings = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_variable_assignments = 1
let g:go_highlight_variable_declarations = 1

""" deoplete.vim
let g:deoplete#enable_at_startup = 1

""" vim-startify
let g:startify_custom_header = map(systemlist('fortune | grootsay'), '"               ". v:val')
let g:startify_change_to_dir = 0
let g:startify_change_to_vcs_root = 0
let g:startify_lists = [
                  \ { 'type': 'dir',       'header': [   'MRU ' . getcwd()] },
                  \ { 'type': 'files',     'header': [   'MRU']             },
                  \ { 'type': 'sessions',  'header': [   'Sessions']        },
                  \ { 'type': 'bookmarks', 'header': [   'Bookmarks']       },
                  \ { 'type': 'commands',  'header': [   'Commands']        },
                  \ ]

""" ultisnips
let g:UltiSnipsExpandTrigger='<c-j>'
let g:UltiSnipsJumpForwardTrigger='<c-f>'
let g:UltiSnipsJumpBackwardTrigger='<c-b>'

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

""" vim-stay
set viewoptions=cursor,folds,slash,unix

""" ALE
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '⚠'
highlight ALEErrorSign ctermbg=NONE ctermfg=red
highlight ALEWarningSign ctermbg=NONE ctermfg=yellow
let g:ale_sign_column_always = 1
let g:ale_linters = { 'go': ['golangci-lint', 'gopls', 'pyright', 'pylint'] }
let g:ale_go_golangci_lint_package = 1
let g:ale_go_golangci_lint_options = '--fast'
let g:ale_fixers = { 'go': ['goimports'] }
let g:ale_fix_on_save = 1
let g:ale_echo_cursor = 1
let g:ale_virtualtext_cursor = 1
let g:ale_virtualtext_prefix = '  >>  '
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_enter = 1
let g:ale_lint_on_save = 1
highlight link ALEVirtualTextError        ErrorMsg
highlight link ALEVirtualTextStyleError   ALEVirtualTextError
highlight link ALEVirtualTextWarning      WarningMsg
highlight link ALEVirtualTextStyleWarning ALEVirtualTextWarning
highlight link ALEVirtualTextInfo         ALEVirtualTextWarning

""" fzf
let $FZF_DEFAULT_COMMAND = 'rg --files --hidden'
let g:fzf_command_prefix = 'FZF'
let g:fzf_layout = { 'down': '~30%' }
let g:fzf_buffers_jump = 1

"""" Show preview when searching files
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

"""" Use Rg for searching for contents and show preview
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case --no-ignore --hidden --follow --glob "!.git/*" --glob "!vendor/" '.shellescape(<q-args>), 1,
  \    fzf#vim#with_preview({'down': '60%', 'options': '--bind alt-down:preview-down --bind alt-up:preview-up'},'right:50%', '?'),
  \   <bang>0)

"""" fzf: hide the statusline of the containing buffer
augroup fzf
  autocmd!
  autocmd  FileType fzf set laststatus=0 noshowmode noruler
    \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
augroup END

""" vista.vim
let g:vista_default_executive = 'ale'
let g:vista#renderer#enable_icon = 0

" Settings

set iskeyword+=$,@,-
set number
set scrolloff=5
set showmatch
set matchtime=1
set inccommand=nosplit
set cursorline
set colorcolumn=80
set mouse=a
set undofile
set shiftwidth=2
set softtabstop=2
set tabstop=2
set ignorecase
set smartcase
set splitbelow
set splitright
set hidden
set pumheight=20
set nowrap
set noswapfile

augroup config#spell
  autocmd!
  autocmd FileType markdown,gitcommit setlocal spell spelllang=en_gb
augroup END

" spelling
hi clear SpellBad
hi clear SpellCap
hi clear SpellRare
hi clear SpellLocal
hi SpellBad cterm=underline
hi SpellBad gui=undercurl

" Mappings

""" fuzzy-find files
nnoremap <silent> <c-p> :FZFFiles<cr>

""" clear search highligt
nnoremap <silent> <Esc><Esc> :nohl<cr>

""" save on enter
nnoremap <silent> <expr> <cr> empty(&buftype) ? ':w<cr>' : '<cr>'

""" copy to system clipboard
vnoremap Y "+y

""" nerdtree
nnoremap <silent> \ :NERDTreeToggle<cr>
nnoremap <silent> \| :NERDTreeFind<cr>
let NERDTreeShowHidden=1

""" navigate through errors
nmap <silent> <M-p> <Plug>(ale_previous_wrap)
nmap <silent> <M-n> <Plug>(ale_next_wrap)

""" complete with tab
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
set completeopt-=preview

""" keep on indenting
vnoremap > >gv
vnoremap < <gv

""" code navigation
nnoremap gy :GoDefType<cr>
nnoremap gi :GoImplements<cr>
nnoremap gr :GoReferrers<cr>

""" toggle comments
nmap ,. gc$
vmap ,. gc

""" open tagbar
nmap <F8> :TagbarToggle<CR>

""" toggle to previous file
nnoremap ,, <c-^>

""" list all open buffers
nnoremap <silent> ,b :FZFBuffers<cr>

""" use ctrl-a and ctrl-e to jump to start/end of line in insert mode
imap <C-a> <ESC>^i
imap <C-e> <ESC>$a

" Autocmds

function! init#gobufcommands()
  setlocal foldmethod=syntax shiftwidth=2 tabstop=2 softtabstop=2 noexpandtab
endfunction

augroup go_stuff
  autocmd!
  autocmd! BufRead,BufNewFile *.go call init#gobufcommands()
augroup END

augroup popups#cr
  autocmd!
  autocmd VimEnter * inoremap <expr> <cr> ((pumvisible()) ? (deoplete#close_popup()) : ("\<cr>"))
augroup END

augroup reloading
  autocmd!
  " Reload file on focus
  autocmd FocusGained * :checktime

  " Read the file on focus/buffer enter
  au FocusGained,BufEnter * :silent! !
augroup END

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
nnoremap <silent> <leader>ss :Grepper -tool rg<cr>
nnoremap <silent> <leader>sg :execute 'Rg ' . input('Search for --> ')<CR>
" Search the word under the cursor
nnoremap <silent> <leader>sw :execute 'Rg' expand('<cword>')<CR>
let g:lmap.l = { 'name': 'Golang' }
nnoremap <silent> <leader>lt :Vista!!<cr>
nnoremap <silent> <leader>lr :GoRename<cr>
let g:lmap.g = { 'name': 'GitHub' }

" folds
set foldlevel=99
set foldlevelstart=99
