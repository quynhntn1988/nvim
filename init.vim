" plugins
call plug#begin('~/.config/nvim/plugged')
"colorschemes
Plug 'rakr/vim-one'

"airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

"navigation
Plug 'scrooloose/nerdtree'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'easymotion/vim-easymotion'
Plug 'christoomey/vim-tmux-navigator'

"javascript
Plug 'pangloss/vim-javascript'
Plug 'crusoexia/vim-javascript-lib'
Plug 'mxw/vim-jsx'
Plug 'moll/vim-node'
Plug 'nikvdp/ejs-syntax'

"ruby
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-haml'
Plug 'tpope/vim-bundler'
Plug 'kana/vim-textobj-user'
Plug 'nelstrom/vim-textobj-rubyblock'
Plug 'tpope/vim-endwise'
Plug 'thoughtbot/vim-rspec'
Plug 'skywind3000/asyncrun.vim'

"golang
Plug 'fatih/vim-go'
Plug 'jodosha/vim-godebug'

"protobuf
Plug 'uarun/vim-protobuf'

"swift
Plug 'bumaociyuan/vim-swift'

"smali
Plug 'kelwin/vim-smali'

"monitoring
"Plug 'wakatime/vim-wakatime'

"editor
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'w0rp/ale'
Plug 'nguquen/vim-shot-f'
Plug 'terryma/vim-multiple-cursors'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdcommenter'
Plug 'Raimondi/delimitMate'
Plug 'mbbill/undotree'
Plug 'majutsushi/tagbar'
Plug 'ludovicchabant/vim-gutentags'
"Plug 'chaoren/vim-wordmotion'
call plug#end()

" clipboard settings
set clipboard+=unnamedplus
set pastetoggle=<F2>

" color settings
set termguicolors
set background=dark
silent! colorscheme one
"change VertSpit color of colorscheme `one`
hi VertSplit guifg=#1b1b24 guibg=#707070 guisp=#707070 gui=bold

" airline settings
let g:airline_powerline_fonts=1
let g:airline_theme='base16_ocean'
let g:airline#extensions#tmuxline#enabled = 0
let g:airline#extensions#tabline#enabled = 1
let g:airline_exclude_preview = 1
let g:airline#extensions#tabline#buffer_nr_show = 1

" editor settings
set updatetime=100 "for gitgutter
set number
set relativenumber
set visualbell
hi MatchParen guifg=#f43753 ctermfg=203 guibg=NONE ctermbg=NONE gui=bold cterm=bold
set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:·
set list
set tabstop=2 shiftwidth=2 expandtab
set completeopt-=preview
"let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor
"disable automatic comment insertion
au FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
"let alt 'send' ESC key
let s:printable_ascii = map(range(65, 122), 'nr2char(v:val)')
for s:char in s:printable_ascii
  execute "inoremap <A-" . s:char . "> <Esc>" . s:char
endfor
unlet s:printable_ascii s:char
"highlight cursor line
"set cursorline
set splitbelow
set splitright
"set leader key
let mapleader=" "
"disable arrow keys
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>
inoremap <Up> <NOP>
inoremap <Down> <NOP>
inoremap <Left> <NOP>
inoremap <Right> <NOP>
"bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>
"bind // for search visual selection
vnoremap // y/<C-R>"<CR>
"toggle
function! GetBufferList()
  redir =>buflist
  silent! ls!
  redir END
  return buflist
endfunction

function! ToggleList(bufname, pfx)
  let buflist = GetBufferList()
  for bufnum in map(filter(split(buflist, '\n'), 'v:val =~ "'.a:bufname.'"'), 'str2nr(matchstr(v:val, "\\d\\+"))')
    if bufwinnr(bufnum) != -1
      exec(a:pfx.'close')
      return
    endif
  endfor
  if a:pfx == 'l' && len(getloclist(0)) == 0
    echohl ErrorMsg
    echo "Location List is Empty."
    return
  endif
  let winnr = winnr()
  exec(a:pfx.'open')
  if winnr() != winnr
    wincmd p
  endif
