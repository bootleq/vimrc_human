" Vim configure file
" Author: bootleq <bootleq@gmail.com>
" Blog:   bootleq.blogspot.com
" ============================================================================


" Startup:                 {{{1 ==============================================

if has('vim_starting')
  set all&
  set nocompatible
  mapclear
  mapclear!
endif

augroup my_vimrc
  autocmd!
augroup END

let &termencoding = &encoding
set encoding=utf-8
set fileencodings=usc-bom,utf-8,big5,taiwan,chinese,default,latin1
language messages POSIX
filetype plugin indent on


function! s:SID_PREFIX()
  return matchstr(expand('<sfile>'), '<SNR>\d\+_')
endfunction

let s:i = {}

" }}}1   Startup                ==============================================


" Plugin Bundles:                 {{{1 =======================================

" Setup {{{2

if has('vim_starting')
  if has("gui_win32")
    if isdirectory(fnamemodify('c:\cygwin\home\admin\.vim', ':p'))
      let s:rtp = 'c:\cygwin\home\admin\.vim'
    else
      " g:win32_gvim_rtp should be set by gvimrc
      if exists('g:win32_gvim_rtp') && isdirectory(fnamemodify(g:win32_gvim_rtp, ':p'))
        let s:rtp = g:win32_gvim_rtp
      else
        echoerr "You must set runtimepath (for plugin bundling) manually."
        finish
      endif
    endif
  elseif expand("<sfile>") == '/etc/users/bootleq/.vimrc'
        \  && substitute(system("whoami"), '\n$', '', '') != 'bootleq'
        \  && !exists("g:did_bootleq_runtime")
    let g:did_bootleq_runtime = 1
    let s:rtp = "/etc/users/bootleq/.vim"
  elseif expand("<sfile>") == '/tmp/vimrc_human/bootleq/.vimrc'
        \  && !exists("g:did_vimrc_human_runtime")
    let g:did_vimrc_human_runtime = 1
    let s:rtp = "/tmp/vimrc_human/bootleq/.vim"
  else
    let s:rtp = "~/.vim"
  endif

  if !isdirectory(fnamemodify(s:rtp, ':p'))
    try
      call mkdir(fnamemodify(s:rtp, ':p'), "p")
    catch /^Vim\%((\a\+)\)\=:E739/
      echoerr "Error detected while processing: " . v:throwpoint . ":\n  " . v:exception .
            \  "\nCan't make runtime directory. Skipped sourcing vimrc.\n"
      finish
    endtry
  endif

  execute "set runtimepath+=" . fnamemodify(s:rtp, ':p') . "bundle/neobundle.vim"
endif

set runtimepath-=~/.vim

try
  call neobundle#begin(fnamemodify(s:rtp, ':p') . "bundle")
catch /^Vim\%((\a\+)\)\=:E117/
  echoerr "Error detected while processing: " . v:throwpoint . ":\n  " . v:exception .
        \ "\n\nNo 'Bundle plugin' installed for this vimrc. Skipped sourcing plugins." .
        \ "\n\nTo install one:\n  " .
        \ "git clone http://github.com/Shougo/neobundle.vim.git " . fnamemodify(s:rtp, ":p") . "bundle/neobundle.vim\n"
  finish
endtry

" }}}2    Bundles   {{{2
let s:bundles = []
let s:bundles += [
      \   ['kana/vim-smartinput', {":skip": 1}],
      \   ['Raimondi/delimitMate'],
      \   ['kana/vim-surround'],
      \   ['kana/vim-repeat'],
      \   ['kana/vim-fakeclip'],
      \   ['h1mesuke/vim-alignta'],
      \   ['Shougo/neosnippet'],
      \   ['Shougo/vimfiler'],
      \   ['thinca/vim-prettyprint'],
      \   ['thinca/vim-qfreplace'],
      \   ['mojako/ref-sources.vim'],
      \   ['bootleq/vim-ref-bingzh', {":prefer_local": 1}],
      \   ['tpope/vim-rails'],
      \   ['tpope/vim-tbone', {":skip": 1}],
      \   ['tpope/vim-fugitive'],
      \   ['mattn/webapi-vim'],
      \   ['mattn/wwwrenderer-vim'],
      \   ['thinca/vim-ref'],
      \   ['tyru/open-browser.vim'],
      \   ['tyru/vim-altercmd'],
      \   ['wokmarks.vim'],
      \   ['bootleq/ShowMarks', {":prefer_local": 1}],
      \   ['bootleq/camelcasemotion'],
      \   ['bootleq/gsession.vim'],
      \   ['tomtom/tcomment_vim'],
      \   ['bootleq/vim-color-bootleg'],
      \   ['bootleq/vim-cycle', {":prefer_local": 1}],
      \   ['bootleq/vim-tabline', {":prefer_local": 1}],
      \   ['bootleq/vim-gitdiffall', {":prefer_local": 1}],
      \   ['bootleq/vim-hardmotion', {":skip": 1, ":prefer_local": 1}],
      \   ['rking/ag.vim'],
      \   ['Indent-Guides'],
      \   ['osyo-manga/vim-anzu', {':skip': 0, ":prefer_local": 0}],
      \   ['justinmk/vim-sneak', {':skip': 0}],
      \   ['Lokaltog/vim-easymotion'],
      \   ['t9md/vim-choosewin'],
      \   ['Valloric/YouCompleteMe', {':skip': 1}],
      \   ['netrw.vim'],
      \   ['bootleq/LargeFile', {":prefer_local": 1}],
      \   ['VisIncr'],
      \   ['majutsushi/tagbar'],
      \ ]
" filetype {{{3
let s:bundles += [
      \   ['leshill/vim-json', {':filetypes': ['json']}],
      \   ['depuracao/vim-rdoc', {':filetypes': ['rdoc']}],
      \   ['jiangmiao/simple-javascript-indenter', {':filetypes': ['javascript']}],
      \   ['hail2u/vim-css3-syntax', {':filetypes': ['css']}],
      \   ['httplog', {':filetypes': ['httplog']}],
      \   ['nginx.vim', {':filetypes': ['nginx']}],
      \   ['othree/html5.vim', {':filetypes': ['html']}],
      \   ['plasticboy/vim-markdown', {':filetypes': ['markdown']}],
      \   ['timcharper/textile.vim', {':filetypes': ['textile']}],
      \   ['tpope/vim-haml', {':filetypes': ['haml']}],
      \   ['vim-ruby/vim-ruby', {':filetypes': ['ruby']}],
      \   ['bootleq/vim-ruby-enccomment', {':filetypes': ['ruby'], ":prefer_local": 1}],
      \ ]
" }}}3 text-objs {{{3
let s:bundles += [
      \   ['kana/vim-textobj-user'],
      \   ['kana/vim-textobj-diff'],
      \   ['kana/vim-textobj-fold'],
      \   ['kana/vim-textobj-indent'],
      \   ['kana/vim-textobj-line'],
      \   ['kana/vim-textobj-function'],
      \   ['thinca/vim-textobj-function-javascript'],
      \   ['sgur/vim-textobj-parameter'],
      \   ['kana/vim-textobj-jabraces'],
      \   ['thinca/vim-textobj-between'],
      \   ['saihoooooooo/vim-textobj-space'],
      \   ['osyo-manga/vim-textobj-multitextobj'],
      \   ['nelstrom/vim-textobj-rubyblock'],
      \   ['bootleq/vim-textobj-rubysymbol'],
      \   ['coderifous/textobj-word-column.vim', {':skip': 1}],
      \ ]
" }}}3 operator-user {{{3
let s:bundles += [
      \   ['kana/vim-operator-user'],
      \   ['kana/vim-operator-replace'],
      \   ['tyru/operator-html-escape.vim'],
      \ ]
" }}}3 gf-user {{{3
let s:bundles += [
      \   ['kana/vim-gf-user', {":skip": 0}],
      \ ]
" }}}3 unite {{{3
let s:bundles += [
      \   ['Shougo/unite.vim'],
      \   ['Shougo/unite-session'],
      \   ['Shougo/unite-outline'],
      \   ['Shougo/neomru.vim'],
      \   ['tacroe/unite-mark'],
      \   ['thinca/vim-unite-history'],
      \   ['tsukkee/unite-help', {"rev": 'tags-caching'}],
      \   ['ujihisa/unite-gem'],
      \   ['kmnk/vim-unite-giti', {":skip": 1}],
      \ ]
" }}}3 neocomplete {{{3
if has('lua') && (v:version > 703 || (v:version == 703 && has('patch885')))
  let s:bundles += [['Shougo/neocomplete']]
else
  let s:bundles += [['Shougo/neocomplcache']]
endif
" }}}3 unused {{{3
" let s:bundles += [
"       \   ['L9', {"stay_same": 1}],
"       \   ['FuzzyFinder'],
"       \   ['gregsexton/gitv'],
"       \   ['mrkn256.vim'],
"       \   ['chrisbra/histwin.vim'],
"       \   ['Raimondi/delimitMate'],
"       \   ['tyru/restart.vim'],
"       \   ['tpope/vim-speeddating'],
"       \   ['sjl/threesome.vim'],
"       \   ['thinca/vim-ambicmd'],
"       \   ['kana/vim-fakeclip'],
"       \   ['kana/vim-grex'],
"       \   ['tyru/vim-capture'],
"       \   ['CountJump'],
"       \   ['AndrewRadev/splitjoin.vim'],
"       \   ['Shougo/vimshell'],
"       \   ['taglist.vim', {'lazy': 1}],
"       \   ['kana/vim-smartword'],
"       \   ['PAntoine/vimgitlog'],
"       \ ]
" }}}3

for s:i.dir in ['~/repository/', 'D:/repository/']
  if isdirectory(fnamemodify(s:i.dir, ':p'))
    let s:bundle_local_repo_dir = s:i.dir
  endif
endfor
let s:bundle_local_repo_dir = expand(get(s:, 'bundle_local_repo_dir', ''))

NeoBundleFetch 'Shougo/neobundle.vim'

for s:i.bundle in s:bundles
  let s:tmp_options = get(s:i.bundle, 1, {})
  if get(s:tmp_options, ":skip")
    continue
  elseif get(s:tmp_options, ":prefer_local")
    if isdirectory(fnamemodify(s:bundle_local_repo_dir . split(s:i.bundle[0], '/')[-1], ':p'))
      call extend(s:tmp_options, {
            \   "base": s:bundle_local_repo_dir,
            \   "type": "nosync",
            \   "stay_same": 1
            \ })
    endif
  endif

  if type(get(s:tmp_options, ":filetypes")) == type([])
    call extend(s:tmp_options, {
          \   "lazy": 1,
          \   "autoload": {'filetypes': get(s:tmp_options, ":filetypes")}
          \ })
  endif

  call filter(s:tmp_options, "v:key[0] != ':'")
  execute "NeoBundle " . string(s:i.bundle[0]) . (empty(s:tmp_options) ? '' : ', ' . string(s:tmp_options))
endfor
unlet! s:bundles s:tmp_options

" }}}2    Finish   {{{2

call neobundle#end()
filetype plugin indent on

" }}}2

" }}}1   Plugin Bundles                =======================================


" Basic Options:               {{{1 ==========================================

" }}}2    檔案格式    {{{2

set fileformats=unix
set noendofline

" }}}2   GUI    {{{2

if has("gui_running")
  set antialias
  source $VIMRUNTIME/delmenu.vim
  set langmenu=zh_TW.UTF-8
  source $VIMRUNTIME/menu.vim
  set fileformats+=dos

  set guioptions=gri
  let did_install_default_menus = 1
  let did_install_syntax_menu = 1
  let do_syntax_sel_menu = 1
  let no_buffers_menu = 1
  let bmenu_max_pathlen = 50

  if has("gui_win32")
    set guifont=Consolas:h11,\ Monaco:h10
    set guifontwide=Consolas:h11
    " set guifontwide=Microsoft\ JhengHei,\ Meiryo,\ cwTeXMing
    set winaltkeys=no
  elseif has("gui_macvim")
    set guifont=Consolas:h14,\ Monaco:h14
    set guifontwide=Consolas:h14
    " set guifontwide=Microsoft\ JhengHei,\ Meiryo,\ cwTeXMing
    set winaltkeys=no
  else
    set guifont=Liberation\ Mono\ 12
    " set guifont=Consolas\ 14
    " set guifont=Monospace\ 12
    " set guifontwide=文泉驛等寬微米黑\ 12
    set guifontwide=AR\ PL\ UMing\ TW\ MBE\ 12
  endif
endif

" }}}2    Vim 記憶選項   {{{2

set history=666
" set viminfo='20,<50,s10,h
set viewoptions=folds,cursor
set updatetime=10000
set noswapfile
set directory-=.
set backupdir-=.
set nowritebackup
set updatecount=0

" }}}2    term 相關調整     {{{2

set ttyfast

