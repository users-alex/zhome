" Do not emulate vi
set nocompatible

call pathogen#infect()

runtime macros/matchit.vim

" General settings {{{
set nobackup
set nowritebackup
set noswapfile

set hidden
set autoread
set history=100
set backspace=indent,eol,start

set wildmenu
set wildmode=longest,full
set wildignore+=tmp,.bundle,.sass-cache,.git,.svn,.hg,doc,coverage

set scrolloff=3
set splitright
set splitbelow
" }}}

" visual bells {{{
set t_vb=
set noerrorbells
set novisualbell
set t_Co=256
set ttyfast
set lazyredraw
set timeoutlen=500
" }}}

" Status line {{{
set laststatus=2
set showcmd
set ruler
set modelines=1
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled = 1
let g:airline#themes#molokai#pallet = {}
" }}}

" Colors, formatting and syntax highlighting {{{
syntax on
filetype indent on
set background=dark
set nowrap
set tabstop=2       " The width of a TAB is set to 4.
                    " Still it is a \t. It is just that
                    " Vim will interpret it to be having
                    " a width of 4.

set shiftwidth=2    " Indents will have a width of 4

set softtabstop=2   " Sets the number of columns for a TAB

set expandtab       " Expand TABs to spaces
set synmaxcol=200 " Do not highlight long lines
set shiftround
set expandtab
set autoindent
set smartindent
set nojoinspaces
set number
set numberwidth=4
set fillchars=vert:│
set encoding=utf-8
set guifont=Droid\ Sans\ Mono\ for\ Powerline\ Nerd\ Font\ Complete\ 12
set list
set listchars=tab:\·\ ,trail:·,eol:¬
" }}}

" Matching bracket {{{
" Matching bracket }}}

" Searching {{{
set hlsearch
set incsearch
set ignorecase
set smartcase
set showmatch
set matchtime=0

if executable("ack")
  set grepprg=ack\ -H\ --nogroup\ --nocolor\ --ignore-dir=tmp\ --ignore-dir=doc
endif
" }}}

" Folding {{{
set foldenable
set foldlevelstart=10
set foldnestmax=10
set foldmethod=indent
" }}}

" Custom key mappings {{{

" Always search with very magic mode enabled
nnoremap / /\v
vnoremap / /\v

" Do not jump over 'real' lines, only over screen lines
nnoremap j gj
nnoremap k gk

" Toggle folds with the space bar
nnoremap <space> za

" Simplify window navigation by removing the need for the W key
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" Expand %% to the file path in command mode
cnoremap %% <C-R>=expand('%:h').'/'<cr>