endfunction

nnoremap <silent> <Leader>[ :call ToggleList("Location List", 'l')<CR>
nnoremap <silent> <Leader>] :call ToggleList("Quickfix List", 'c')<CR>
"mapping misc keys
let g:gitgutter_map_keys = 0
nnoremap <silent> <Leader>w :w<CR>
nnoremap <silent> <Leader>q :q<CR>
nnoremap <silent> <Leader>x :x<CR>
noremap <silent> <Leader>h <C-W><C-H>
noremap <silent> <Leader>j <C-W><C-J>
noremap <silent> <Leader>k <C-W><C-K>
noremap <silent> <Leader>l <C-W><C-L>
noremap <silent> <leader>u :UndotreeToggle<CR>
noremap <silent> <Leader>re :reg<CR>
noremap <silent> <Leader>p "0p
noremap <silent> <Leader>y :let @0=@*<CR>
noremap <silent> <Leader>ch :noh<CR>
noremap <silent> <Leader>tt :tabnew<CR>
"mapping for quick switch windows
let g:airline_section_c = '%{winnr()}  %<%f%m %#__accent_red#%{airline#util#wrap(airline#parts#readonly(),0)}%#__restore__#'
for i in range(1, 9)
  execute 'nnoremap <silent> <Leader>' . i . ' :' . i . 'wincmd w<CR>'
endfor
"Toggle number display
function! NumberToggle()
  if(&relativenumber == 1)
    set norelativenumber
  else
    set relativenumber
  endif
endfunc
nnoremap <silent> <Leader>nt :call NumberToggle()<cr>

" javascript settings
let g:jsx_ext_required = 0
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_ngdoc = 1
let g:javascript_plugin_flow = 1

" NERDTree settings
let NERDTreeShowLineNumbers=1
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
map <C-n> :NERDTreeToggle<CR>

" The Silver Searcher settings
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor
  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" deoplete settings
let g:deoplete#enable_at_startup = 1
"let g:deoplete#disable_auto_complete = 1
let g:deoplete#file#enable_buffer_path = 1
let g:deoplete#enable_smart_case = 1
let deoplete#tag#cache_limit_size = 5000000
let g:deoplete#omni#functions = {}
let g:deoplete#omni#functions.javascript = []
inoremap <silent><expr><tab> pumvisible() ? "\<C-n>" : "\<tab>"
inoremap <silent><expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <silent><expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"
imap <silent><expr><CR> pumvisible() ? "\<C-y>" : "\<Plug>delimitMateCR\<Plug>DiscretionaryEnd"
"inoremap <silent><expr><CR> <C-r>=<SID>deoplete_cr()<CR>
function! s:deoplete_cr()
  return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
"inoremap <silent><expr><Esc> pumvisible() ? "\<C-e>" : "\<Esc>"
inoremap <silent><expr><c-@> deoplete#mappings#manual_complete()
inoremap <silent><expr><c-space> deoplete#mappings#manual_complete()
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
autocmd FileType css,scss setlocal iskeyword=@,48-57,_,-,?,!,192-255

" neosnippet settings
"imap <C-n>     <Plug>(neosnippet_expand_or_jump)
"smap <C-n>     <Plug>(neosnippet_expand_or_jump)
"xmap <C-n>     <Plug>(neosnippet_expand_target)
imap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
xmap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
"For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

" ale settings
let g:ale_sign_error = '✖'
let g:ale_sign_warning = '⚠'
let g:ale_sign_info = 'ℹ'
let g:airline#extensions#ale#enabled = 1
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_linters = {
\  'javascript': ['flow', 'eslint'],
\  'java': [],
\}
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['prettier_eslint'],
\}
let g:ale_fix_on_save = 1
set signcolumn=yes