if &term =~ "xterm"
  set t_#4=[D   " C-Left   視環境調整
  set t_%i=[C   " C-Right  視環境調整
  set t_Co=256

  " MinTTy 游標形狀
  if $OSTYPE == 'cygwin'
    let &t_ti.="\e[1 q"
    let &t_SI.="\e[5 q"
    let &t_EI.="\e[1 q"
    let &t_te.="\e[0 q"
  endif
endif

" }}}2    排版、縮排    {{{2

set expandtab tabstop=2 softtabstop=2 shiftwidth=2 autoindent smartindent smarttab
set shiftround
set cinkeys-=:
set cinoptions+=(0
set textwidth=78
try
  set breakindent
catch /^Vim\%((\a\+)\)\=:E518/
endtry

try
  setlocal formatoptions=roql2mj
catch /^Vim\%((\a\+)\)\=:E539/
  setlocal formatoptions=roql2m
endtry
" NOTE foldmethod can be local, but I prefer global setting
if &foldmethod == 'manual'
  set foldmethod=marker
endif

" }}}2    編輯功能    {{{2

set mouse=nvi
set virtualedit=block
set clipboard=autoselect,exclude:cons\|linux
set tildeop
set backspace=indent,eol,start
set whichwrap=b,s,<,>,[,]
set nojoinspaces
set nrformats=hex
set nostartofline

set scrolloff=10
set sidescrolloff=40
set sidescroll=1
set scrollopt=ver,hor,jump

set timeoutlen=4000

" }}}2    顯示、外觀    {{{2

set cursorline
set number
set hlsearch
nohlsearch
set ruler
set showcmd
set shortmess+=I

if v:version >= 704 || (v:version == 703 && has('patch314'))
  set shortmess+=c
endif

set nolinebreak
set display=lastline
set listchars=tab:>-,eol:¬,trail:*,extends:»,precedes:«
set background=dark
set ambiwidth=single
" set ambiwidth=double
syntax on

if v:version > 704 || (v:version == 704 && has('patch88'))
else
  " http://blogger.godfat.org/2011/07/spellcheck-only-for-english-in-vim.html
  syntax match Normal /[^!-~]/ contains=@NoSpell
endif

autocmd Syntax * syntax match FullWidthSpace /\%d12288/ containedin=ALL
autocmd Syntax * highlight FullWidthSpace gui=NONE guibg=blue cterm=bold ctermbg=blue

if !exists('g:colors_name')
  set background=dark
  colorscheme bootleg
endif

set title titlestring=%t%(\ %M%)%(\ (%{expand(\"%:~:.:h\")})%)%(\ %a%)
set statusline=%<%f\ %h%m%r%w%=%-14.(%l,%c%V%)\ %P
" set statusline=%<%f\ %h%m%r%w%=[%{&undolevels}]\ %-14.(%l,%c%V%)\ %P
" set laststatus=2
set showtabline=2

" }}}2    尋找、搜尋    {{{2

if $OSTYPE == 'cygwin'
  " set cdpath+=/cygdrive/g/web/
  " set path+=/home/www/
elseif $OSTYPE == 'linux-gnu'
  set cdpath+=/home/www/
  set path+=/home/www/
endif

" set autochdir
set ignorecase
set smartcase
set incsearch
set matchpairs+=<:>
" https://github.com/lilydjwg/dotvim/commit/880fc3b
try
  set matchpairs+=《:》,〈:〉,［:］,（:）,「:」,『:』,‘:’,“:”
catch /^Vim\%((\a\+)\)\=:E474/
endtry
" set includeexpr=substitute(v:fname,'\\.','/','g')

" }}}2    自動完成    {{{2

set omnifunc=syntaxcomplete#Complete
set pumheight=20
set menuitems=35
set completeopt=longest,menu
set complete+=U
set showfulltag

set wildmenu
set wildmode=longest:full,full
set wildoptions=tagfile
" set wildignore+=*.o,*.a,*.so,*.obj,*.exe,*.lib,*.ncb,*.opt,*.plg,.svn,.git

" }}}2   多檔案編輯    {{{2

set splitbelow
set splitright
set noequalalways
set previewheight=9
set switchbuf=useopen,usetab,newtab
set tabpagemax=400
set diffopt+=vertical,context:4,foldcolumn:1

" }}}2   Vim 7.3 / 7.4    {{{2

if version >= 703
  set conceallevel=1
  set concealcursor=nc
  set colorcolumn=+1
  set cinoptions+=L0
  set undofile
  set undodir=~/.vim/undofiles
  if !isdirectory(&undodir)
    call mkdir(&undodir, "p")
  endif
  map  <C-ScrollWheelDown> <ScrollWheelRight>
  map  <C-ScrollWheelUp>   <ScrollWheelLeft>
  imap <C-ScrollWheelDown> <ScrollWheelRight>
  imap <C-ScrollWheelUp>   <ScrollWheelLeft>
  if exists('+regexpengine')
    set regexpengine=0
  endif

  try
    setlocal formatoptions+=j
  catch /^Vim\%((\a\+)\)\=:E539/
  endtry
endif

" }}}2

" }}}1   Basic Options              ==========================================


" Mappings:             {{{1 =================================================

let maplocalleader = ","
noremap  <Leader><LocalLeader> <LocalLeader>
noremap! <Leader><LocalLeader> <LocalLeader>
noremap  <LocalLeader>, <C-\><C-N>
noremap! <LocalLeader>, <C-\><C-N>
snoremap <LocalLeader>, <C-\><C-N>

"   各種移動    {{{2

" noremap <expr> <Space>  repeat('<ScrollWheelDown>', 2)
" nnoremap <expr> <LocalLeader><Space> repeat('<ScrollWheelUp>', 2)
nnoremap <expr> <Space>  <SID>scroll_down()
nnoremap <expr> <LocalLeader><Space> <SID>scroll_up()
xnoremap <expr> <Space>  <SID>scroll_down('v')
xnoremap <expr> <LocalLeader><Space> <SID>scroll_up('v')

for s:i.map_mode in ['n', 'o', 'x']
  execute s:i.map_mode . "noremap j gj"
  execute s:i.map_mode . "noremap k gk"
  execute s:i.map_mode . "noremap gj j"
  execute s:i.map_mode . "noremap gk k"
endfor

inoremap <expr> <Down> pumvisible() ? "\<C-N>" : "\<C-O>gj"
inoremap <expr> <Up> pumvisible() ? "\<C-P>" : "\<C-O>gk"

nmap <silent><Home> :call SmartHome("n")<CR>
nmap <silent><End> :call SmartEnd("n")<CR>
imap <silent><Home> <C-R>=SmartHome("i")<CR>
imap <silent><End> <C-R>=SmartEnd("i")<CR>
vmap <silent><Home> <Esc>:call SmartHome("v")<CR>
vmap <silent><End> <Esc>:call SmartEnd("v")<CR>

nnoremap <silent> <LocalLeader>I :call SmartHome("n")<CR>
nnoremap <silent> <LocalLeader>A :call SmartEnd("n")<CR>

map  <kHome> <Home>
map! <kHome> <Home>
map  <kEnd>  <End>
map! <kEnd>  <End>

nnoremap ' `

nmap <LocalLeader>w <C-W>
nnoremap <C-W>gf :tab wincmd f<CR>
nnoremap <C-W>V :wincmd K <Bar> wincmd =<CR>
nnoremap <LocalLeader>gf :tab wincmd f<CR>
nnoremap <expr> <CR> &modifiable ? "i<CR><C-\><C-N>" : "<C-]>"
nnoremap <expr> <BS> &modifiable ? "i<C-W><C-\><C-N>" : "<C-O>"

nnoremap gr gT
nnoremap <silent> gT :tablast<CR>
nnoremap <silent> gR :tabfirst<CR>
nnoremap <silent> <expr> <LocalLeader>gt printf(":tabmove %s<CR>", tabpagenr() == tabpagenr('$') ? 0 : tabpagenr())
nnoremap <silent> <expr> <LocalLeader>gr printf(":tabmove %s<CR>", tabpagenr() == 1 ? '' : tabpagenr() - 2)
nnoremap <silent> <LocalLeader>gT :tabmove<CR>
nnoremap <silent> <LocalLeader>gR :tabmove 0<CR>

" Scroll to top/center/bottom (@Shougo)
noremap <expr> zz (winline() == (winheight(0)+1)/ 2) ?
      \ 'zt' : (winline() == 1)? 'zb' : 'zz'

" }}}2   編輯    {{{2

nmap <C-H> <BS>
nnoremap p ]p
nnoremap Y y$
nnoremap vaa ggVG
nnoremap <LocalLeader>gv V`]

autocmd FileType qf nnoremap <buffer> <CR> <CR>

nnoremap <LocalLeader>< i0<C-D><C-\><C-N>
inoremap <LocalLeader>< 0<C-D>
xnoremap <LocalLeader>< 99<

inoremap <C-Z> <C-O>u
inoremap <C-W> <C-G>u<C-W>
inoremap <expr> <C-U> (pumvisible() ? "\<C-E>" : '') . "\<C-G>u\<C-U>"

nnoremap <LocalLeader>u <C-R>

inoremap <LocalLeader>o <C-O>
inoremap <LocalLeader>r <C-R>
cnoremap <LocalLeader>r <C-R>

noremap <silent> <C-S> :update<CR>
inoremap <silent> <C-S> <C-\><C-N>:update<CR>
xnoremap <silent> <C-S> <C-\><C-N>:update<CR>

noremap <C-Del> :quit<CR>
noremap <C-kDel> :quit<CR>
map <kDel> <Del>

" TODO command mode text-object delete
" noremap! <LocalLeader>w

cnoremap <LocalLeader>; <C-W>

" Delete to end, from @tyru https://github.com/tyru/dotfiles
cnoremap <LocalLeader>d <C-\>e getcmdpos() == 1 ? '' : getcmdline()[:getcmdpos()-2]<CR>

" Auto escape / and ? in search command (@Shougo)
cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'
cnoremap <expr> ? getcmdtype() == '?' ? '\?' : '?'

" Switch between /\<keyword\> and /keyword
nnoremap <expr> <LocalLeader>/ getreg('/') =~ '^\\<.*\\>$' ?
      \   '/' . matchstr(getreg('/'), '^\\<\zs.*\ze\\>$') :
      \   '/\<' . getreg('/') . '\>'

" }}}2   功能鍵    {{{2

noremap  <F1> :help <C-R>=expand('<cword>')<CR><CR>
noremap  <LocalLeader><F1> :tab help <C-R>=expand('<cword>')<CR><CR>
xnoremap <F1> :<C-U>call SaveReg()<CR>gvy:let b:tempReg=@"<CR>:call RestoreReg()<CR>:help <C-R>=b:tempReg<CR><CR>
xnoremap <LocalLeader><F1> :<C-U>call SaveReg()<CR>gvy:let b:tempReg=@"<CR>:call RestoreReg()<CR>:tab help <C-R>=b:tempReg<CR><CR>

nnoremap <F2> :%s/<C-R><C-W>
xnoremap <F2> :<C-U>call SaveReg()<CR>gvy:let b:tempReg=@"<CR>:call RestoreReg()<CR>gv:<C-U>%s/\V<C-R>=escape(b:tempReg, '/')<CR>/

noremap <silent> <F3> :nohlsearch<CR>
inoremap <silent> <F3> <C-O>:nohlsearch<CR>
" TODO use Vim 7.4.079 v:hlsearch to eliminate <F4> mapping
noremap <silent> <F4> :set hlsearch<CR>
inoremap <silent> <F4> <C-O>:set hlsearch<CR>

nnoremap <F5> :call SynStackInfo()<CR>
nnoremap <Leader><F5> :tabdo e!<CR>
nnoremap <F6> :QuickOff<CR>
nnoremap <LocalLeader><F6> :tabclose<CR>

if v:version > 704 || (v:version == 704 && has('patch88'))
  nnoremap <silent><F8> :setlocal spell! spelllang=en_us,cjk spell?<CR>
  xnoremap <silent><F8> :<C-U>setlocal spell! spelllang=en_us,cjk spell?<CR>gv
  inoremap <silent><F8> <C-O>:setlocal spell! spelllang=en_us,cjk spell?<CR>
else
  nnoremap <silent><F8> :setlocal spell! spelllang=en_us spell?<CR>
  xnoremap <silent><F8> :<C-U>setlocal spell! spelllang=en_us spell?<CR>gv
  inoremap <silent><F8> <C-O>:setlocal spell! spelllang=en_us spell?<CR>
endif

set pastetoggle=<F11>
map  <silent> <F12> :set list!<CR>
imap <silent> <F12> <C-O>:set list!<CR>

" }}}2   自動完成    {{{2

cnoremap <LocalLeader>. <C-E>
cnoremap <LocalLeader><CR> <C-E>

inoremap <LocalLeader>. <C-X><C-O>
inoremap <expr> <C-J> pumvisible() ? "\<C-N>" : "\<C-J>"
inoremap <expr> <C-K> pumvisible() ? "\<C-P>" : "\<C-K>"

" }}}2   Quickfix    {{{2

" Ref: kana - https://github.com/kana/config
" Note: -- Ex-mode will be never used and recordings are rarely used.
nmap q [quickfix]
nmap [quickfix]w [localist]
nnoremap [quickfix] <Nop>
nnoremap [localist] <Nop>
nnoremap Q q

" Quickfix list  {{{3
nnoremap <silent> [quickfix]j :cnext<CR>
nnoremap <silent> [quickfix]k :cprevious<CR>
nnoremap <silent> [quickfix]r :crewind<CR>
nnoremap <silent> [quickfix]K :cfirst<CR>
nnoremap <silent> [quickfix]J :clast<CR>
nnoremap <silent> [quickfix]l :clist<CR>
nnoremap <silent> [quickfix]o :copen<CR>
nnoremap <silent> [quickfix]c :cclose<CR>
nnoremap <silent> [quickfix]p :colder<CR>
nnoremap <silent> [quickfix]n :cnewer<CR>
" }}} Location list  {{{3
nnoremap <silent> [localist]j :lnext<CR>
nnoremap <silent> [localist]k :lprevious<CR>
nnoremap <silent> [localist]r :lrewind<CR>
nnoremap <silent> [localist]K :lfirst<CR>
nnoremap <silent> [localist]J :llast<CR>
nnoremap <silent> [localist]l :llist<CR>
nnoremap <silent> [localist]o :lopen<CR>
nnoremap <silent> [localist]c :lclose<CR>
nnoremap <silent> [localist]p :lolder<CR>
nnoremap <silent> [localist]n :lnewer<CR>
" }}}

" }}}2   User text objects    {{{2

let g:textobj_rubyblock_no_default_key_mappings = 1
" TODO 那如果不是 ruby 的話咧？
function! s:textobj_rubyblock_settings()
  xmap <buffer> ab <Plug>(textobj-rubyblock-a)
  omap <buffer> ab <Plug>(textobj-rubyblock-a)
  xmap <buffer> ib <Plug>(textobj-rubyblock-i)
  omap <buffer> ib <Plug>(textobj-rubyblock-i)
endfunction
autocmd! my_vimrc FileType ruby call s:textobj_rubyblock_settings()

let g:textobj_space_no_default_key_mappings = 1
xmap a<Space> <Plug>(textobj-space-a)
omap a<Space> <Plug>(textobj-space-a)
xmap i<Space> <Plug>(textobj-space-i)
omap i<Space> <Plug>(textobj-space-i)

let g:textobj_between_no_default_key_mappings = 1
xmap a/ <Plug>(textobj-between-a)
omap a/ <Plug>(textobj-between-a)
xmap i/ <Plug>(textobj-between-i)
omap i/ <Plug>(textobj-between-i)

let g:textobj_parameter_no_default_key_mappings = 1
xmap a; <Plug>(textobj-parameter-a)
omap a; <Plug>(textobj-parameter-a)
xmap i; <Plug>(textobj-parameter-i)
omap i; <Plug>(textobj-parameter-i)

let g:textobj_jabraces_no_default_key_mappings = 1
let s:textobj_multitextobj_textobjects_group_base_paren = [
      \   '%(',
      \   '%[',
      \   "\<Plug>(textobj-jabraces-parens-%)",
      \   "\<Plug>(textobj-jabraces-kakko-%)",
      \   "\<Plug>(textobj-jabraces-double-kakko-%)",
      \   "\<Plug>(textobj-jabraces-yama-kakko-%)",
      \   "\<Plug>(textobj-jabraces-double-yama-kakko-%)",
      \   "\<Plug>(textobj-jabraces-sumi-kakko-%)",
      \ ]
let g:textobj_multitextobj_textobjects_group_i = {
      \   "paren": map(
      \     copy(s:textobj_multitextobj_textobjects_group_base_paren),
      \     'substitute(v:val, "%", "i", "")'
      \   )
      \ }
let g:textobj_multitextobj_textobjects_group_a = {
      \   "paren": map(
      \     copy(s:textobj_multitextobj_textobjects_group_base_paren),
      \     'substitute(v:val, "%", "a", "")'
      \   )
      \ }
omap <expr> a. textobj#multitextobj#mapexpr_a("paren")
vmap <expr> a. textobj#multitextobj#mapexpr_a("paren")
omap <expr> i. textobj#multitextobj#mapexpr_i("paren")
vmap <expr> i. textobj#multitextobj#mapexpr_i("paren")

" }}}2   User operators    {{{2

for s:i.map_mode in ['n', 'x']
  execute s:i.map_mode . "map <LocalLeader>r               <Plug>(operator-replace)"
  execute s:i.map_mode . "map <LocalLeader>r<LocalLeader>r <Plug>(operator-replace)Vl"
  execute s:i.map_mode . "map <LocalLeader>R               <Plug>(operator-replace)$"
  execute s:i.map_mode . "map <LocalLeader>he              <Plug>(operator-html-escape)"
  execute s:i.map_mode . "map <LocalLeader>hd              <Plug>(operator-html-unescape)"
endfor

" }}}2   停用鍵、其他    {{{2

nmap ZZ <Nop>
nmap ZQ <Nop>
nnoremap <LocalLeader>md :<C-U>delmarks!<CR>
nnoremap m<LocalLeader>d :<C-U>delmarks!<CR>

" }}}2

" }}}1   Mappings              ==============================================


" Commands:             {{{1 =================================================

command! -bang EmptyFile call <SID>empty_file(<bang>0)
function! s:empty_file(with_sudo) "{{{
  if executable('cat')
    let result = system(printf(
          \   "!cat /dev/null | %s tee %s",
          \   a:with_sudo ? 'sudo' : '',
          \   shellescape(expand('%:p'))
          \ ))
    if v:shell_error
      echohl WarningMsg | echomsg printf("Error: %s.\n Try :EmptyFile! (<bang>)", result) | echohl None
    else
      checktime
    endif
  else
    echohl WarningMsg | echomsg "cat command not executable." | echohl None
  endif
endfunction "}}}

command! Rtouch call <SID>passenger_touch_restart()
command! Rnginx execute "!sudo\ service nginx restart"
function! s:passenger_touch_restart() "{{{
  if isdirectory('tmp')
    let result = system("touch tmp/restart.txt")
    if v:shell_error
      echohl WarningMsg | echomsg printf("Error: %s", result) | echohl None
    else
      echomsg "Touched."
    endif
  else
    echohl WarningMsg | echomsg "tmp directory not found." | echohl None
  endif
endfunction "}}}

" Ref: http://vim-users.jp/2009/05/hack17/
command! -nargs=1 -bang -complete=file Rename saveas<bang> <args> | call delete(expand('#'))

command! -nargs=1 -complete=file Touch !touch <args>

" Ref: kana - https://github.com/kana/config
command! -bar -complete=file -nargs=+ Grep call s:grep('grep', [<f-args>])
command! -bar -complete=file -nargs=+ Lgrep call s:grep('lgrep', [<f-args>])
function! s:grep(command, args)
  execute a:command '/'.a:args[-1].'/' join(a:args[:-2])
endfunction

" Split and diff (@Shougo)
command! -nargs=1 -complete=file Diff vertical diffsplit <args>

" Echo range text or register content, for tmux manual yank
command! -nargs=? -range Echo <line1>,<line2>call s:echo(<f-args>)
function! s:echo(...) range "{{{
  if a:0
    let var = a:1
    if var =~ '^@\?'
      echo getreg(var[1:])
    else
      echo a:1
    endif
    return
  endif

  let save_sel = &selection
  let &selection = "inclusive"
  let save_reg = @@
  let mode = (a:firstline == a:lastline) ? 'n' : visualmode()

  if mode == 'n'
    silent execute a:firstline . "," . a:lastline . "y"
  elseif mode == 'c'
    silent execute a:1 . "," . a:2 . "y"
  else
    silent execute "normal! `<" . mode . "`>y"
  endif
  echo @@
  let &selection = save_sel
  let @@ = save_reg
endfunction "}}}

" }}}1    Commands             ===============================================


" Abbreviations:                     {{{1 ========================================

cnoreabbrev <expr> '<,'>q ((getcmdtype() == ':' && getcmdpos() <= 7) ? 'q' : "'<,'>q")
cnoreabbrev ll <lt>LocalLeader>
inoreabbrev ll <lt>LocalLeader>

" }}}1    Abbreviations             ==========================================


" Cscope:                  {{{1 ==============================================

if has("cscope") && filereadable("/usr/bin/cscope")
  set cscopeprg=/usr/bin/cscope
  set cscopetag
  set cscopetagorder=0
  set cscopeverbose
  set cscopequickfix=s-,c-,d-,i-,t-,e-
  if filereadable("cscope.out")
    silent cscope add cscope.out
  elseif $CSCOPE_DB != ""
    silent cscope add $CSCOPE_DB
  endif
  let s:outFiles = [
      \   '/home/www/cscope.out',
      \   '/home/www/include/cscope.out',
      \ ]
  for s:i.outFile in s:outFiles
    if filereadable(s:i.outFile)
      try
        silent execute 'cscope add ' . expand(s:i.outFile)
      catch /^Vim(cscope):E568:/
      endtry
    endif
  endfor
endif

" }}}1    Cscope            ==================================================


" Ctags:                  {{{1 ===============================================

" from hotoo http://gist.github.com/476387
let tlist_html_settings   = 'html;h:Headers;o:IDs;c:Classes'
let tlist_xhtml_settings   = 'html;h:Headers;o:IDs;c:Classes'
" let tlist_php_settings   = 'html;h:Headers;o:IDs;c:Classes'
" let tlist_javascript_settings = 'js;f:Functions;c:Classes;o:Objects'
let tlist_javascript_settings = 'javascript;f:Functions;c:Classes;o:Objects'
let tlist_css_settings = 'css;c:Classes;o:Objects(ID);t:Tags(Elements)'

set tags+=../tags,./*/tags
" if has("gui_running")
"   noremap <silent> <M-z> :TlistToggle<CR>
" else
"   noremap <silent> z :TlistToggle<CR>
" endif

" }}}1    Ctags            ===================================================


" Plugins:             {{{1 ==================================================

runtime! ftplugin/man.vim    " 啟用 |:Man| 指令
runtime! macros/matchit.vim

let g:loaded_getscriptPlugin = 1

" NeoBundle    {{{2

let g:neobundle#log_filename = expand(printf('~/.vim/%s.neobundlelog', strftime('%m%d-%H%M%S')))

noremap <Leader>gf :call BundleLogDiff("<C-R>=expand('<cword>')<CR>")<CR>
function! BundleLogDiff(rev)
  let patterns = {
        \   'name': '\[neobundle\/install] (.\+): |\(.\+\)|'
        \ }
  let bundle_name = ''
  let rev = a:rev
  let line = search(patterns.name, 'bnW')
  if line == 0
    echoerr printf("Can't find bundle name for rev %s.", rev)
    return
  endif
  let bundle_name = get(matchlist(getline(line), patterns.name), 1, '')
  let path = get(neobundle#get(bundle_name), 'path', '')
  if len(path) == 0
    echoerr printf("Can't get bundle with name %s.", bundle_name)
    return
  endif
  tabnew `=path . printf('/.bundle-gitdiffall-%s.vim', rev)`
  set nomodified
  setlocal buftype=nofile
  setlocal bufhidden=hide
  setlocal noswapfile
  setlocal nobuflisted
  execute 'Git diff-tree --no-commit-id --name-only -r ' . rev

  " TODO gitdiffall#get_diff_files(rev)
  " (git diff-tree --no-commit-id --name-only -r rev)
  " and export to unite.vim
endfunction

" Netrw    {{{2

call neobundle#config('netrw.vim', {
      \   'lazy': 1,
      \   'autoload': {
      \     'commands': 'Explore'
      \   }
      \ })
let bundle = neobundle#get('netrw.vim')
function! bundle.hooks.on_source(bundle)
  " let g:netrw_ftp = 1
  " let g:netrw_preview = 1
  " let g:netrw_ignorenetrc = 0
  " let g:netrw_ftpextracmd = 'passive'

  let g:netrw_liststyle = 3
  let g:netrw_winsize = 20
  " let g:netrw_browsex_viewer = '-'
  let g:netrw_timefmt = '%Y-%m-%d %T'
  " if exists("g:qfix_win") && a:forced == 0
  nmap <leader>e :Vexplore<CR>
endfunction

" }}}2    Unite    {{{2

nnoremap [unite] <Nop>
xnoremap [unite] <Nop>
nmap <LocalLeader>f [unite]
xmap <LocalLeader>f [unite]
imap <LocalLeader>f <C-\><C-N>[unite]

nnoremap [unite]S :<C-U>Unite source<CR>
nnoremap <silent> [unite]f :<C-U>UniteWithBufferDir -buffer-name=files file<CR>
nnoremap <silent> [unite]F :<C-U>UniteWithBufferDir -buffer-name=files file_rec<CR>
nnoremap <silent> [unite]r :<C-U>Unite -profile-name=mru file_mru<CR>
nnoremap <silent> [unite]d :<C-U>Unite -profile-name=mru directory_mru<CR>
nnoremap <silent> [unite]/ :<C-U>Unite -buffer-name=search -start-insert line/fast<CR>
nnoremap <silent> [unite]p :<C-U>Unite -buffer-name=registers -start-insert register<CR>
xnoremap <silent> [unite]p "_d:<C-U>Unite -buffer-name=register register<CR>
nnoremap <silent> [unite]b :<C-U>Unite bookmark<CR>
nnoremap <silent> [unite]m :<C-U>Unite mark<CR>
nnoremap <silent> [unite]h :<C-U>Unite -update-time=600 -start-insert help<CR>
nnoremap <silent> [unite]o :<C-U>Unite outline<CR>
nnoremap <silent> [unite]s :<C-U>Unite -start-insert session<CR>
" TODO use vim-tabline
nnoremap <silent> [unite]g :<C-U>Unite -start-insert tab<CR>
nnoremap <silent> [unite]j :<C-U>Unite jump<CR>
nnoremap <silent> [unite]c :<C-U>Unite change<CR>
nnoremap <silent> [unite]: :<C-U>Unite history/command<CR>
nnoremap <silent> [unite]y :<C-U>Unite history/yank<CR>
nnoremap <silent> [unite]a :<C-u>Unite alignta:options<CR>
xnoremap <silent> [unite]a :<C-u>Unite alignta:arguments<CR>
nnoremap <silent> [unite]G :<C-u>Unite giti<CR>

let g:unite_update_time = 240
let g:unite_enable_split_vertically = 1
let g:unite_source_file_mru_limit = 140
let g:unite_source_file_mru_time_format = "%m/%d %T "
let g:unite_source_directory_mru_limit = 80
let g:unite_source_directory_mru_time_format = "%m/%d %T "
let g:unite_source_file_rec_max_depth = 5

let g:unite_enable_ignore_case = 1
let g:unite_enable_smart_case = 1
let g:unite_source_history_yank_enable = 1
let g:unite_source_history_yank_limit = 40

let g:unite_data_directory = expand(s:rtp . '/.unite/')
let g:unite_source_session_path = expand('~/.vim/session/')

function! s:unite_settings()
  nmap <buffer> <C-J> <Plug>(unite_loop_cursor_down)
  nmap <buffer> <C-K> <Plug>(unite_loop_cursor_up)
  imap <buffer> <C-J> <Plug>(unite_insert_leave)<C-J>
  imap <buffer> <C-K> <Plug>(unite_insert_leave)<C-K>
  nmap <buffer> <F5> <Plug>(unite_redraw)
  imap <buffer> <F5> <Plug>(unite_redraw)
  nmap <buffer> <C-U> <Plug>(unite_append_end)<Plug>(unite_delete_backward_line)
  nmap <buffer> <LocalLeader>q <Plug>(unite_exit)
  imap <buffer> <LocalLeader>q <Plug>(unite_exit)
  nmap <buffer> <LocalLeader>Q <Plug>(unite_all_exit)
  imap <buffer> <LocalLeader>Q <C-\><C-N><Plug>(unite_all_exit)
  imap <buffer> <LocalLeader>; <C-\><C-N><Plug>(unite_all_exit)

  imap <buffer> <LocalLeader><BS> <Plug>(unite_delete_backward_path)
  imap <buffer> ; <Plug>(unite_delete_backward_word)
  inoremap <buffer><expr> <LocalLeader>/ unite#do_action('narrow')

  let unite = unite#get_current_unite()
  if index(unite.source_names, 'file') > -1 || index(unite.source_names, 'file_mru') > -1
    nnoremap <silent><buffer><expr> <LocalLeader><CR> unite#do_action('open')
    inoremap <silent><buffer><expr> <LocalLeader><CR> unite#do_action('open')
  endif
  if index(unite.source_names, 'file_rec') > -1
    imap <buffer> <LocalLeader>. <Plug>(unite_redraw)
  else
    inoremap <buffer> <LocalLeader>.  **/
  endif
endfunction
autocmd! my_vimrc FileType unite call s:unite_settings()

" TODO secondary default action
" TODO bookmark should convert slashes for different OSes
call unite#custom_default_action('file', 'tabdrop')
call unite#custom_default_action('directory', 'narrow')
call unite#custom_default_action('source/bookmark/jump_list', 'tabdrop')
call unite#custom_default_action('source/help/common', 'tabopen')
call unite#custom_source('file,buffer,file_rec', 'matchers', 'matcher_fuzzy')

call unite#set_profile('files', 'context', {
      \   'start_insert': 1,
      \   'hide_source_names': 1
      \ })

for s:i.unite_pattern in values(unite#get_substitute_pattern('files'))
  call unite#set_substitute_pattern('source/file',
        \   s:i.unite_pattern.pattern,
        \   s:i.unite_pattern.subst,
        \   s:i.unite_pattern.priority
        \ )
endfor

" Ref: thinca - http://d.hatena.ne.jp/thinca/20101027/1288190498
call unite#set_substitute_pattern('source/file', '\$\w\+', '\=eval(submatch(0))', 200)

call unite#set_profile('mru', 'context', {
      \   'start_insert': 1,
      \   'hide_source_names': 1
      \ })

command! -bar -nargs=? EditBookmarks call s:edit_bookmarks()
function! s:edit_bookmarks() "{{{
  if !has_key(g:, 'unite_source_bookmark_directory')
    call unite#get_candidates(['bookmark'])
  endif
  execute printf("Unite -immediately -auto-resize file:%s", get(g:, 'unite_source_bookmark_directory', ''))
endfunction "}}}

" }}}2    neocomplete    {{{2

let s:neco_settings = {
      \   'number': {
      \     'enable_at_startup'           : 1,
      \     'enable_smart_case'           : 1,
      \     'enable_camel_case_completion': 0,
      \     'enable_underbar_completion'  : 0,
      \     'enable_auto_select'          : 1,
      \     'enable_auto_delimiter'       : 1,
      \     'max_list'                    : 100,
      \     'force_overwrite_completefunc': 1
      \   },
      \   'list': {
      \     'same_filetype_lists': {
      \       '_': {}
      \     },
      \     'omni_functions': {
      \       'python': 'pythoncomplete#Complete',
      \       'ruby'  : 'rubycomplete#Complete'
      \     }
      \   },
      \   'string': {
      \     'lock_buffer_name_pattern': '\[fuf\]',
      \     'temporary_dir'           : expand('~/.vim/.neocomplete'),
      \     'data_directory'          : expand('~/.vim/.neocomplete')
      \   }
      \ }

let bundle = neobundle#get('neocomplete')
if empty(bundle)
  let bundle = neobundle#get('neocomplcache')
endif
let s:neco_prefix = bundle.name == 'neocomplete' ? 'neocomplete#' : 'neocomplcache_'
for s:i.type in ['number', 'list', 'string']
  for [s:i.key, s:i.value] in items(s:neco_settings[s:i.type])
    let s:neco_settings_key = s:neco_prefix . s:i.key
    if !exists('g:' . s:neco_settings_key)
      let g:{s:neco_settings_key} = s:i.value
    endif
  endfor
  unlet s:i.value
endfor
unlet! s:neco_settings s:neco_prefix s:neco_settings_key

execute 'inoremap <expr><LocalLeader><C-H> ' . bundle.name . '#smart_close_popup()."\<BS>"'
execute 'inoremap <expr><LocalLeader><BS>  ' . bundle.name . '#smart_close_popup()."\<BS>"'
execute 'inoremap <expr> <C-Y> pumvisible() ? ' . bundle.name . '#close_popup() : "\<C-Y>"'
execute 'inoremap <expr> <C-E> pumvisible() ? ' . bundle.name . '#cancel_popup() : "\<C-E>"'

" }}}2    neosnippet    {{{2

let g:neosnippet#snippets_directory = expand('~/.vim/snippets')
imap <expr><Tab> neosnippet#expandable_or_jumpable() ?
      \ "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-N>" : "\<Tab>"
" TODO jump back to previous placeholder
imap <expr><S-Tab> neosnippet#jumpable() ?
      \ "\<Plug>(neosnippet_jump_or_expand)" : pumvisible() ? "\<C-P>" : "\<S-Tab>"
smap <Tab> <Plug>(neosnippet_expand_or_jump)

let g:neosnippet#disable_runtime_snippets = {
      \ 'css': 1
      \ }

" TODO migrate all my snipMate settings
" https://github.com/bootleq/snipmate.vim/tree/master/snippets
" ~/repository/snipmate.vim
command! -bang -bar -complete=filetype -nargs=? EditSnippets call s:edit_snippets(<bang>0, [<f-args>])
function! s:edit_snippets(runtime_snippets, args) "{{{
  let l:filetype = get(a:args, 0, &l:filetype)
  if !empty(l:filetype)
    tab split
    if a:runtime_snippets
      execute "NeoSnippetEdit -runtime " . l:filetype
    else
      execute "NeoSnippetEdit " . l:filetype
    endif
  endif
endfunction "}}}

" }}}2    vimfiler    {{{2

call neobundle#config('vimfiler', {
      \   'lazy': 1,
      \   'depends': 'Shougo/unite.vim',
      \   'autoload': {
      \     'commands': [
      \       {'name': 'VimFiler', 'complete': 'customlist,vimfiler#complete'},
      \       'VimFilerExplorer', 'VimFilerSplit', 'Edit', 'Read', 'Source', 'Write'
      \     ],
      \     'mappings': ['<Plug>(vimfiler_switch)']
      \   }
      \ })

let bundle = neobundle#get('vimfiler')
function! bundle.hooks.on_source(bundle)
  let g:vimfiler_as_default_explorer = 1
  let g:vimfiler_edit_action = 'tabopen'
  let g:vimfiler_enable_clipboard = 0
  let g:vimfiler_safe_mode_by_default = 0
  let g:vimfiler_time_format = '%y-%m-%d %H:%M'

  if $OSTYPE == 'cygwin' || has("gui_win32")
    let g:unite_kind_file_use_trashbox = 1
    let g:vimfiler_detect_drives = [
          \ 'C:/', 'D:/', 'E:/', 'F:/', 'G:/', 'H:/', 'I:/',
          \ 'J:/', 'K:/', 'L:/', 'M:/', 'N:/']
  elseif $OSTYPE == 'linux-gnu'
    let g:vimfiler_detect_drives =
          \ split(glob('/mnt/*'), '\n') + split(glob('/media/*'), '\n')
  endif

  autocmd my_vimrc FileType vimfiler call s:vimfiler_my_settings()
  function! s:vimfiler_my_settings()
    nnoremap <silent><buffer> H <Nop>
  endfunction
endfunction

" }}}2   alignta    {{{2

let g:alignta_default_arguments = '! \S\+'
xnoremap <silent> <LocalLeader>= :Alignta! \S\+<CR>
xnoremap <silent> <LocalLeader>A :Alignta! \S\+<CR>
let g:unite_source_alignta_preset_arguments = [
      \   ["對齊 : (key: val)",            '01 :'],
      \   ["對齊 , (ruby array #comment)", ',\zs 0:1 #'],
      \   ["對齊 =",                       '='],
      \   ["對齊 =>",                      '=>'],
      \   ["對齊 |",                       '|' ],
      \   ["對齊 ,",                       '01 ,' ],
      \   ["對齊 , （一次）",              '01 ,/1' ],
      \   ["對齊空白",                     '\S\+'],
      \ ]

" }}}2   Indent Guide    {{{2

call neobundle#config('Indent-Guides', {
      \   'lazy': 1,
      \   'autoload': {
      \     'commands': 'IndentGuidesToggle'
      \   }
      \ })
let g:indent_guides_enable_on_vim_startup = 0
let g:indent_guides_auto_colors = 0
let g:indent_guides_guide_size = 1
let g:indent_guides_indent_levels = 30
nnoremap <Leader>ig :IndentGuidesToggle<CR>

" }}}2   Rails    {{{2

" let g:loaded_rails = 1
let g:rails_statusline = 1
let g:rails_url = 'http://localhost/'
" set title titlestring=%t%(\ %M%)%(\ (%{expand(\"%:~:.:h\")})%)%(\ %a%)%(\ %{rails#statusline(1)})%
autocmd User Rails command! Rclearlog execute "silent Rake log:clear"

" }}}2   fugitive  {{{2

command! -nargs=0 GBlameA Gblame | call <SID>fugitiveblame_after()
function! s:fugitiveblame_after() "{{{
  call feedkeys('A')
endfunction "}}}

function! s:fugitiveblame_gitdiffall(all) "{{{
  let rev = matchstr(getline('.'), '\v^\w{7}')
  let buffer = fugitive#buffer(bufname(b:fugitive_blamed_bufnr))
  if a:all
    call TmuxNewWindow({
          \   "text": "gitdiffall @" . rev,
          \   "title": '⎇',
          \   "directory": buffer.repo().tree()
          \ })
  else
    execute printf("tabnew %s | silent GitDiff @%s", buffer.path(), rev)
  endif
endfunction "}}}

autocmd! my_vimrc FileType fugitiveblame
      \ nnoremap <buffer> gf :call <SID>fugitiveblame_gitdiffall(0)<CR> |
      \ nnoremap <buffer> <LocalLeader>gf :call <SID>fugitiveblame_gitdiffall(1)<CR>

" }}}2   gitdiffall    {{{2

function! s:gitdiff_next()
  if exists('t:gitdiffall_info')
    let revision = get(t:gitdiffall_info, 'args', '')
    if revision =~ '\v\+\d+$'
      let next_revision = str2nr(matchstr(revision, '\v\d+')) + 1
      execute 'GitDiffOff'
      execute printf('GitDiff +%s', next_revision)
    else
      echomsg 'No "+n" revision recognized.'
    endif
  else
    echomsg 'Not in gitdiffall tab.'
  endif
endfunction
nnoremap <silent><S-F6> :call <SID>gitdiff_next()<CR>

" }}}2   SimpleJavascriptIndenter    {{{2

let bundle = neobundle#get('simple-javascript-indenter')
function! bundle.hooks.on_source(bundle)
  let g:SimpleJsIndenter_BriefMode = 1
  let g:SimpleJsIndenter_CaseIndentLevel = -1
endfunction

" }}}2   TagList   {{{2

if !executable('ctags')
  let loaded_taglist = 1
endif
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_Auto_Highlight_Tag = 0
let Tlist_Show_One_File = 1
let Tlist_File_Fold_Auto_Close = 1
" let Tlist_Sort_Type = 'name'
let Tlist_Use_Right_Window = 1
let Tlist_WinWidth = 40
let Tlist_Enable_Fold_Column = 0
"let Tlist_Show_Menu = 1

" }}}2   VisIncr  {{{2

call neobundle#config('VisIncr', {
      \   'lazy': 1,
      \   'autoload': {
      \     'commands': ['I', 'II', 'IA']
      \   }
      \ })

" }}}2   TagBar   {{{2

if !executable('ctags')
  let g:loaded_tagbar = 1
endif
let g:tagbar_autofocus = 1

if has("gui_running")
  noremap <silent> <M-z> :TagbarToggle<CR>
else
  noremap <silent> z :TagbarToggle<CR>
endif

" }}}2   GSession   {{{2

let g:autoload_session = 1
let g:autosave_session = 0
let g:gsession_non_default_mapping = 1
let g:gsession_use_git = 1
nnoremap <silent> <leader>ss    :call MakeSessionWithSafety()<CR>
nnoremap <silent> <leader>se    :GSessionEliminateCurrent<CR>
nnoremap <silent> <leader>sn    :NamedSessionMake<CR>
nnoremap <silent> <leader>sl    :NamedSessionLoad<CR>

" 特定情形下，不直接存 sessoin
function! MakeSessionWithSafety()
  let prompt = 0
  if exists('b:LargeFile_store') || &undolevels < 0
    let prompt = '[LargeFile] make session anyway? (y/N) '
  else
    for tab in range(tabpagenr('$'))
      if gettabwinvar(tab + 1, 1, '&diff')
        let prompt = '[Diff mode] make session anyway? (y/N) '
        break
      elseif bufname(tabpagebuflist(tab + 1)[0]) == '.git/COMMIT_EDITMSG'
        let prompt = '[Git commit] make session anyway? (y/N)'
        break
      elseif tabpagenr() == tabpagenr('$') && tabpagenr() == 1
        let prompt = '[One tab only] make session anyway? (y/N)'
        break
      endif
    endfor
  endif

  if !empty(prompt)
    redraw | echomsg prompt | redraw
    let yes = getchar()
    if nr2char(yes) != 'y'
      echomsg 'Aborted.' | redraw
    else
      silent call StashSessionBackup(1)
      GSessionMake
    end
  else
    silent call StashSessionBackup(1)
    GSessionMake
  endif
endfunction

" 備份／還原 session 檔案
let g:session_back_dir = expand('~/.vim/session/backup')
if !isdirectory(g:session_back_dir)
  call mkdir(g:session_back_dir, "p")
endif

command! -nargs=0 SessionBackupSave call StashSessionBackup(1)
command! -nargs=0 SessionBackupRestore call StashSessionBackup(0)
function! StashSessionBackup(save)
  if a:save
    if filereadable(v:this_session)
      call system("cp ". v:this_session . "\ " . g:session_back_dir)
    endif
  else
    let bakfile = g:session_back_dir . '/' . fnamemodify(v:this_session, ":t")
    if filereadable(bakfile)
      call system("cp " . bakfile . "\ ~/.vim/session/")
      echomsg 'Restored session file from backup.'
      echomsg 'For clearer restoring, quit and re-enter Vim now.'
    endif
  endif
endfunction

" FIXME 再讀取 session 時 filetype 也忘光了
command! -bang CleanMakeGSession call CleanMakeGSession(<bang>0)
function! CleanMakeGSession(no_quit)
  let save_ssop = &sessionoptions
  set sessionoptions-=globals
  set sessionoptions-=localoptions
  set sessionoptions-=options
  set sessionoptions-=buffers
  abclear
  mapclear
  mapclear!
  GSessionMake
  execute "set sessionoptions=" . save_ssop
  if !a:no_quit
    execute 'quitall'
  else
    echomsg 'For clearer saving, quit and re-enter Vim now.'
  endif
endfunction

" }}}2   ShowMarks   {{{2

let g:showmarks_include = 'abcdefghijklmnopqrstuvwxyz' . 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
let g:showmarks_ignore_type = ""
let g:showmarks_textlower = "\t"
let g:showmarks_textupper = "\t"
let g:showmarks_textother = "\t"
let g:showmarks_auto_toggle = 0
let g:showmarks_no_mappings = 1
nmap mt <Plug>ShowMarksToggle

" }}}2   Surround (kana version)   {{{2

if exists('g:loaded_surround') && exists('*SurroundRegister')
    call SurroundRegister('g', '&', "&lt;\r&gt;")
    call SurroundRegister('g', 'C', "<![CDATA[\r]]>")
    call SurroundRegister('g', '（', "（\r）")
    call SurroundRegister('g', '「', "「\r」")
    call SurroundRegister('g', '『', "『\r』")
endif

cnoremap <LocalLeader>> >

" Overwrite default mapping ys, because y is for yank.
nmap s  <plug>Ysurround
nmap ss <plug>Yssurround
nmap sss <Nop>

" }}}2   wokmarks   {{{2

let g:wokmarks_do_maps = 0
let g:wokmarks_pool = "abcdefghijklmnopqrstuvwxyz"
nmap mm <Plug>ToggleMarkWok
map mj <Plug>NextMarkWok
map mk <Plug>PrevMarkWok
autocmd User WokmarksChange :ShowMarksOn

" }}}2   anzu   {{{2

let bundle = neobundle#get('vim-anzu')
if !empty(bundle)
  function! bundle.hooks.on_post_source(bundle)
    let g:anzu_status_format = "/%#Type#%p%#None#  %i/%l %#WarningMsg#%w"
    let g:airline#extensions#anzu#enabled = 0
    nmap n <Plug>(anzu-n-with-echo)
    nmap N <Plug>(anzu-N-with-echo)
    nmap * <Plug>(anzu-star-with-echo)
    nmap # <Plug>(anzu-sharp-with-echo)
  endfunction
endif

" }}}2    tComment    {{{2

let g:tcommentMaps = 0
let g:tcomment#blank_lines = 0
let g:tcommentGuessFileType_haml = 1
" let g:tcommentOptions = {'col': 1}
let g:tcomment_types = {
      \   'c': {"commentstring": '// %s'},
      \   'c_inline': {"commentstring": '// %s'}
      \ }
nnoremap <silent> <LocalLeader>cc :TComment<CR>
vnoremap <silent> <LocalLeader>cc :TCommentMaybeInline<CR>
nnoremap <silent> <LocalLeader>cb :TCommentBlock<CR>
vnoremap <silent> <LocalLeader>cb :TCommentBlock<CR>
nnoremap <silent> <LocalLeader>c :let w:tcommentPos = getpos(".") \| set opfunc=tcomment#Operator<cr>g@

" }}}2    CamelCaseMotion    {{{2

let g:camelcasemotion_leader = 'g'

" }}}2    EasyMotion    {{{2

map <LocalLeader>e <Plug>(easymotion-w)
map <LocalLeader>E <Plug>(easymotion-bd-w)
map <LocalLeader>L <Plug>(easymotion-j)
map <LocalLeader>H <Plug>(easymotion-k)
map <LocalLeader>n <Plug>(easymotion-n)
map <LocalLeader>N <Plug>(easymotion-N)
map <LocalLeader>s <Plug>(easymotion-sn)
" map <LocalLeader>J <Plug>(easymotion-jumptoanywhere)
" omap <LocalLeader>l <Plug>(easymotion-special-l)
" omap <LocalLeader>p <Plug>(easymotion-special-p)
" xmap <LocalLeader>l <Plug>(easymotion-special-l)
" xmap <LocalLeader>p <Plug>(easymotion-special-p)
nmap <LocalLeader>; <Plug>(easymotion-next)
nmap <LocalLeader>: <Plug>(easymotion-prev)
let g:EasyMotion_keys = tolower('asdghklqwertyuiopzxcvbnmfj;')
let g:EasyMotion_use_upper = 0
let g:EasyMotion_smartcase = 1
let g:EasyMotion_startofline = 0
let g:EasyMotion_space_jump_first = 1
let g:EasyMotion_enter_jump_first = 1

" }}}2    Sneak    {{{2

let g:sneak#use_ic_scs = 1
let g:sneak#map_netrw = 0
nmap <Leader>; <Plug>SneakBackward
xmap <Leader>; <Plug>VSneakBackward
nmap f <Plug>Sneak_f
nmap F <Plug>Sneak_F
xmap f <Plug>Sneak_f
xmap F <Plug>Sneak_F
omap f <Plug>Sneak_f
omap F <Plug>Sneak_F

" leave s to surround
let bundle = neobundle#get('vim-sneak')
function! bundle.hooks.on_source(bundle)
  nmap s <plug>Ysurround
endfunction

" }}}2    histwin    {{{2

let g:undo_tree_help = 0
let g:undo_tree_dtl = 0
let g:undo_tree_width = 40
" let g:undo_tree_nomod = 0

" }}}2    ChooseWin    {{{2

" nmap - <Plug>(choosewin)
nmap <C-W>/ <Plug>(choosewin)
nmap <C-W>; <Plug>(choosewin)
let g:choosewin_overlay_enable = 0
" let g:choosewin_overlay_clear_multibyte = 1
" let g:choosewin_blink_on_land      = 0
" let g:choosewin_statusline_replace = 0
let g:choosewin_tabline_replace    = 0

" }}}2    Cycle    {{{2

let g:cycle_no_mappings = 1
let g:cycle_max_conflict = 7
" let g:cycle_max_conflict = 1
let g:cycle_phased_search = 1
nmap <silent> <LocalLeader>a <Plug>CycleNext
vmap <silent> <LocalLeader>a <Plug>CycleNext
nmap <silent> <Leader>a <Plug>CyclePrev
vmap <silent> <Leader>a <Plug>CyclePrev

let g:cycle_default_groups = [
      \   [['true', 'false']],
      \   [['yes', 'no']],
      \   [['on', 'off']],
      \   [['+', '-']],
      \   [['>', '<']],
      \   [['"', "'"]],
      \   [['==', '!=']],
      \   [['0', '1']],
      \   [['and', 'or']],
      \   [['in', 'out']],
      \   [['up', 'down']],
      \   [['min', 'max']],
      \   [['get', 'set']],
      \   [['add', 'remove']],
      \   [['to', 'from']],
      \   [['read', 'write']],
      \   [['save', 'load', 'restore']],
      \   [['next', 'previous', 'prev']],
      \   [['only', 'except']],
      \   [['without', 'with']],
      \   [['exclude', 'include']],
      \   [['width', 'height']],
      \   [['asc', 'desc']],
      \   [['start', 'end']],
      \   [['是', '否']],
      \   [['上', '下']],
      \   [['左', '右']],
      \   [['前', '後']],
      \   [['內', '外']],
      \   [['男', '女']],
      \   [['east', 'west']],
      \   [['south', 'north']],
      \   [['prefix', 'suffix']],
      \   [['decode', 'encode']],
      \   [['short', 'long']],
      \   [['request', 'response']],
      \   [['pop', 'shift']],
      \   [['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday',
      \     'Friday', 'Saturday'], ['hard_case', {'name': 'Days'}]],
      \   [['{:}', '[:]', '(:)'], 'sub_pairs'],
      \   [['（:）', '「:」', '『:』'], 'sub_pairs'],
      \ ]
" ruby, rails       {{{3
let g:cycle_default_groups += [
      \   [["if", "unless"]],
      \   [["blank", "present"]],
      \   [["while", "until"]],
      \   [["begin", "end"]],
      \   [["foreign_key", "primary_key"]],
      \   [["inspect", "to_yaml"]],
      \   [["do:end", "{:}"], 'sub_pairs'],
      \ ]
" CSS               }}}3 {{{3
let g:cycle_default_groups += [
      \   [["none", "block"]],
      \   [["show", "hide"]],
      \   [["left", "right"]],
      \   [["top", "bottom"]],
      \   [["margin", "padding"]],
      \   [["before", "after"]],
      \   [["absolute", "relative"]],
      \   [["horizontal", "vertical"]],
      \   [["first", "last"]],
      \ ]
" HTML               }}}3 {{{3
let g:cycle_default_groups += [
      \   [['h1', 'h2', 'h3'], 'sub_tag'],
      \   [['ul', 'ol'], 'sub_tag'],
      \   [['header', 'footer']],
      \   [['em', 'strong', 'small'], 'sub_tag'],
      \ ]

" JS               }}}3 {{{3
let g:cycle_default_groups += [
      \   [['focus', 'blur']],
      \ ]
" 少用項目               }}}3 {{{3
" TODO %w(foo bar) style
let g:cycle_default_groups += [
      \   [['日', '一', '二', '三', '四', '五', '六']],
      \   [['portrait', 'landscape']],
      \ ]

" }}}3

" FileType ruby
let g:cycle_default_groups_for_ruby = [
      \   [['accessible', 'protected']],
      \   [['stylesheet_link_tag ', 'javascript_include_tag ']],
      \ ]

" }}}2    HardMotion    {{{2

nmap <silent> <LocalLeader><Space> <Plug>HardMotion


" }}}2    ambicmd    {{{2

" cnoremap <expr> <Space> ambicmd#expand("\<Space>")
" cnoremap <expr> <CR> ambicmd#expand("\<CR>")

" }}}2    ack/ag    {{{2

call neobundle#config('ag.vim', {
      \   'lazy': 1,
      \   'autoload': {
      \     'commands': {'name': 'Ag', 'complete': 'dir'},
      \   }
      \ })
" let g:ackprg = 'ag --nogroup --nocolor --column'
" alias ag='noglob ag --nobreak --nogroup --noheading --smart-case --depth=27'

" }}}2    delimitMate    {{{2

let delimitMate_matchpairs = "(:),{:},[:],<:>,《:》,〈:〉,［:］,（:）,「:」,『:』,‘:’,“:”"
let delimitMate_excluded_regions = ""
let delimitMate_expand_space = 1
let delimitMate_expand_cr = 1
" let delimitMate_smart_quotes = 0
" let delimitMate_smart_matchpairs = ''
let delimitMate_balance_matchpairs = 1

" }}}2    smartword.vim    {{{2

" if exists('g:loaded_smartword')
"   map w  <Plug>(smartword-w)
"   map b  <Plug>(smartword-b)
"   map e  <Plug>(smartword-e)
"   map ge  <Plug>(smartword-ge)
" endif

" }}}2    fakeclip    {{{2

" let g:fakeclip_no_default_key_mappings = 1

" }}}2    PrettyPrint    {{{2

" let g:prettyprint_show_expression = 1
let g:prettyprint_strin = ['split']

" }}}2    altercmd    {{{2

let bundle = neobundle#get('vim-altercmd')
function! bundle.hooks.on_source(bundle)
  call altercmd#load()

  AlterCommand h help
  AlterCommand m messages
  AlterCommand t tabnew
  AlterCommand w!! call SudoWrite()
  AlterCommand tm TabMessage
  AlterCommand tms TabMessage scriptnames
  AlterCommand mov[eintotabpage] MoveIntoTabpage
  AlterCommand p Echo
  AlterCommand '<,'>p '<,'>Echo
  AlterCommand g GitDiff
  AlterCommand d[iff] Diff
  AlterCommand gits Gstatus
  AlterCommand gb[lame] GBlameA
  AlterCommand r[ename] Rename <C-R>%<C-R>=EatChar('\s')<CR>
  AlterCommand to[uch] Touch %<C-R>=EatChar('\s')<CR>
  AlterCommand pp PP
  AlterCommand u[nite] Unite
  AlterCommand f VimFilerSplit -buffer-name=
  AlterCommand ag Ag
  AlterCommand qw wq
  AlterCommand ref Ref
  AlterCommand man Ref man
  AlterCommand bingzh Ref bingzh
  AlterCommand k Ref bingzh
  AlterCommand jsl JSLint
  AlterCommand jsh JSHint
  AlterCommand bu NeoBundleUpdate
  AlterCommand bl TabMessage NeoBundleUpdatesLog
endfunction

" Ref helpgrep Eatchar
function! EatChar(pattern)
  let c = nr2char(getchar(0))
  return (c =~ a:pattern) ? '' : c
endfunction

" TODO unlet bundle

" }}}2    qfreplace    {{{2

call neobundle#config('vim-qfreplace', {
      \   'lazy': 1,
      \   'autoload': {
      \     'filetypes': ['unite', 'qf']
      \   }
      \ })
autocmd my_vimrc FileType qf nnoremap <buffer> r :<C-U>Qfreplace tabnew<CR>

" }}}2    Ref    {{{2

let g:ref_cache_dir = expand('~/.vim/ref-cache')

call neobundle#config('vim-ref', {
      \   'lazy': 1,
      \   'autoload': {
      \     'commands': 'Ref'
      \   }
      \ })

call neobundle#config('vim-ref-bingzh', {
      \   'lazy': 0,
      \   'autoload': {
      \     'commands': 'Ref',
      \     'function_prefix': 'ref'
      \   }
      \ })
let bundle = neobundle#get('vim-ref-bingzh')
function! bundle.hooks.on_source(bundle)
  autocmd FileType ref-bingzh call s:initialize_ref_viewer_bingzh()
  function! s:initialize_ref_viewer_bingzh()
    setlocal number nowrap
    setlocal noreadonly
    setlocal modifiable
    setlocal foldmethod=expr foldlevel=1 foldexpr=RefBingZhFold(v:lnum)
  endfunction

  function! RefBingZhFold(line)
    return <SID>ref_bingzh_fold(a:line)
  endfunction

  function! s:ref_bingzh_fold(line)
    let splitter = '\v ##$'
    if getline(a:line) =~ splitter
      return '>1'
    elseif getline(a:line+1) =~ splitter
      return '<1'
    else
      return '='
    endif
  endfunction
endfunction

nnoremap <silent> K :call ref#jump('normal', 'bingzh')<CR>
xnoremap <silent> K :call ref#jump('visual', 'bingzh')<CR>
cnoreabbrev <expr> k ((getcmdtype() == ':' && getcmdpos() <= 2) ? 'Ref bingzh' : 'k')

nnoremap <silent> <LocalLeader>K :normal! K<CR>
xnoremap <silent> <LocalLeader>K :normal! K<CR>

" }}}2    open-browser    {{{2

call neobundle#config('open-browser.vim', {
      \   'lazy': 1,
      \   'autoload': {
      \     'mappings': ['<Plug>(openbrowser-search)', '<Plug>(openbrowser-smart-search)']
      \   }
      \ })
let bundle = neobundle#get('open-browser.vim')
function! bundle.hooks.on_source(bundle)
  let g:openbrowser_search_engines = {
        \   'morebile': 'http://www.google.com.tw/m/search?site=dictionary&gdm=1&wtr=1&q={query}',
        \   'dictionary': 'http://www.google.com/dictionary?q={query}',
        \   'google': 'http://google.com/search?q={query}',
        \ }
  let g:openbrowser_default_search = 'google'

  " remove ["'"]
  let g:openbrowser_iskeyword = join(
        \   range(char2nr('A'), char2nr('Z'))
        \   + range(char2nr('a'), char2nr('z'))
        \   + range(char2nr('0'), char2nr('9'))
        \   + ['_', ':', '/', '.', '-', '+', '%', '#', '?', '&', '=', ';', '@', '$', ',', '[', ']', '!', "(", ")", "*", "~", ],
        \ ',')
endfunction

nmap <Leader><CR> <Plug>(openbrowser-smart-search)
vmap <Leader><CR> <Plug>(openbrowser-smart-search)
nmap <Leader>s<CR> <Plug>(openbrowser-search)
vmap <Leader>s<CR> <Plug>(openbrowser-search)

" }}}2    LargeFile    {{{2

" TODO delcommand Large
let g:LargeFile           = 40
let g:LargeFile_size_unit = 1024    " KB
let g:LargeFile_patterns  = '*.log,*.log.1,*.sql'
let g:LargeFile_verbose   = 0
autocmd User LargeFileRead call s:large_file_read()
autocmd User LargeFile call s:large_file_detected()

function! s:large_file_detected()
  let ext_name = expand('%:e')
  if ext_name == 'log'
    nnoremap <buffer> <LocalLeader>ddd :EmptyFile<CR>
  elseif ext_name == 'sql'
    " set syntax=sql
  endif
endfunction

function! s:large_file_read()
  let dir_name = expand('%:p:h')
  if dir_name =~ '/home/www/fc/\(\w\+/\)\?log'
    if &fileencoding != 'utf-8'
      edit! ++enc=utf-8
    endif
    syntax match railslogEscape '\e\[[0-9;]*m' conceal
  elseif dir_name == '/home/www/logs'
    " set syntax=httplog
  endif
endfunction

" }}}2


" }}}1    Plugins            =================================================


" Functions:     {{{1 ========================================================

" 清除多餘 Tab, 空白    {{{2

command! -nargs=0 TidySpaces call TidySpaces()
function! TidySpaces()
  let oldCursor = getpos(".")
  %s/\r\+$//ge
  %s/\t/    /ge
  %s/\s\+$//ge
  call setpos('.', oldCursor)
endfunction

"     變更編碼    {{{2

" Ref: kana - https://github.com/kana/config
command! -bang -bar -complete=file -nargs=? Utf8
      \ edit<bang> ++enc=utf-8 <args>
command! -bang -bar -complete=file -nargs=? Big5
      \ edit<bang> ++enc=big5 <args>

"     sudo write    {{{2

function! SudoWrite()
  " TODO 'autoread', prevent prompt for reload
  let modified = &l:modified
  setlocal nomodified
  silent! execute 'write !sudo tee % >/dev/null'
  let &l:modified = v:shell_error ? modified : 0
endfunction

" }}}2   清除／復原 search pattern   {{{2

" 問題：let @/ = '' 後再按 n，不知為什麼又會改變 @/ 的值
" 替代作法為使用 :nohlsearch，但無法確認目前是否已有 highlight，
" 故用掉 <F3> <F4> 兩個鍵作 mapping。
"
" let g:lastSearchPattern = @/
" function! ToggleSearchPattern()
"   if @/ != ''
"     let g:lastSearchPattern = @/
"     let @/ = ''
"   else
"     let @/ = g:lastSearchPattern
"   endif
" endfunction
" nmap <silent> <F3> :call ToggleSearchPattern()<CR>
" imap <silent> <F3> <C-O>:call ToggleSearchPattern()<CR>

" }}}2   暫存／復原 position    {{{2

function! SavePos()
  let s:save_pos = getpos(".")
endfunction


function! RestorePos()
  call setpos('.', s:save_pos)
endfunction

" }}}2   暫存／復原 register 內容   {{{2

function! SaveReg(...) "{{{
  let l:name = a:0 ? a:1 : v:register
  let s:save_reg = [getreg(l:name), getregtype(l:name)]
endfunction "}}}


function! RestoreReg(...) "{{{
  let l:name = a:0 ? a:1 : v:register
  if exists('s:save_reg')
    call setreg(l:name, s:save_reg[0], s:save_reg[1])
  endif
endfunction "}}}

" }}}2   暫存／復原 mark 內容   {{{2

function! SaveMark(...)
  let l:name = a:0 ? a:1 : 'm'
  let s:save_mark = getpos("'" . l:name)
endfunction


function! RestoreMark(...)
  let l:name = a:0 ? a:1 : 'm'
  call setpos("'" . l:name, s:save_mark)
endfunction

" }}}2   Custom diffoff     {{{2

command! MyDiffOff call MyDiffOff()
function! MyDiffOff()
  if &diff
    setlocal diff& scrollbind& cursorbind& wrap& foldcolumn&
    set scrollopt=ver,hor,jump
    let &l:foldmethod = exists('b:save_foldmethod') ? b:save_foldmethod : 'marker'
  else
    echomsg 'Not in diff mode.'
  endif
endfunction

" }}}2   Re-diff with iwhite diffopt toggled     {{{2

function! s:diffupdate_toggle_w()
  if &diff
    if index(split(&diffopt, ','), 'iwhite') >= 0
      set diffopt-=iwhite
      echomsg 'iwhite off'
    else
      set diffopt+=iwhite
      echomsg 'iwhite on'
    endif
    diffupdate
  endif
endfunction

" }}}2   Context sensitive H,L.     {{{2

" Ref: tyru - https://github.com/tyru/dotfiles
" TODO 內部也統一使用 s:scroll_up / down
nnoremap <silent> H :<C-u>call HContext()<CR>
nnoremap <silent> L :<C-u>call LContext()<CR>
xnoremap <silent> H <ESC>:<C-u>call HContext()<CR>mzgv`z
xnoremap <silent> L <ESC>:<C-u>call LContext()<CR>mzgv`z

function! HContext()
  let l:moved = MoveCursor("H")
  if !l:moved && line('.') != 1
    " execute "normal! " . "\<ScrollWheelUp>H"
    execute "normal! " . "5kH"
  endif
endfunction

function! LContext()
  let l:moved = MoveCursor("L")

  if !l:moved && line('.') != line('$')
    " execute "normal! " . "\<ScrollWheelDown>L"
    execute "normal! " . "5jL"
  endif
endfunction

function! MoveCursor(key)
  let l:cnum = col('.')
  let l:lnum = line('.')
  let l:wline = winline()

  execute "normal! " . v:count . a:key
  let l:moved =  l:cnum != col('.') || l:lnum != line('.') || l:wline != winline()

  return l:moved
endfunction

" }}}2   Scroll     {{{2

function! s:scroll_down(...)
  let mode = a:0 ? a:1 : 'n'
  let l:count = a:0 > 1 ? a:2 : 2

  if has("gui_running")
    return '5j'
  else
    return repeat("\<ScrollWheelDown>", l:count)
  endif
endfunction


function! s:scroll_up(...)
  let mode = a:0 ? a:1 : 'n'
  let l:count = a:0 > 1 ? a:2 : 2

  if has("gui_running")
    return '5k'
  else
    return repeat("\<ScrollWheelUp>", l:count)
  endif
endfunction

" }}}2   Smart Home/End     {{{2

" http://vim.wikia.com/wiki/SmartHome_and_SmartEnd_over_wrapped_lines
function! SmartHome(mode)
  let curcol = col(".")
  " gravitate towards beginning for wrapped lines
  if curcol > indent(".") + 2
    call cursor(0, curcol - 1)
  endif
  if curcol == 1 || curcol > indent(".") + 1
    if &wrap
      normal! g^
    else
      normal! ^
    endif
  else
    if &wrap
      normal! g0
    else
      normal! 0
    endif
  endif
  if a:mode == "v"
    call SaveMark('m')
    call setpos("'m", getpos('.'))
    normal! gv`m
    call RestoreMark('m')
  endif
  return ""
endfunction

function! SmartEnd(mode)
  let curcol = col(".")
  let lastcol = a:mode == "i" ? col("$") : col("$") - 1
  " gravitate towards ending for wrapped lines
  if curcol < lastcol - 1
    call SaveReg()
    normal! yl
    let l:charlen = byteidx(getreg(), 1)
    call cursor(0, curcol + l:charlen)
    call RestoreReg()
  endif
  if curcol < lastcol
    if &wrap
      normal! g$
    else
      normal! $
    endif
  else
    normal! g_
  endif
  " correct edit mode cursor position, put after current character
  if a:mode == "i"
    call SaveReg()
    normal! yl
    let l:charlen = byteidx(getreg(), 1)
    call cursor(0, col(".") + l:charlen)
    call RestoreReg()
  endif
  if a:mode == "v"
    call SaveMark('m')
    call setpos("'m", getpos('.'))
    normal! gv`m
    call RestoreMark('m')
  endif
  return ""
endfunction

" }}}2   Config in diff mode     {{{2

function! s:config_in_diff_mode()
  " Ref: https://github.com/haya14busa/dotfiles
  if !&diff
    return
  endif

  setlocal nocursorline

  nnoremap <buffer> <LocalLeader>dh :diffget :2 <Bar> diffupdate<CR>
  nnoremap <buffer> <LocalLeader>dl :diffget :3 <Bar> diffupdate<CR>
  nnoremap <buffer> <LocalLeader>du :<C-U>diffupdate<CR>
  nnoremap <buffer> <silent> <LocalLeader>dU :call <SID>diffupdate_toggle_w()<CR>
endfunction

" }}}2   clipboard 存取    {{{2

" http://vim.wikia.com/wiki/Using_the_Windows_clipboard_in_Cygwin_Vim
" TODO 正確處理字元編碼
function! Putclip(type, ...) range
  let save_sel = &selection
  let &selection = "inclusive"
  let save_reg = @@
  if a:type == 'n'
    silent execute a:firstline . "," . a:lastline . "y"
  elseif a:type == 'c'
    silent execute a:1 . "," . a:2 . "y"
  else
    silent execute "normal! `<" . a:type . "`>y"
  endif
  call system('putclip', @@)
  let &selection = save_sel
  let @@ = save_reg
endfunction

if has('clipboard')
  if $OSTYPE == 'cygwin' || has("gui_win32")
    noremap <silent> <LocalLeader>y "*y
    inoremap <silent> <LocalLeader>y <C-O>"*y
    if has("gui_win32")
      noremap! <S-Insert> <C-R>*
    endif
  elseif $OSTYPE == 'linux-gnu'
    noremap <silent> <LocalLeader>y "+y
    inoremap <silent> <LocalLeader>y <C-O>"+y
  endif
else
  vnoremap <silent> <LocalLeader>y :call Putclip(visualmode(), 1)<CR>
  nnoremap <silent> <LocalLeader>y :call Putclip('n', 1)<CR>
  inoremap <silent> <LocalLeader>y <C-O>:call Putclip('n', 1)<CR>
endif

function! Getclip()
  let save_reg = @@
  let @@ = system('getclip')
  setlocal paste
  execute 'normal! p'
  setlocal nopaste
  let @@ = save_reg
endfunction

if has('clipboard')
  if $OSTYPE == 'cygwin' || has("gui_win32")
    nnoremap <silent> <LocalLeader>p "*p
    inoremap <silent> <LocalLeader>p <C-O>"*p
  elseif $OSTYPE == 'linux-gnu'
    nnoremap <silent> <LocalLeader>p "+p
    inoremap <silent> <LocalLeader>p <C-O>"+p
  endif
else
  nnoremap <silent> <LocalLeader>p :call Getclip()<CR>
  inoremap <silent> <LocalLeader>p <C-O>:call Getclip()<CR>
endif

" }}}2   Tmux   {{{2

" Bracketed Paste Mode
" Ref http://slashdot.jp/journal/506765/Bracketed-Paste-Mode
" - Use tmux 1.7 `paste-buffer -p` to paste
" - Use <F11> and tmux `send-keys "\e[201~"` for pastetoggle
if &term =~ "xterm" && exists('$TMUX')
  let &t_ti = &t_ti . "\e[?2004h"
  let &t_te = "\e[?2004l" . &t_te
  let &pastetoggle = "\e[201~"
  map <F11> <Esc>[201~
  imap <F11> <Esc>[201~

  function! XTermPasteBegin(ret)
    set paste
    return a:ret
  endfunction

  map <special> <expr> <Esc>[200~ XTermPasteBegin("i")
  imap <special> <expr> <Esc>[200~ XTermPasteBegin("")
  cmap <special> <Esc>[200~ <nop>
  cmap <special> <Esc>[201~ <nop>
endif

function! TmuxNewWindow(...) "{{{
  let options = a:0 ? a:1 : {}
  let text = get(options, 'text', '')
  let title = get(options, 'title', '')
  let directory = get(options, 'directory', getcwd())
  let cmd = 'tmux new-window -a '
        \ . (empty(title) ? '' : printf('-n %s', shellescape(title)))
        \ . printf(' -c %s', shellescape(directory))
  call system(cmd)
  if !empty(text)
    let cmd = printf('tmux set-buffer %s \; paste-buffer -d \; send-keys Enter', shellescape(text))
    call system(cmd)
  endif
endfunction "}}}

" }}}2   LastTab    {{{2

function! LastTab(act)

  " TODO emulate TabClose autocmd

  let lt = g:lasttab
  let tabClosed = tabpagenr('$') < lt.knownLength ? 1 : 0

  if a:act ==# 'TabLeave'
    if !tabClosed
      let lt.prevLeave = lt.leave
    elseif lt.prevLeave > tabpagenr()
      let lt.prevLeave -= 1
    endif
    let lt.leave = tabpagenr()
  elseif a:act ==# 'switch'
    if tabClosed
      let lastTab = lt.prevLeave > tabpagenr() ? lt.prevLeave -1  : lt.prevLeave
    else
      let lastTab = lt.leave
    endif
    if lastTab == tabpagenr()
      echo 'Already on last tab.'
    else
      execute "tabnext " . lastTab
    endif
  endif

  let lt.knownLength = tabpagenr('$')

endfunction

if !exists('g:lasttab')
  let g:lasttab = {'leave':1, 'prevLeave':1, 'knownLength':1}
endif
autocmd TabLeave * call LastTab('TabLeave')
" autocmd TabEnter,VimEnter * :call LastTab('TabEnter')
" autocmd BufLeave * :call LastTab('TabEnter')
autocmd TabEnter * call LastTab('TabEnter')
nnoremap <silent> <LocalLeader>t :call LastTab('switch')<CR>
inoremap <silent> <LocalLeader>t <C-\><C-N>:call LastTab('switch')<CR>

" }}}2   目前位置 highlight group   {{{2

function! SynStackInfo()
  let synStack = synstack(line("."), col("."))
  if len(synStack) == 0
    echomsg 'No synID here.'
  else
    let result = []
    for syn in synStack
      call add(result, SynInfo(syn))
    endfor
    redraw
    let level = 0
    for list in result
      execute "echohl " . list[0]
      echomsg repeat(' ', level) . list[1]
      let level += 1
      echohl None
    endfor
  endif
endfunction

function! SynInfo(syn)
  let synAttr =  synIDattr(a:syn, "name")
  if synAttr == ''
    echomsg 'No synID here.'
  else
    let idTrans = synIDtrans(a:syn)
    let syn = synIDattr(idTrans, "name")
    return [syn, synAttr . " - " . syn . " {fg: " . synIDattr(idTrans, 'fg') . ', bg: ' . synIDattr(idTrans, 'bg') . "}" ]
  endif
endfunction

" }}}2   TabMessage   {{{2

" http://vim.wikia.com/wiki/Capture_ex_command_output
function! TabMessage(cmd)
  redir => redirMessage
  silent execute a:cmd
  redir END
  tabnew
  silent put=redirMessage
  0,2delete_
  set nomodified
  setlocal buftype=nofile
  setlocal bufhidden=hide
  setlocal noswapfile
  setlocal nobuflisted
endfunction
command! -nargs=+ -complete=command TabMessage call TabMessage(<q-args>)

" }}}2   Move window into tabpage   {{{2

" Modified from kana's useful tab function {{{
function! s:move_window_into_tab_page(...)
  " Move the current window into target_tabpagenr.
  " a:1 - target_tabpagenr : if not set, move into new tab page.
  " a:2 - open_relative : open new tab aside current tab (default 1).
  let target_tabpagenr = a:0 > 0 ? a:1 : 0
  let open_relative = a:0 > 1 ? a:2 : 1

  if target_tabpagenr > tabpagenr('$')
    let target_tabpagenr = tabpagenr('$')
  endif

  let original_tabnr = tabpagenr()
  let target_bufnr = bufnr('')
  let window_view = winsaveview()

  if target_tabpagenr == 0
    tabnew
    if !open_relative
      tabmove
    endif
    execute target_bufnr 'buffer'
    let target_tabpagenr = tabpagenr()
  else
    execute target_tabpagenr 'tabnext'
    topleft new  " FIXME: be customizable?
    execute target_bufnr 'buffer'
  endif
  call winrestview(window_view)

  execute original_tabnr 'tabnext'
  if 1 < winnr('$')
    close
  else
    enew
  endif

  execute target_tabpagenr 'tabnext'
endfunction " }}}

command! -nargs=* MoveIntoTabpage call <SID>move_window_into_tab_page(<f-args>)

" }}}2   EvalVimScriptRegion    {{{2

" from c9s - http://gist.github.com/444528 http://gist.github.com/572191
function! EvalVimScriptRegion(s, e)
  let lines = getline(a:s,a:e)
  let file = tempname()
  call writefile(lines,file)
  redir @e
  silent execute ':source ' . file
  call delete(file)
  redraw
  redir END
  echo "Region evaluated."

  if strlen(getreg('e')) > 0
    10new
    redraw
    silent file "EvalResult"
    setlocal noswapfile buftype=nofile bufhidden=wipe
    setlocal nobuflisted nowrap cursorline nonumber foldcolumn=0
    set filetype=eval
    syntax match ErrorLine +^E\d\+:.*$+
    highlight link ErrorLine Error
    silent $put =@e
  endif
endfunction

augroup VimEval
  autocmd!
  autocmd filetype vim :command! -range Eval :call EvalVimScriptRegion(<line1>, <line2>)
  autocmd filetype vim :vnoremap <silent> <F5> <C-\><C-N>:call SavePos()<CR>gv:Eval<CR>:call RestorePos()<CR>
augroup END

" }}}2   fold expr - help 檔案以分隔線（====）分割區塊    {{{2

function! HelpDelimFoldLevel(line)
  if  getline(a:line-1)=~'=\{78,\}'
    return '>1'
  elseif getline(a:line+1)=~'=\{78,\}'
    return '<1'
  else
    return '='
  endif
endfunction

" }}}2   help 檔案將 *keyword* 對齊到右端    {{{2

function! HelpHyperTextEntryJustify()
  let save_isk = &l:iskeyword
  let save_et = &l:expandtab
  let &l:isk = '!-~,^*,^|,^",192-255'
  let &l:expandtab = 1
  .retab!
  call setline(".",
        \ substitute(
        \   getline('.'),
        \   '\v(.*)(\s\*\k+\*)',
        \   '\=submatch(1) . repeat(" ", &textwidth - strlen(submatch(0))) . submatch(2)'
        \   , ""
        \ ))

  let &l:isk = save_isk
  let &l:et = save_et
  .retab!
endfunction

" }}}2   camelCase / under_score 轉換    {{{2

" TODO when no keyword is under/after the cursor, try looking backward to find a word.
function! WordTransform()
  let w = expand("<cword>")
  let x = ''
  let c = strpart(getline('.'), col('.') - 1, 1)
  if match(w, '_') > -1
    let x = substitute(w, '_\([a-z]\)', '\u\1', 'g')
  else
    let x = substitute(w, '\C[A-Z]', '_\L\0', 'g')
  endif
  if x == w
    echohl WarningMsg | echomsg "Not a camelCased/under_scored word." | echohl None
    return
  endif
  if match(w, c) < 0   " cursor might sit before keyword
    execute "normal! f" . strpart(w, 0, 1)
    execute "normal! \"_ciw\<C-R>=x\<CR>"
  else
    execute "normal! \"_ciw\<C-R>=x\<CR>"
  endif
endfunction
nnoremap <LocalLeader>x :call WordTransform()<CR>

" }}}2   :symbol / 'string' 轉換    {{{2

  " TODO 根本沒實作
  " function! SymbolStringTransform()
  "     let w = expand("<cword>")
  "     let x = ''
  "     let c = strpart(getline('.'), col('.') - 1, 1)
  " endfunction

" }}}2   JSLint   {{{2

command! -nargs=* JSLint call JSLint(<f-args>)
" @param boolean interact: 1 to prompt before lint.
" @param string options: custom options for running JSLint. in JSON string, ex: '{"onevar":false}'
function! JSLint(...)
  if !executable('jslint')
    echohl WarningMsg | echoerr "jslint command not found." | echohl None
    return
  endif
  let input    = expand('%')
  let interact = a:0 > 0 ? a:1 : 0
  let options  = a:0 > 1 ? a:2 : ''

  if &modified
    echomsg 'No write since last change, write before lint? (y/n) '
    let ans = getchar()
    if nr2char(ans) == 'y' | w
    elseif nr2char(ans) != 'n' | redraw! | echomsg 'JSLint aborted.' | return
    endif
  endif

  if &filetype == 'javascript'
    let cmd = 'jslint ' . input . ' ' . options
    if interact
      echomsg 'JSLint ' . input . '? (y/n) ' | redraw
      let yes = getchar()
      if nr2char(yes) == 'y'
        return DoJSLint(cmd, input)
      else
        redraw!
        echomsg 'JSLint aborted.'
        return
      endif
    else
      return DoJSLint(cmd, input)
    endif
  else
    echohl WarningMsg | echomsg "Unsupported filetype." | echohl None
  endif
endfunction

function! DoJSLint(cmd, file)
  echomsg "JSLint in progress..."
  let ret = system(a:cmd)
  if v:shell_error
    cexpr ret
    if len(getqflist()) > 0
      QFix!<CR>
    endif
  else
    redraw
    echomsg "No problems found in " . a:file
    return
  endif
endfunction

" }}}2   JSHint   {{{2

command! -nargs=* JSHint call JSHint(<f-args>)
" TODO cli flags (--verbose, --reporter, .etc)
function! JSHint(...)
  if !executable('jshint')
    echohl WarningMsg | echoerr "jshint command not found." | echohl None
    return
  endif
  let input    = expand('%')
  let interact = a:0 > 0 ? a:1 : 0
  let options  = a:0 > 1 ? a:2 : ''

  if &modified
    echomsg 'No write since last change, write before lint? (y/n) '
    let answer = getchar()
    if nr2char(answer) == 'y' | w
    elseif nr2char(answer) != 'n' | redraw! | echomsg 'JSHint aborted.' | return
    endif
  endif

  if &filetype == 'javascript'
    let reporter = expand('~/.vim/jshint-reporter.js')
    let cmd = 'jshint ' . input . ' ' . options . ' --reporter=' . reporter
    if interact
      echomsg 'JSHint ' . input . '? (y/n) ' | redraw
      let yes = getchar()
      if nr2char(yes) == 'y'
        return DoJSHint(cmd, input)
      else
        redraw!
        echomsg 'JSLint aborted.'
        return
      endif
    else
      return DoJSHint(cmd, input)
    endif
  else
    echohl WarningMsg | echomsg "Unsupported filetype." | echohl None
  endif
endfunction

function! DoJSHint(cmd, file)
  echomsg "JSHint in progress..."
  let ret = system(a:cmd)
  if v:shell_error
    silent cexpr ret
    if len(getqflist()) > 0
      QFix!<CR>
    endif
  else
    redraw
    echomsg "No problems found in " . a:file
    return
  endif
endfunction

" }}}2   js 壓縮（Closure Compiler）    {{{2

if !exists('g:enable_js_compress')
  let g:enable_js_compress = 1
endif


command! ToggleJsCompress call ToggleJsCompress()
function! ToggleJsCompress()
  let g:enable_js_compress = !g:enable_js_compress
endfunction


command! -bang -nargs=* JsCompress call JsCompress(<bang>0, <f-args>)
" @param boolean save     0: save to temp file and return compressed content.
"                         1: save with alternative filename, return the new name.
" @param boolean interact 1 to prompt before starting compression.
" @param string options   extra options for running the compiler.
function! JsCompress(save, ...)
  if !g:enable_js_compress
    return
  endif
  let jar      = expand('~/') . 'bin/closure-compiler.jar'
  let defaults = ' --compilation_level=SIMPLE_OPTIMIZATIONS'
              \ . ' --create_source_map ~/closure-compiler-map'
              \ . ' --warning_level=QUIET'
  let input    = expand('%')

  let interact = a:0 > 0 ? a:1 : 0
  let options  = a:0 > 1 ? a:2 : ''

  if &modified
    echomsg 'No write since last change, write before compression? (y/n) '
    let ans = getchar()
    if nr2char(ans) == 'y' | w
    elseif nr2char(ans) != 'n' | redraw! | echomsg 'Compression aborted.' | return
    endif
  endif

  if !executable(jar)
    echohl WarningMsg | echoerr "Can't execute java jar." | echohl None
    return
  endif

  if !a:save
    let output = tempname()
  elseif match(input, '-debug\.js$') > 0
    let output = substitute(input, '-debug\.js$', '\.js', '')
  elseif match(input, '-src\.js$') > 0
    let output = substitute(input, '-src\.js$', '\.js', '')
  else
    let output = substitute(input, '\.js$', '\.min\.js', '')
  endif

  if &filetype == 'javascript'
    if executable('cygpath')
      let cmd = 'java -jar `cygpath -wp ' . jar . '`' . defaults
            \ . ' ' . options
            \ . ' --js=`cygpath -wp ' . input . '`'
            \ . ' --js_output_file=`cygpath -wp ' . output . '`'
    else
      let cmd = 'java -jar ' . jar . defaults . ' ' .options . ' --js=' . input . ' --js_output_file=' . output
    endif
    let cmd .= " 2>&1 \\\\| sed '/^$/d'"

    if interact
      echomsg 'Compress ' . input . ' to ' . output . '? (y/n/s (skip in this session)) '
      let yes = getchar()
      if nr2char(yes) == 'y'
        return DoJsCompress(cmd, output, a:save)
      elseif nr2char(yes) == 's'
        call ToggleJsCompress()
        redraw!
        echomsg 'Disable compression in this session (run :ToggleJsCompress for toggle.)'
        return
      else
        redraw!
        echomsg 'Compression aborted.'
        return
      endif
    else
      return DoJsCompress(cmd, output, a:save)
    endif
  else
    echohl WarningMsg | echomsg "Unsupported filetype." | echohl None
  endif
endfunction


function! DoJsCompress(cmd, file, save)
  let makeprg_orig = &makeprg
  execute "set makeprg=" . escape(a:cmd, ' \"')
  silent make
  let &makeprg = makeprg_orig
  if a:save
    let ret = a:file
  else
    let ret = join(readfile(a:file), "\n")
    call delete(a:file)
  endif
  if len(getqflist()) == 0
    redraw!
    echomsg "Compression completed." (a:save ? '' : '(result written to temporarily file.)')
    return ret
  else
    return 0
  endif
endfunction

" }}}2   bookmarklet 壓縮    {{{2

command! -nargs=* Bookmarklet call Bookmarklet(<f-args>)
function! Bookmarklet(...)
  let result = JsCompress(0, 0, '--compilation_level=WHITESPACE_ONLY')
  if len(getqflist()) == 0 && strlen(result) > 0
    let reuse_win = 0
    for winnr in tabpagebuflist(tabpagenr())
      if bufname(winnr) == '[Bookmarklet]'
        execute winnr . 'wincmd w'
        let reuse_win = winnr
      endif
    endfor
    if !reuse_win
      execute 'belowright 5new [Bookmarklet]'
      setlocal noswapfile bufhidden=wipe winfixheight filetype=javascript
    endif
    let result = substitute(result, '[\n]', '', '')
    setlocal buftype=
    call setline(1, 'javascript:(function(){' . result . '})();')
    if has('ruby')
      ruby require("uri"); VIM::Buffer.current.line = URI.escape(VIM::Buffer.current.line);
    else
      echohl WarningMsg | echomsg "No ruby support. Can't do URI encoding." | echohl None
    endif
    setlocal buftype=nofile
  endif
endfunction

" }}}2   Toggle QuickFix window    {{{2

" http://vim.wikia.com/wiki/Toggle_to_open_or_close_the_quickfix_window
command! -bang -nargs=? QFix call QFixToggle(<bang>0)
fu! QFixToggle(forced)
  if exists("g:qfix_win") && a:forced == 0
    cclose
    unlet g:qfix_win
  else
    copen 10
    let g:qfix_win = bufnr("$")
  endif
endfunction
nnoremap <silent> <LocalLeader>q :QFix<CR>

" }}}2   尋找選取的文字    {{{2

" Ref: kana - https://github.com/kana/config
vnoremap * :<C-U>set hlsearch<CR>:call <SID>search_selected_text_literaly('n')<CR>
vnoremap # :<C-U>set hlsearch<CR>:call <SID>search_selected_text_literaly('N')<CR>

function! s:search_selected_text_literaly(search_command)
  call SaveReg('0')
  call SaveReg('"')

  normal! gvy
  let pattern = escape(@0, '\')
  let pattern = substitute(pattern, '\V\n', '\\n', 'g')
  let @/ = pattern
  call histadd('/', '\V' . pattern)
  execute 'normal!' a:search_command
  let v:searchforward = a:search_command ==# 'n'

  call RestoreReg('0')
  call RestoreReg('"')
endfunction

" }}}2   關閉各種 layout 模式    {{{2

command! -nargs=0 QuickOff call <SID>quick_off()
function! s:quick_off()
  if winnr('$') > 1
    if <SID>gblame_window_off()
      return
    elseif <SID>ref_window_off()
      return
    elseif exists('t:gitdiffall_info')
      execute 'GitDiffOff'
    elseif winnr('$') > 1 && &diff
      execute 'wincmd t'
      call SafeDiffOff()
      only
    endif
  endif
endfunction

function! s:ref_quit()
  if &filetype =~ 'ref-\w'
    execute "quit"
  endif
endfunction

function! s:gblame_window_off()
  let win_count = winnr('$')
  silent windo if &filetype == 'fugitiveblame' | execute "normal gq" | endif
  execute 'wincmd t'
  return win_count > winnr('$')
endfunction

function! s:ref_window_off()
  let win_count = winnr('$')
  silent windo call <SID>ref_quit()
  execute 'wincmd t'
  return win_count > winnr('$')
endfunction


" }}}2   text-object for continuous comment    {{{2

" NOTE: limitations
" 1. Only test if first non-blank character is highlighted with "Comment".
" 2. Always linewise.
vnoremap <silent> ac :<C-U>call TxtObjComment()<CR>
onoremap <silent> ac :<C-U>call TxtObjComment()<CR>

function! TxtObjComment()
  if exists("g:syntax_on")
    if !IsInComment()
      echomsg 'Not in a Comment region.'
      return 0
    else
      call cursor(SearchContinuousComment(0, line(".")))
      normal! 0V
      call cursor(SearchContinuousComment(1, line(".")))
    endif
  else
    echohl ErrorMsg | echoerr "TxtObjComment: syntax highlighting not enabled." | echohl None
  endif
endfunction


function! SearchContinuousComment(forward, lnum)
  let line = a:lnum
  while line > 0 && line <= line("$")
    let next = a:forward ? line + 1 : line - 1
    if next > 0 && next < line("$") && IsInComment(next)
      let line = next
    else
      break
    endif
  endwhile
  return [line, 0]
endfunction


function! IsInComment(...)
  let lnum = a:0 > 0 ? a:1 : line(".")
  let col = a:0 > 1 ? a:2 : indent(lnum) + 1
  let synStack =  synstack(lnum, col)
  let inComment = 0
  for syn in synStack
    if synIDattr(synIDtrans(syn), "name") ==# 'Comment'
      let inComment = 1
    endif
  endfor
  return inComment
endfunction

" }}}2

" }}}1    Functions      =====================================================


" Filetype Specific:             {{{1 ========================================
" TODO: manage b:undo_ftplugin option
" TODO: refactor

" }}}2   :TOhtml    {{{2

let g:html_no_progress = 0
let g:html_use_css = 1
let g:html_ignore_conceal = 0
let g:html_pre_wrap = 0
let g:html_use_xhtml = 0
function! s:to_html(line1, line2)
  let save_number = get(g:, 'html_number_lines', -1)
  let g:html_number_lines = 0
  call tohtml#Convert2HTML(a:line1, a:line2)
  setlocal buftype=nofile bufhidden=hide noswapfile nobuflisted
  call search("<pre[^<]*>")
  normal! dit
  %delete _
  let @" = '<pre>' . substitute(@", '\v^\n\s*', '', '') . '</pre>'
  call setline(1, split(@", '\n'))
  if save_number > -1
    let g:html_number_lines = save_number
  else
    unlet g:html_number_lines
  endif
endfunction
command! -range=% TOhtml :call <SID>to_html(<line1>, <line2>)
command! -range=% TOhtmlDoc :call tohtml#Convert2HTML(<line1>, <line2>)

" }}}2   JavaScript   {{{2

function! s:js_rc()
  setlocal iskeyword+=$
  setlocal iskeyword-=58
  setlocal cindent
endfunction

" }}}2   CSS   {{{2

function! s:css_rc()
  set foldmethod=marker
  setlocal iskeyword-=58
  setlocal path+=./;/home/www/
endfunction

" }}}2   SCSS   {{{2

function! s:scss_rc()
  setlocal foldmethod=marker
  setlocal formatoptions=l2
  try
    setlocal formatoptions+=j
  catch /^Vim\%((\a\+)\)\=:E539/
  endtry
  setlocal path+=./;/home/www/
  " TODO load hail2u/vim-css3-syntax plugin
endfunction

" }}}2   HAML   {{{2

function! s:haml_rc()
  inoremap <LocalLeader>br <br><CR>
  setlocal iskeyword-=58
endfunction

" }}}2   HTML   {{{2

let bundle = neobundle#get('html5.vim')
function! bundle.hooks.on_source(bundle)
  setfiletype html  " require for loading html5.vim/indent files (why?)
endfunction

function! s:html_rc()
  setlocal path+=./;/
  inoremap <LocalLeader>br <br><CR>
  inoremap <buffer> ;; <C-\><C-N>:call <SID>html_make_tag()<CR>
  inoremap <buffer> >> <C-\><C-N>:call <SID>html_close_tag()<CR>
  let html_no_rendering = 1
  let g:html5_event_handler_attributes_complete = 0
  let g:html5_rdfa_attributes_complete = 0
  let g:html5_microdata_attributes_complete = 0
  let g:html5_aria_attributes_complete = 0
  if exists('g:xmldata_html5')
    let b:html_omni_flavor = 'html5'
  end
endfunction

function! s:html_make_tag()
  let save_reg = [getreg(), getregtype()]
  execute "normal! a \<C-\>\<C-N>db"
  let tag_name = @"
  call setreg(v:register, save_reg[0], save_reg[1])

  " Skip invalid tag_name (non-words)
  if tag_name =~ '\W'
    " Special case to break single-line tag into multiline form. (that is, 'make' an existed tag)
    " e.g.: when input ;; between <div></div>
    if tag_name == '>' && search('\%#\s*<', 'cnW', line('.'))
      execute "normal! cl" . tag_name . "\<C-\>\<C-N>a\<CR>"
      call feedkeys('O', 'n')
    else
      execute "normal! cl" . tag_name
      call feedkeys('a;;', 'n')
    endif
    return
  endif

  let unaryTagsStack = get(b:, 'unaryTagsStack', "area base br col command embed hr img input keygen link meta param source track wbr")
  if index(split(unaryTagsStack, '\s'), tag_name, 'ic') >= 0
    execute "normal! a<" . tag_name . ">"
    call feedkeys('a', 'n')
  else
    " Don't break tag into multi lines if current line is not empty.
    if getline('.') =~ '\S'
      execute "normal! cl<" . tag_name . "></" . tag_name . ">\<C-\>\<C-N>F>"
      call feedkeys('a', 'n')
    else
      execute "normal! cl<" . tag_name . ">\<CR></" . tag_name . ">\<C-\>\<C-N>O"
      call feedkeys('"_cc', 'n')
    endif
  endif
endfunction

function! s:html_close_tag()
  " Find < or >, should take action only when < appear first.
  if search('\v(\<)|(\>)', 'bnpW') == 2
    let missing_gt = getline('.')[col('.')-1] == '>' ? '' : '>'
    execute "normal! a" . missing_gt . "</" . "\<C-X>\<C-O>" . "\<C-\>\<C-N>F<"
    call feedkeys('i', 'n')
  else
    call feedkeys('a>>', 'n')
  endif
endfunction

" }}}2   XML   {{{2

function! s:xml_rc()
  inoremap <buffer> ;; <C-\><C-N>:call <SID>html_make_tag()<CR>
  inoremap <buffer> >> <C-\><C-N>:call <SID>html_close_tag()<CR>
endfunction

" }}}2   Ruby   {{{2

function! s:ruby_rc()
  setlocal cindent
  setlocal iskeyword-=58

  " |ft-ruby-omni|
  let g:rubycomplete_buffer_loading = 1
  let g:rubycomplete_classes_in_global = 1
  " let g:rubycomplete_rails = 1

  let g:ruby_operators = 0
  let g:ruby_space_errors = 1
  let g:ruby_no_expensive = 0
  let ruby_minlines = 70
endfunction

" }}}2   PHP   {{{2

function! s:php_rc()
  let php_asp_tags = 1
  let php_parent_error_close = 1
  let php_parent_error_open = 1
  setlocal iskeyword-=58 cindent
  set makeprg=php\ -l\ %
  set errorformat=%m\ in\ %f\ on\ line\ %l
endfunction

" }}}2   help   {{{2

function! s:help_rc()
  set number
  if version >= 703
    set conceallevel=1
    set concealcursor=nc
    set colorcolumn=+1
  endif
  nnoremap <silent> <buffer> <LocalLeader>= :call HelpHyperTextEntryJustify()<Enter>
endfunction

" }}}2   Vim   {{{2

function! s:vim_rc()
  " let g:vim_indent_cont = 0
  set path+=~/.vim/bundle
endfunction

" }}}2   zsh   {{{2

function! s:zsh_rc()
  setlocal iskeyword-=-
endfunction

" }}}2   git commit   {{{2

function! s:gitcommit_rc()
  setlocal textwidth=72
endfunction

" }}}2   git config   {{{2

function! s:gitconfig_rc()
endfunction

" }}}2   nginx config   {{{2

function! s:nginx_rc()
  setlocal iskeyword-=.
  setlocal iskeyword-=/
endfunction

" }}}2   yaml config   {{{2

function! s:yaml_rc()
endfunction

" }}}2   logs   {{{2

function! s:logs_rc()
endfunction

" }}}2

" }}}1    Filetype Specific      =============================================


" Autocommands:             {{{1 =============================================

augroup my_vimrc

  autocmd FileType * try |
        \   setlocal formatoptions=roql2mj |
        \ catch /^Vim\%((\a\+)\)\=:E539/ |
        \   setlocal formatoptions=roql2m |
        \ endtry

  autocmd FileType php,xml,html inoremap <buffer> <LocalLeader>/ </<C-X><C-O>

  autocmd FileType ruby call s:ruby_rc()
  autocmd FileType xml call s:xml_rc()
  autocmd FileType html,xhtml,haml,eruby,phtml call s:html_rc()
  autocmd FileType haml call s:haml_rc()
  autocmd FileType php call s:php_rc()
  autocmd FileType javascript call s:js_rc()
  autocmd FileType css call s:css_rc()
  autocmd FileType scss call s:scss_rc()
  autocmd FileType help call s:help_rc()
  autocmd FileType vim call s:vim_rc()
  autocmd FileType zsh call s:zsh_rc()
  autocmd FileType gitcommit call s:gitcommit_rc()
  autocmd FileType gitconfig call s:gitconfig_rc()
  autocmd FileType nginx call s:nginx_rc()
  autocmd FileType yaml call s:yaml_rc()

  autocmd FileType sh let g:is_bash=1

  autocmd FileType vim setlocal tabstop=2 softtabstop=2 shiftwidth=2 foldmethod=marker
  autocmd FileType rake,ruby,eruby,yaml setlocal tabstop=2 softtabstop=2 shiftwidth=2

  " autocmd BufNewFile *.html  :0r ~/.vim/templates/html5.html
  autocmd BufNewFile *.html  :0r ~/.vim/templates/html.html
  " autocmd BufNewFile *.css  :0r ~/.vim/templates/style.css
  autocmd BufNewFile *.css  :0r ~/.vim/templates/css.css
  autocmd BufNewFile,BufRead /bootleq/notes/*.txt set modeline

  " Firefox It's all text
  autocmd BufRead www*.blogger.com*.txt setfiletype html
  autocmd BufRead redmine.*.com*.txt setfiletype textile
  autocmd BufRead pma.*com.*.txt setfiletype sql

  autocmd BufRead,BufNewFile /opt/nginx*/conf/*.conf,/opt/nginx*/conf/*.default setfiletype nginx
  autocmd BufRead /home/www/logs/*.log setfiletype httplog
  autocmd BufRead /home/www/logs/*.log nnoremap <buffer> <LocalLeader>ddd :EmptyFile<CR>
  autocmd BufRead /home/www/fc/log/*.log nnoremap <buffer> <LocalLeader>ddd :EmptyFile<CR>

  " let apache_version = "2.0"
  " let dosbatch_cmdextversion = 2

  autocmd CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
  autocmd InsertLeave * if &paste | set nopaste | set paste? | endif
  autocmd BufReadPost * if line("'\"") > 0 && line ("'\"") <= line("$") | execute "normal! g'\"" | endif
  autocmd BufWinEnter * if exists('s:tabLineNeedRedraw') && s:tabLineNeedRedraw | redraw! | let s:tabLineNeedRedraw = 0 | endif
  autocmd QuickFixCmdPost * redraw!
  autocmd QuickFixCmdPost * if len(getqflist()) > 0 | :QFix!<CR> | endif
  autocmd FileType qf setlocal modifiable statusline=%q\ %1*%<%-.{exists('w:quickfix_title')\ ?\ w:quickfix_title\ :\ ''}%0*

  if has("gui_win32")
    autocmd GUIEnter * simalt ~x
  else
    autocmd GUIEnter * winpos 0 0 | redraw!
  endif

  " Change default new file title
  autocmd BufEnter * call s:change_scratch_name(expand('<afile>'))
  function! s:change_scratch_name(file)
    if a:file == ""
      let &titlestring = "[New]"
    else
      set titlestring=%t%(\ %M%)%(\ (%{expand(\"%:~:.:h\")})%)%(\ %a%)
    endif
  endfunction

  " Ref: tyru - https://github.com/tyru/dotfiles
  autocmd BufWriteCmd *[,*],*'* call s:write_check_typo(expand('<afile>'))
  function! s:write_check_typo(file)
    if a:file =~ '[qfreplace]'
      return
    endif
    let prompt = "possible typo: really want to write to '" . a:file . "'? (y/n):"
    if input(prompt) =~? '^\s*y'
      execute 'write' a:file
    endif
  endfunction

  autocmd FileWritePost,BufWritePost *-\(debug\|src\).js :JsCompress! 1
  if has("autocmd") && exists("+omnifunc")
    autocmd Filetype *
          \ if &l:omnifunc == "" |
          \ setlocal omnifunc=syntaxcomplete#Complete |
          \ endif
  endif

  autocmd FilterWritePre * call s:config_in_diff_mode()

  " Modified from http://nanabit.net/blog/2007/11/03/vim-cursorline/
  " Note: not recover when canceling FuzzyFinder.
  " autocmd WinLeave * setlocal nocursorline
  " autocmd WinEnter,BufRead * setlocal cursorline

augroup END

" }}}1    Autocommands             ===========================================


" Finish:                  {{{1 ==============================================

unlet! s:i
set secure

" vim: expandtab softtabstop=2 shiftwidth=2 foldmethod=marker