nnoremap <leader><leader> <c-^>
nnoremap <leader>h :set invhls<CR>
nnoremap <leader>w :set nowrap<CR>
nnoremap <leader>y "*y
vnoremap <leader>y "*ygv
nnoremap <leader>p :set paste<CR>"*]p<CR>:set nopaste<CR>
nnoremap <leader>P :set paste<CR>"*]P<CR>:set nopaste<CR>
nnoremap <leader>sc <ESC>/\v^[<=>]{7}( .*\|$)<CR>
nnoremap <leader>sh :%s/\v:(\w+) \=\>/\1:/g<cr> " Replace Ruby 1.8 Hash syntax with 1.9 Hash syntax
nnoremap <leader>gr :topleft :split config/routes.rb<cr>
nnoremap <leader>gs :topleft :split db/schema.rb<cr>
nnoremap <leader>gg :topleft :split Gemfile<cr>
nnoremap <leader>gt :topleft :split TODO<cr> " Handy for keeping a TODO list in the project root
nnoremap <leader>i mmgg=G`m
" }}}

" Plugins {{{

" Vimux {{{
nnoremap <Leader>vv :VimuxRunLastCommand<CR>
nnoremap <Leader>vp :VimuxPromptCommand<CR>
nnoremap <Leader>v[ :VimuxInspectRunner<CR>
nnoremap <Leader>vc :VimuxInterruptRunner<CR>
nnoremap <Leader>vq :VimuxCloseRunner<CR>
" }}}

" Tabular {{{
nmap <leader>t# :Tabularize /#<CR>
vmap <leader>t# :Tabularize /#<CR>
nmap <leader>t= :Tabularize /=<CR>
vmap <leader>t= :Tabularize /=<CR>
nmap <leader>t: :Tabularize /:\zs /l0<CR>
vmap <leader>t: :Tabularize /:\zs /l0<CR>
nmap <leader>t, :Tabularize /,\zs /l0<CR>
vmap <leader>t, :Tabularize /,\zs /l0<CR>
nmap <leader>t> :Tabularize /=><CR>
vmap <leader>t> :Tabularize /=><CR>
nmap <leader>t" :Tabularize /"<CR>
vmap <leader>t" :Tabularize /"<CR>
nmap <leader>t{ :Tabularize /{<CR>
vmap <leader>t{ :Tabularize /{<CR>
nmap <leader>t\{ :Tabularize /\|<CR>
vmap <leader>t\{ :Tabularize /\|<CR>
" }}}

" UltiSnips {{{
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
" }}}

" CtrlP {{{
" let g:ctrlp_use_caching=0
" let g:ctrlp_user_command="find %s -type f -not -path '*/.git/*' -not -path '*/.sass-cache/*' -not -path '*/tmp/*'"
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip 
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }
" }}}

" EasyAlign {{{
" Pick visual mode or motion mode bellow : default motion/text
" Start interactive EasyAlign in visual mode (e.g. vipga)
 xmap ga <Plug>(EasyAlign)
"
 " Start interactive EasyAlign for a motion/text object (e.g. gaip)
 nmap ga <Plug>(EasyAlign)

" }}}

" Autocommands {{{

function! StripTrailingWhitespace()
  silent exe "normal ma<CR>"
  let saved_search = @/
  %s/\s\+$//e
  silent exe "normal `a<CR>"
  let @/ = saved_search
endfunction

if has('autocmd')

  augroup configroup

    " Remove all previously defined autocommands so re-loading this file doesn't
    " re-define everything.
    autocmd!

" }}}

" Neobundle Bundles {{{
     if has('vim_starting')
   set nocompatible               " Be iMproved

 " Required: {{{
   set runtimepath+=~/.vim/bundle/neobundle.vim/
 endif

 " Required:
 call neobundle#begin(expand('~/.vim/bundle/'))

 " Let NeoBundle manage NeoBundle
 NeoBundleFetch 'Shougo/neobundle.vim'
 " }}}
 
 " My Bundles here: {{{
 NeoBundle 'tpope/vim-sensible'
 NeoBundle 'Shougo/neosnippet.vim'
 NeoBundle 'Shougo/neosnippet-snippets'
 NeoBundle 'tpope/vim-fugitive'
 NeoBundle 'tpope/vim-scriptease'
 NeoBundle 'tpope/vim-surround'
 NeoBundle 'ctrlpvim/ctrlp.vim'
 NeoBundle 'vim-ruby/vim-ruby'
 NeoBundle 'ervandew/supertab'
 NeoBundle 'myhere/vim-nodejs-complete'
 NeoBundle 'jsx/jsx.vim.git'
 NeoBundle 'junegunn/vim-easy-align'
 NeoBundle 'scrooloose/nerdtree'
 NeoBundle 'Xuyuanp/nerdtree-git-plugin'
 NeoBundle 'Raimondi/delimitMate'
 NeoBundle 'vim-scripts/closetag.vim'
 NeoBundle 'pages-alex-alex2006hw/vim-matchit'
 NeoBundle 'bling/vim-airline'
 NeoBundle 'powerline/powerline'
 NeoBundle 'airblade/vim-gitgutter'
 NeoBundle 'mhinz/vim-signify'
 NeoBundle 'ryanoasis/vim-devicons'
 NeoBundle 'ryanoasis/vim-webdevicons'
 NeoBundle 'vim-scripts/Highlight-UnMatched-Brackets'
 NeoBundle 'vim-scripts/matchparenpp'
 NeoBundle 'tpope/vim-vividchalk'
 NeoBundle 'godlygeek/csapprox'
 NeoBundle 'godlygeek/tabular'
 NeoBundle 'junegunn/rainbow_parentheses.vim'
 NeoBundle 'mileszs/ack.vim'
 let g:ackprg = 'ag --nogroup --nocolor --column'

 " vim essentials {{{
 " http://code.tutsplus.com/series/vim-essential-plugins--net-19224
 " Triggers: \w \ge \k
 NeoBundle 'Lokaltog/vim-easymotion'
 NeoBundle 'tpope/vim-surround'