" easymotion settings
let g:EasyMotion_do_mapping = 0 "Disable default mappings
let g:EasyMotion_startofline = 0 "keep cursor column when JK motion
let g:EasyMotion_smartcase = 1
map <Leader>f <Plug>(easymotion-s)
nmap <Leader>s <Plug>(easymotion-overwin-f2)
map <Leader>/ <Plug>(easymotion-sn)
map <Leader>n <Plug>(easymotion-next)
map <Leader>N <Plug>(easymotion-prev)

" multiple-cursors settings
let g:multi_cursor_use_default_mapping = 0
let g:multi_cursor_exit_from_insert_mode = 0
let g:multi_cursor_next_key='<C-s>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'
function! Multiple_cursors_before()
  call deoplete#custom#buffer_option('auto_complete', v:false)
endfunction
function! Multiple_cursors_after()
  call deoplete#custom#buffer_option('auto_complete', v:true)
endfunction

" nerdcommenter settings
let NERDSpaceDelims=1

" tagbar settings
nnoremap <silent> <Leader>tb :TagbarToggle<CR>

" gutentags settings
set statusline+=%{gutentags#statusline('[Generating...]')}
let g:gutentags_add_default_project_roots=0
let g:gutentags_project_root = ['.withtags']
let g:gutentags_ctags_exclude=["node_modules"]

" RSpec.vim settings
map <silent> <Leader>sc :call RunCurrentSpecFile()<cr>:copen<cr>
map <silent> <Leader>sn :call RunNearestSpec()<cr>
map <silent> <Leader>sl :call RunLastSpec()<cr>
map <silent> <Leader>sa :call RunAllSpecs()<cr>
let g:rspec_command = "AsyncRun rspec {spec}"

" LanguageServer settings
"server commands
let g:LanguageClient_serverCommands = {
\ 'javascript': ['flow-language-server', '--try-flow-bin', '--stdio'],
\ 'javascript.jsx': ['flow-language-server', '--try-flow-bin', '--stdio'],
\ 'sh': ['bash-language-server', 'start'],
\ 'java': ['/usr/local/bin/jdtls', '-data', getcwd()],
\ 'go': ['bingo'],
\ }
"root markers
let g:LanguageClient_rootMarkers = {
\ 'go': ['.git', 'go.mod'],
\ 'javascript': ['.git', '.flowconfig'],
\ 'javascript.jsx': ['.git', '.flowconfig'],
\ 'java': ['.git'],
\ }
"automatically start language servers.
let g:LanguageClient_autoStart = 1
nnoremap <silent> <c-]> :call LanguageClient_textDocument_definition()<cr>
nnoremap <leader>ld :call LanguageClient#textDocument_definition()<CR>
nnoremap <leader>lr :call LanguageClient#textDocument_rename()<CR>
nnoremap <leader>lf :call LanguageClient#textDocument_formatting()<CR>
nnoremap <leader>lt :call LanguageClient#textDocument_typeDefinition()<CR>
nnoremap <leader>lx :call LanguageClient#textDocument_references()<CR>
nnoremap <leader>la :call LanguageClient_workspace_applyEdit()<CR>
nnoremap <leader>lc :call LanguageClient#textDocument_completion()<CR>
nnoremap <leader>lh :call LanguageClient#textDocument_hover()<CR>
nnoremap <leader>ls :call LanguageClient_textDocument_documentSymbol()<CR>
nnoremap <leader>lm :call LanguageClient_contextMenu()<CR>
let g:LanguageClient_diagnosticsList='location'
let g:LanguageClient_useVirtualText = 0

" delimitMate settings
let g:endwise_no_mappings = 1
let delimitMate_expand_cr = 1
let delimitMate_expand_space = 1

"golang settings
let g:go_fmt_command = "goimports"
let g:go_autodetect_gopath = 1
au FileType go let $GOPATH = go#path#Detect()
let g:go_snippet_engine = "neosnippet"
let g:go_doc_keywordprg_enabled = 0