" div.class > h1 then ctrl-e to expand
 NeoBundle 'rstacruz/sparkup'
 NeoBundle 'scrooloose/nerdtree'
" }}}

" ctrl_ toggle comments {{{
NeoBundle 'tomtom/tcomment_vim'
" }}}

 " look and feel {{{
 NeoBundle 'fun-alex-alex2006hw/vim-daylight'
 NeoBundle 'flazz/vim-colorschemes'
 NeoBundle 'rodnaph/vim-color-schemes'
 NeoBundle 'junegunn/limelight.vim'
 " }}}

" Vimshell {{{
 NeoBundle 'Shougo/vimshell', { 'rev' : '3787e5' }
" }}}
" }}}

call neobundle#end()
 " Required:
 filetype plugin indent on

 " If there are uninstalled bundles found on startup,
 " this will conveniently prompt you to install them.
 NeoBundleCheck

    " General hooks {{{

    " Automatically strip trailing whitespace from most regular source code file
    " types using a custom function.
    autocmd BufWritePre,FileWritePre *.rake,*.html,*.haml,*.rb,*.php,*.xml,*.erb,*.yml,*.scss,*.css,*.js,*.coffee call StripTrailingWhitespace()

    " Resize all windows to optimum distribution whenever Vim itself (the
    " terminal window it lives in) is resized.
    autocmd VimResized * wincmd =

    " Disable paste mode when leaving insert mode.
    autocmd InsertLeave * set nopaste

    " When changing this file, always immediately reload it.
    autocmd BufWritePost .vimrc source $MYVIMRC

    " }}}

    " Ruby {{{

    " Silly Rubyists with their silly extensions. Treat the whole lot of 'em as
    " Ruby files.
    autocmd BufNewFile,BufRead {Gemfile,Guardfile,Capfile,Rakefile,Thorfile,config.ru,Vagrantfile,*.prawn} set filetype=ruby
    autocmd BufNewFile,BufRead Gemfile.lock,Procfile set filetype=yaml
    autocmd BufNewFile,BufRead *_spec.rb set filetype=rspec.ruby

    " Run Ruby files either directly or in a tmux split pane using Vimux.
    autocmd Filetype ruby nnoremap <buffer> <Leader>r :!ruby %<CR>
    autocmd Filetype ruby nnoremap <buffer> <leader>R :cexpr system('rubocop '. expand('%'))<CR>
    autocmd Filetype ruby nnoremap <buffer> <Leader>vr :call VimuxRunCommand("clear; ruby " . bufname("%"))<CR>
    autocmd FileType ruby setlocal path+=lib/**
    autocmd FileType ruby setlocal includeexpr=substitute(substitute(substitute(v:fname,'::','/','g'),'$','.rb',''),'\\(\\<\\u\\l\\+\\\\|\\l\\+\\)\\(\\u\\)','\\l\\1_\\l\\2','g')
    " Set up custom Ruby surround mapping to wrap a motion in an expect call or
    " block.
    autocmd FileType ruby let g:surround_{char2nr("x")} = "expect(\r).to"
    autocmd FileType ruby let g:surround_{char2nr("X")} = "expect { \r }.to"

    " }}}

    " Javascript {{{

    " Run javascript files with Node either directly or in a split tmux pane
    " using Vimux.
    autocmd Filetype javascript nnoremap <buffer> <Leader>r :!node %<CR>
    autocmd Filetype javascript nnoremap <buffer> <Leader>vr :call VimuxRunCommand("clear; node " . bufname("%"))<CR>
    autocmd Filetype coffee nnoremap <buffer> <Leader>r :CoffeeRun<CR>

    " Treat JSON file as javascript
    autocmd BufNewFile,BufRead *.json setlocal filetype=javascript

    " Be smart about JSON formatting
    autocmd FileType json setlocal equalprg=python\ -m\ json.tool

    " }}}

    " Plain text, Markdown and markup {{{

    " For text and markup files do not show special characters and hard-wrap
    " text. Limit markdown and text files at 80 characters wide.
    autocmd FileType text,markdown,html,xhtml,eruby setlocal wrap linebreak nolist
    autocmd Filetype text,markdown setlocal textwidth=80

    " }}}

    " Other languages {{{

    autocmd Filetype elixir nnoremap <buffer> <Leader>r :!elixir %<cr>
    autocmd Filetype elixir nnoremap <buffer> <Leader>k :!mix test %<cr>
    autocmd Filetype python nnoremap <buffer> <Leader>r :!python %<cr>

    " Add Railsy file extensions to the suffixes list to enable find and gf to
    " jump to Sass stylesheets.
    autocmd FileType scss setlocal suffixesadd+=.css.scss
    autocmd BufNewFile,BufRead .tmux.conf*,tmux.conf* set filetype=tmux

    " }}}

" Time-of-day colorscheme {{{
let g:daylight_morning_color_gvim = "Tomorrow"
let g:daylight_afternoon_color_gvim = "solarized"
let g:daylight_evening_color_gvim = "Tomorrow-Night"
let g:daylight_late_color_gvim = "jellybeans"

let g:daylight_morning_color_term = "Tomorrow"
let g:daylight_afternoon_color_term = "mayansmoke"
let g:daylight_evening_color_term = "Tomorrow-Night"
let g:daylight_late_color_term = "jellybeans"
" set time-of-day
let g:daylight_late_hour = 22
let g:daylight_morning_hour = 6
let g:daylight_afternoon_hour = 12
let g:daylight_evening_hour = 18
" }}}

  augroup END

endif

" }}}

" Bundle Configurations {{{
" YouCompleteMe
let g:ycm_global_ycm_extra_conf = "~/.vim/ycm_extra_conf.py"

" closetag config
autocmd FileType html,htmldjango,jinjahtml,eruby,mako let b:closetag_html_style=1
autocmd FileType html,xhtml,xml,htmldjango,jinjahtml,eruby,mako source ~/.vim/bundle/closetag.vim/plugin/closetag.vim

" Nerdtree config
map <C-n> :NERDTreeToggle<CR>

let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ "Unknown"   : "?"
    \ }
" }}}

" Utility scripts {{{

"   Tab2Space and Space2Tab {{{
:command! -range=% -nargs=0 Tab2Space execute '<line1>,<line2>s#^\t\+#\=repeat(" ", len(submatch(0))*' . &ts . ')'
:command! -range=% -nargs=0 Space2Tab execute '<line1>,<line2>s#^\( \{'.&ts.'\}\)\+#\=repeat("\t", len(submatch(0))/' . &ts . ')'
" }}}

" }}}

" }}}

" Skeleton boilderplates {{{
 autocmd BufNewFile *.html       0r ~/.vim/skel/skel.html
 autocmd BufNewFile *.jsx       0r ~/.vim/skel/skel.jsx
 " }}}
" vim:foldmethod=marker:foldlevel=0
