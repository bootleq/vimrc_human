" Vim configure file
" Author: bootleq <bootleq@gmail.com>
" Blog:   bootleq.blogspot.com
" ============================================================================


" Startup:                 {{{1 ==============================================

if !exists('s:vimrc_loaded')
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

" }}}1   Startup                ==============================================


" Vundle:                 {{{1 ===============================================

" Setup {{{2

let s:rtp="~/.vim"

if has("gui_win32") | let s:rtp='c:\cygwin\home\admin\.vim' | endif

if expand("<sfile>") == '/etc/users/bootleq/.vimrc'
      \  && substitute(system("whoami"), '\n$', '', '') != 'bootleq'
      \  && !exists("g:did_bootleq_runtime")
  let s:rtp="/etc/users/bootleq/.vim"
  let g:did_bootleq_runtime = 1
endif

if expand("<sfile>") == '/tmp/vimrc_human/bootleq/.vimrc'
      \  && !exists("g:did_vimrc_human_runtime")
  let s:rtp="/tmp/vimrc_human/bootleq/.vim"
  let g:did_vimrc_human_runtime = 1
endif

if !isdirectory(fnamemodify(s:rtp, ':p'))
  try
    call mkdir(fnamemodify(s:rtp, ':p'), "p")
  catch /^Vim\%((\a\+)\)\=:E739/
    echo "Error detected while processing: " . v:throwpoint . ":\n  " . v:exception .
          \  "\nCan't make vundle runtime directory. Skipped sourcing vimrc.\n"
    finish
  endtry
endif

execute "set runtimepath+=" . fnamemodify(s:rtp, ':p') . "bundle/vundle"
filetype off

try
  call vundle#rc(fnamemodify(s:rtp, ':p') . "bundle")
catch /^Vim\%((\a\+)\)\=:E117/
  echo "Error detected while processing: " . v:throwpoint . ":\n  " . v:exception .
        \ "\n\nNo Vundle installed for this vimrc. Skipped sourcing.\n\nTo install Vundle:\n  " .
        \ "git clone http://github.com/gmarik/vundle.git " . fnamemodify(s:rtp, ":p") . "bundle/vundle\n"
  finish
endtry

set runtimepath-=~/.vim

" }}}2    Bundles   {{{2

Bundle 'gmarik/vundle'
Bundle 'L9'

Bundle 'FuzzyFinder'
Bundle 'Indent-Guides'
Bundle 'JSON.vim'
Bundle 'JavaScript-syntax'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'Raimondi/delimitMate'
Bundle 'Shougo/neocomplcache'
Bundle 'VisIncr'
Bundle 'bootleq/ShowMarks'
Bundle 'bootleq/camelcasemotion'
Bundle 'bootleq/gsession.vim'
Bundle 'bootleq/tcomment_vim'
Bundle 'bootleq/vim-color-bootleg'
Bundle 'bootleq/vim-cycle'
Bundle 'bootleq/xml.vim'
Bundle 'chrisbra/histwin.vim'
Bundle 'depuracao/vim-rdoc'
Bundle 'git://github.com/jiangmiao/simple-javascript-indenter.git'
Bundle 'h1mesuke/vim-alignta'
Bundle 'hail2u/vim-css3-syntax'
Bundle 'httplog'
Bundle 'kana/vim-surround'
Bundle 'mrkn256.vim'
Bundle 'netrw.vim'
Bundle 'nginx.vim'
Bundle 'othree/html5.vim'
Bundle 'plasticboy/vim-markdown'
Bundle 'taglist.vim'
Bundle 'thinca/vim-prettyprint'
Bundle 'thinca/vim-ref'
Bundle 'timcharper/textile.vim'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-haml'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-repeat'
Bundle 'tyru/open-browser.vim'
Bundle 'vim-ruby/vim-ruby'
Bundle 'wokmarks.vim'

" Bundle 'thinca/vim-ambicmd'
" Bundle 'kana/vim-altercmd'
" Bundle 'kana/vim-fakeclip'
" Bundle 'kana/vim-grex'
" Bundle 'CountJump'
" Bundle 'AndrewRadev/splitjoin.vim'
" Bundle 'Shougo/vimshell'
" Bundle 'kana/vim-ku'
" Bundle 'kana/vim-smartword'
" let &rtp='~/repository/vim-cycle,' . &rtp

" text-obj-user {{{3

Bundle 'bootleq/vim-textobj-rubysymbol'
Bundle 'kana/vim-textobj-diff'
Bundle 'kana/vim-textobj-fold'
Bundle 'kana/vim-textobj-indent'
Bundle 'kana/vim-textobj-user'
Bundle 'nelstrom/vim-textobj-rubyblock'

" }}}3 operator-user {{{3

Bundle 'kana/vim-operator-user'
Bundle 'kana/vim-operator-replace'
Bundle 'tyru/operator-html-escape.vim'

" }}}3 unite {{{3

Bundle 'Shougo/unite.vim'
Bundle 'thinca/vim-unite-history'
Bundle 'tsukkee/unite-help'

" }}}3 SnipMate {{{3
Bundle 'bootleq/snipmate.vim'
" Bundle "MarcWeber/vim-addon-mw-utils"
" Bundle "tomtom/tlib_vim"
" Bundle "bootleq/snipmate-snippets"
" Bundle "garbas/vim-snipmate"
" }}}3

" }}}2    Finish   {{{2

filetype plugin indent on

" }}}2

" }}}1   Vundle                ===============================================


" Basic Options:               {{{1 ==========================================

" }}}2    檔案格式    {{{2

set fileformats=unix
set noendofline

" }}}2   GUI    {{{2

if has("gui_running")
  set antialias=true
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
  else
    set guifont=Consolas\ 14
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
set updatecount=0

" }}}2    term 相關調整     {{{2

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
set cinkeys-=:      " TODO 經常亂縮
set cinoptions+=(0
set textwidth=78
setlocal formatoptions=roql2m
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
set nolinebreak
set display=lastline
set listchars=tab:>-,eol:¬,trail:*
set background=dark
set ambiwidth=double
syntax on

" http://blogger.godfat.org/2011/07/spellcheck-only-for-english-in-vim.html
syntax match Normal /[^!-~]/ contains=@NoSpell

if !exists('g:colors_name')
  set background=dark
  colorscheme bootleg
endif

set title titlestring=%t%(\ %M%)%(\ (%{expand(\"%:~:.:h\")})%)%(\ %a%)
set statusline=%<%f\ %h%m%r%w%=%-14.(%l,%c%V%)\ %P
" set statusline=%<%f\ %h%m%r%w%=[%{&undolevels}]\ %-14.(%l,%c%V%)\ %P
" set laststatus=2
set tabline=%!SetTabLine()
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
" set includeexpr=substitute(v:fname,'\\.','/','g')

" }}}2    自動完成    {{{2

set omnifunc=syntaxcomplete#Complete
set pumheight=20
set menuitems=35
set completeopt=longest,menu
set complete+=U

set wildmenu
set wildmode=longest:full,full
set wildignore+=*.o,*.a,*.so,*.obj,*.exe,*.lib,*.ncb,*.opt,*.plg,.svn,.git

" }}}2   多檔案編輯    {{{2

set splitbelow
set splitright
set noequalalways
set previewheight=9
set switchbuf=useopen,usetab,newtab
set tabpagemax=80
set diffopt+=vertical,context:4,foldcolumn:1

" }}}2   Vim 7.3    {{{2

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

noremap <expr> <Space>  repeat('<ScrollWheelDown>', 2)
nnoremap <expr> <LocalLeader><Space> repeat('<ScrollWheelUp>', 2)
noremap <expr> <C-Down> repeat('<ScrollWheelDown>', 3)
noremap <expr> <C-Up>   repeat('<ScrollWheelUp>', 3)

noremap j gj
noremap k gk
noremap gj j
noremap gk k
inoremap <expr> <Down> pumvisible() ? "\<C-N>" : "\<C-O>gj"
inoremap <expr> <Up> pumvisible() ? "\<C-P>" : "\<C-O>gk"

nmap <silent><Home> :call SmartHome("n")<CR>
nmap <silent><End> :call SmartEnd("n")<CR>
imap <silent><Home> <C-R>=SmartHome("i")<CR>
imap <silent><End> <C-R>=SmartEnd("i")<CR>
vmap <silent><Home> <Esc>:call SmartHome("v")<CR>
vmap <silent><End> <Esc>:call SmartEnd("v")<CR>

map  <kHome> <Home>
map! <kHome> <Home>
map  <kEnd>  <End>
map! <kEnd>  <End>

nnoremap ' `

nmap <LocalLeader>w <C-W>
nnoremap <C-W>gf :tab wincmd f<CR>
nnoremap <LocalLeader>gf :tab wincmd f<CR>
nnoremap <expr> <CR> &modifiable ? "i<CR><C-\><C-N>" : "<C-]>"
nnoremap <expr> <BS> &modifiable ? "i<C-W><C-\><C-N>" : "<C-O>"

nnoremap gr gT
nnoremap <silent> gT :tablast<CR>
nnoremap <silent> gR :tabfirst<CR>
nnoremap <silent> <LocalLeader>gT :tabmove<CR>
nnoremap <silent> <LocalLeader>gR :tabmove 0<CR>

" }}}2   編輯    {{{2

nmap <C-H> <BS>
nnoremap p ]p
nnoremap Y y$
nnoremap vaa ggVG
nnoremap <LocalLeader>gv V`]

autocmd FileType qf nnoremap <buffer> <CR> <CR>

noremap  <S-Tab> >>
inoremap <S-Tab> <C-T>
xnoremap <Tab>   >gv
xnoremap <S-Tab> <gv
nnoremap <LocalLeader>< i0<C-D><C-\><C-N>
inoremap <LocalLeader>< 0<C-D>
xnoremap <LocalLeader>< 99<

inoremap <C-Z> <C-O>u
inoremap <C-W> <C-G>u<C-W>
inoremap <expr> <C-U> (pumvisible() ? "\<C-E>" : '') . "\<C-G>u\<C-U>"

inoremap <LocalLeader>o <C-O>

noremap <silent> <C-S> :update<CR>
inoremap <silent> <C-S> <C-\><C-N>:update<CR>
xnoremap <silent> <C-S> <C-\><C-N>:update<CR>

noremap <C-Del> :quit<CR>
noremap <C-kDel> :quit<CR>
map <kDel> <Del>

" Ref: tyru - https://github.com/tyru/dotfiles
cnoremap <LocalLeader>d <C-\>e getcmdpos() == 1 ? '' : getcmdline()[:getcmdpos()-2]<CR>

" }}}2   功能鍵    {{{2

map  <F1> :help <C-R>=expand('<cword>')<CR><CR>
map  <LocalLeader><F1> :tab help <C-R>=expand('<cword>')<CR><CR>
xmap <F1> :<C-U>call SaveReg()<CR>gvy:let b:tempReg=@"<CR>:call RestoreReg()<CR>:help <C-R>=b:tempReg<CR><CR>
xmap <LocalLeader><F1> :<C-U>call SaveReg()<CR>gvy:let b:tempReg=@"<CR>:call RestoreReg()<CR>:help <C-R>=b:tempReg<CR><CR>

nmap <F2> :%s/<C-R><C-W>
xmap <F2> :<C-U>call SaveReg()<CR>gvy:let b:tempReg=@"<CR>:call RestoreReg()<CR>gv:<C-U>%s/ <C-R>=b:tempReg<CR>

noremap <silent> <F3> :nohlsearch<CR>
inoremap <silent> <F3> <C-O>:nohlsearch<CR>
noremap <silent> <F4> :set hlsearch<CR>
inoremap <silent> <F4> <C-O>:set hlsearch<CR>

nnoremap <F5> :call SynStackInfo()<CR>
nnoremap <Leader><F5> :tabdo e!<CR>
nnoremap <F6> :GitDiffOff<CR>

nnoremap <silent><F8> :setlocal spell! spelllang=en_us spell?<CR>
xnoremap <silent><F8> :<C-U>setlocal spell! spelllang=en_us spell?<CR>gv
inoremap <silent><F8> <C-O>:setlocal spell! spelllang=en_us spell?<CR>

set pastetoggle=<F11>
map  <silent> <F12> :set list!<CR>
imap <silent> <F12> <C-O>:set list!<CR>

" }}}2   自動完成    {{{2

cnoremap <LocalLeader>. <C-E>
cnoremap <LocalLeader><CR> <C-E>

inoremap <LocalLeader>. <C-X><C-O>
inoremap <expr> <C-J> pumvisible() ? "\<C-N>" : "\<C-J>"
inoremap <expr> <C-K> pumvisible() ? "\<C-P>" : "\<C-K>"

" }}}2   跨 Vim 剪貼    {{{2

" http://vim.wikia.com/wiki/Transfer_text_between_two_Vim_instances
nmap <Leader>xp :r $HOME/.vimxfer<CR>
nmap <Leader>xy V:w! $HOME/.vimxfer<CR>
vmap <Leader>xy :w! $HOME/.vimxfer<CR>
vmap <Leader>xa :w>> $HOME/.vimxfer<CR>

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

" }}}2   User operators    {{{2

nmap <LocalLeader>r <Plug>(operator-replace)
xmap <LocalLeader>r <Plug>(operator-replace)
nmap <LocalLeader>he <Plug>(operator-html-escape)
xmap <LocalLeader>he <Plug>(operator-html-escape)
nmap <LocalLeader>hd <Plug>(operator-html-unescape)
xmap <LocalLeader>hd <Plug>(operator-html-unescape)

" }}}2   w!!    {{{2

cnoremap <expr> w!! ((getcmdtype() == ':' && getcmdpos() <= 1) ? 'w !sudo tee % >/dev/null'  : 'w!!')

" }}}2   停用鍵、其他    {{{2

nmap ZZ <Nop>
nmap ZQ <Nop>

" }}}2

" }}}1   Mappings              ==============================================


" Commands:             {{{1 =================================================

if executable('cat')
  command! EmptyFile call system("cat /dev/null > " . shellescape(expand('%:p'))) | checktime
endif

command! Rnginx execute "!sudo\ service nginx restart"

" Ref: tsukkee - https://github.com/tsukkee/config
command! -nargs=1 -bang -complete=file Rename saveas<bang> <args> | call delete(expand('#'))

" Ref: kana - https://github.com/kana/config
command! -bar -complete=file -nargs=+ Grep call s:grep('grep', [<f-args>])
command! -bar -complete=file -nargs=+ Lgrep call s:grep('lgrep', [<f-args>])
function! s:grep(command, args)
  execute a:command '/'.a:args[-1].'/' join(a:args[:-2])
endfunction


" call altercmd#load()
" call altercmd#define('<buffer>', 'help?', 'HelpForWhat')
" command! HelpForWhat echoerr "Sure.  Is this help you?"

" }}}1    Commands             ===============================================


" Abbreviations:		             {{{1 ========================================

cnoreabbrev <expr> t ((getcmdtype() == ':' && getcmdpos() <= 2) ? 'tabnew'  : 't')
cnoreabbrev <expr> m ((getcmdtype() == ':' && getcmdpos() <= 2) ? 'messages'  : 'm')
cnoreabbrev <expr> u ((getcmdtype() == ':' && getcmdpos() <= 2) ? 'Unite'  : 'm')
cnoreabbrev <expr> tm ((getcmdtype() == ':' && getcmdpos() <= 3) ? 'TabMessage'  : 'tm')
cnoreabbrev <expr> tms ((getcmdtype() == ':' && getcmdpos() <= 4) ? 'TabMessage scriptnames'  : 'tms')
cnoreabbrev <expr> '<,'>q ((getcmdtype() == ':' && getcmdpos() <= 7) ? 'q'  : "'<,'>q")
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
  for outFile in s:outFiles
    if filereadable(outFile)
      try
        silent execute 'cscope add ' . expand(outFile)
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
if has("gui_running")
  noremap <silent> <M-z> :TlistToggle<CR>
else
  noremap <silent> z :TlistToggle<CR>
endif

" }}}1    Ctags            ===================================================


" Plugins:             {{{1 ==================================================

runtime! ftplugin/man.vim    " 啟用 |:Man| 指令
runtime! macros/matchit.vim

" Netrw    {{{2

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

" }}}2    L9    {{{2

cnoreabbrev <expr> g ((getcmdtype() == ':' && getcmdpos() <= 2) ? 'L9GrepBufferAll'  : 'g')

" }}}2    FuzzyFinder    {{{2

noremap [fuf] <Nop>
map <LocalLeader>f [fuf]
noremap [fuf]f :FufFileWithCurrentBufferDir<CR>
noremap [fuf]r :FufMruFile<CR>
noremap [fuf]b :FufBuffer<CR>
" noremap [fuf]c :FufChangeList<CR>
noremap [fuf]t :FufBufferTagAll<CR>
noremap [fuf]h :FufHelp<CR>
noremap [fuf]q :FufQuickfix<CR>
noremap <silent> [fuf]<F5> :FufRenewCache<CR>
" nnoremap [fuf]d :FufDir<CR>
" nnoremap [fuf]m :FufBookmark<CR>
" nnoremap [fuf]d :FufBookmarkDir<CR>
noremap [fuf]p :call g:fuf_regFinder(0)<CR>
noremap [fuf]P :call g:fuf_regFinder(1)<CR>
noremap [fuf]g :call g:fuf_tabFinder()<CR>

inoremap «fuf» <Nop>
imap <LocalLeader>f «fuf»
inoremap «fuf»f <C-\><C-N>:FufFileWithCurrentBufferDir<CR>
inoremap «fuf»p <C-\><C-N>:call g:fuf_regFinder(0)<CR>
inoremap «fuf»P <C-\><C-N>:call g:fuf_regFinder(1)<CR>
inoremap «fuf»g <C-\><C-N>:call g:fuf_tabFinder()<CR>

let g:fuf_dataDir = '~/.vim/fuf-data'
let g:fuf_modesDisable = ['coveragefile', 'dir', 'line', 'bookmarkdir', 'bookmarkfile', 'mrucmd', 'jumplist', 'taggedfile', 'givenfile', 'givedir']

let g:fuf_keyOpen='<LocalLeader><CR>'
let g:fuf_keyOpenSplit=''
let g:fuf_keyOpenVsplit=''
let g:fuf_keyOpenTabpage='<CR>'
let g:fuf_keyPreview='<Space>'
let g:fuf_buffer_keyDelete='<C-D>'
let g:fuf_keyPrevPattern = '<C-PageUp>'
let g:fuf_keyNextPattern = '<C-PageDown>'

if $OSTYPE == 'cygwin'
  let g:fuf_abbrevMap = {
        \   "^r:" : [ "/cygdrive/d/repository/" ],
        \   "^w:" : ["/cygdrive/d/web"],
        \   '^vr:' : map(filter(split(&runtimepath, ','), 'v:val !~ "after$"'), 'v:val . ''/**/'''),
        \ }
else
  let g:fuf_abbrevMap = {
        \   "^r:" : [ "~/repository/" ],
        \   "^rb:" : [ "/opt/ruby/lib/ruby/gems/1.8/gems/" ],
        \   "^w:" : [ "/home/www/" ],
        \   '^vr:' : map(filter(split(&runtimepath, ','), 'v:val !~ "after$"'), 'v:val . ''/**/'''),
        \ }
endif

let g:fuf_mrufile_maxItem = 100
let g:fuf_mrucmd_maxItem = 100
let g:fuf_maxMenuWidth = 90
let g:fuf_enumeratingLimit = 50

" After VimEnter, set bookmark-dir with command 'FufBookmarkDirAdd'.
" Also use 'FufEditDataFile'.

augroup my_vimrc
  autocmd BufEnter \[fuf\] set pumheight=0
  autocmd BufLeave \[fuf\] set pumheight=25
  autocmd FileType fuf setlocal nowrap nolist
  autocmd FileType fuf inoremap <buffer> <Tab> <C-N>
  autocmd FileType fuf inoremap <buffer> <S-Tab> <C-P>
augroup END

" }}}3    FuzzyFinder find registers    {{{3

let g:fuf_regListener = {}
let g:fuf_regListener.putBefore = 0   " 0: p, 1: P

function! g:fuf_regListener.onComplete(item, method)
  let l:regName = strpart(a:item, 1, 1)
  if a:method == 4
    silent execute 'normal! "' . l:regName . (g:fuf_regListener.putBefore ? 'P' : 'p')
  else
    execute '7new [@' . escape( l:regName, '"' ) . ']'
    setlocal noswapfile buftype=nofile bufhidden=wipe
    execute '0put=@' . l:regName
    redraw
    setlocal nomodified
  endif
endfunction

function! g:fuf_regListener.onAbort()
endfunction

function! g:fuf_regFinder(putBefore)
  let g:fuf_regListener.putBefore = a:putBefore
  redir => l:regs
  silent execute ':registers'
  redir END
  let l:regList = split(l:regs, '\n')
  let l:regList = filter(l:regList, 'v:val =~ "' . escape('\m^".\s\{3,}\S\+', '\"') . '"')  " remove non-register lines
  " let l:regList = map(l:regList, 'substitute(v:val, "\\m.\\{' . &columns . '}\\zs.*", "...", "")')  " has problem with long line
  call fuf#callbackitem#launch('', 1, 'registers>', g:fuf_regListener, l:regList, 0)
endfunction

" }}}3    FuzzyFinder find tabs    {{{3

let g:fuf_tabListener = {}

function! g:fuf_tabListener.onComplete(item, method)
  let l:tabnr = matchstr(a:item, '\d\+')
  if a:method == 4
    silent execute 'normal! ' . l:tabnr . 'gt'
  else
    silent execute 'tabclose ' . l:tabnr
  endif
endfunction

function! g:fuf_tabListener.onAbort()
endfunction

function! g:fuf_tabFinder()
  if exists("s:tabLineTabs")
    let l:tabList = []
    for tab in s:tabLineTabs
      let label = tab.n . '. ' . (strlen(tab.split) > 0 ? ('(' . tab.split . ')') : '') . tab.flag . tab.filename
      if tab.n == tabpagenr()
        let label = '*' . label
      endif
      call add(l:tabList, label)
    endfor
    call fuf#callbackitem#launch('', 1, 'tabs>', g:fuf_tabListener, l:tabList, 0)
  endif
endfunction

" }}}3    FuzzyFinder find tabs

" }}}2    Unite    {{{2

nnoremap [unite] <Nop>
xnoremap [unite] <Nop>
nmap <Leader>f [unite]
xmap <Leader>f [unite]

nnoremap [unite]s :<C-U>Unite source<CR>
nnoremap <silent> [unite]f :<C-U>UniteWithBufferDir -buffer-name=files -start-insert file<CR>
nnoremap <silent> [unite]r :<C-U>Unite -buffer-name=mru -start-insert file_mru<CR>
nnoremap <silent> [unite]/ :<C-U>Unite -buffer-name=search line<CR>

nnoremap <silent> [unite]d :<C-U>Unite -buffer-name=mru_dir -start-insert directory_mru<CR>
" nnoremap <silent> [unite]t :<C-U>Unite -buffer-name=tabs -start-insert tab:no-current<CR>
nnoremap <silent> [unite]t :<C-U>Unite -buffer-name=tags -start-insert tag<CR>
nnoremap <silent> [unite]p :<C-U>Unite -buffer-name=registers -start-insert register<CR>
xnoremap <silent> [unite]p "_d:<C-U>Unite -buffer-name=register register<CR>
nnoremap <silent> [unite]b :<C-U>Unite -buffer-name=bookmarks bookmark<CR>
nnoremap <silent> [unite]b :<C-U>UniteWithBufferDir -buffer-name=files -prompt=%\  buffer file_mru bookmark file<CR>
nnoremap <silent> [unite]h :<C-U>Unite -buffer-name=helps help<CR>
" nnoremap <silent> [unite]h  :<C-u>Unite history/command<CR>
nnoremap <silent> [unite]o :<C-U>Unite outline<CR>
nnoremap <silent> [unite]q :<C-u>Unite qflist -no-quit<CR>
nnoremap <silent> [unite]g :<C-u>Unite grep -no-quit<CR>
nnoremap <silent> [unite]j :<C-u>Unite poslist<CR>

" call unite#custom_default_action('file', 'tabopen')

let g:unite_update_time = 70
" let g:unite_enable_start_insert = 1
let g:unite_enable_split_vertically = 1
" let g:unite_winwidth = 78
let g:unite_source_file_mru_time_format = "(%F %T) "

let g:unite_enable_ignore_case = 1
let g:unite_enable_smart_case = 1

function! s:unite_settings()
  nmap <buffer> <C-J> <Plug>(unite_loop_cursor_down)
  nmap <buffer> <C-K> <Plug>(unite_loop_cursor_up)
  imap <buffer> <C-J> <Plug>(unite_select_next_line)
  imap <buffer> <C-K> <Plug>(unite_select_previous_line)
endfunction
autocmd! my_vimrc FileType unite call s:unite_settings()

" }}}2    neocomplcache    {{{2

let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_underbar_completion = 1
" let g:neocomplcache_min_syntax_length = 3
" let g:neocomplcache_auto_completion_start_length = 2
" let g:neocomplcache_manual_completion_start_length = 0
" let g:neocomplcache_min_keyword_length = 3
let g:neocomplcache_enable_auto_select = 1
let g:neocomplcache_enable_auto_delimiter = 1
"let g:neocomplcache_disable_auto_select_buffer_name_pattern = '^\[\d\+\]vimshell'
"let g:neocomplcache_disable_auto_complete = 0
let g:neocomplcache_max_list = 100

let g:neocomplcache_snippets_dir = expand('~/.vim/snippets')
let g:neocomplcache_lock_buffer_name_pattern = '\[fuf\]'
let g:neocomplcache_temporary_dir = expand('~/.vim/.neocon')
if !isdirectory(g:neocomplcache_temporary_dir)
  call mkdir(g:neocomplcache_temporary_dir, "p")
endif

inoremap <LocalLeader>x <C-O>:NeoComplCacheToggle<CR>
" inoremap <expr><C-L> neocomplcache#complete_common_string()
" inoremap <expr><C-J> neocomplcache#manual_filename_complete()
imap <C-l> <Plug>(neocomplcache_snippets_expand)
smap <C-l> <Plug>(neocomplcache_snippets_expand)

let g:neocomplcache_omni_functions = {
      \ 'python' : 'pythoncomplete#Complete',
      \ 'ruby' : 'rubycomplete#Complete',
      \ }

" }}}2   alignta    {{{2

let g:alignta_default_arguments = '! \S\+'
xnoremap <silent> <LocalLeader>= :Alignta! \S\+<CR>
xnoremap <silent> <LocalLeader>A :Alignta! \S\+<CR>

" }}}2   Indent Guide    {{{2

let g:indent_guides_enable_on_vim_startup = 0
let g:indent_guides_auto_colors = 0
let g:indent_guides_guide_size = 1
let g:indent_guides_indent_levels = 30

" }}}2   Rails    {{{2

" let g:loaded_rails = 1
let g:rails_statusline = 1
let g:rails_url = 'http://localhost/'
" set title titlestring=%t%(\ %M%)%(\ (%{expand(\"%:~:.:h\")})%)%(\ %a%)%(\ %{rails#statusline(1)})%
autocmd User Rails command! Rclearlog execute "silent Rake log:clear"

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

" }}}2   GSession   {{{2

let g:autoload_session = 1
let g:autosave_session = 0
let g:gsession_non_default_mapping = 1
let g:gsession_use_git = 1
nnoremap <silent> <leader>ss    :call MakeSessionWithSafety()<CR>
nnoremap <silent> <leader>se    :GSessionEliminateCurrent<CR>
nnoremap <silent> <leader>sn    :NamedSessionMake<CR>
nnoremap <silent> <leader>sl    :NamedSessionLoad<CR>
" nnoremap <leader>sm    :NamedSessionMenu<CR>

" 特定情形下，不直接存 sessoin
function! MakeSessionWithSafety()
  let prompt = 0
  if exists('b:eikeep') || &undolevels < 0
    let prompt = '[BigFile] make session anyway? (y/n) '
  else
    for tab in range(tabpagenr('$'))
      if gettabwinvar(tab + 1, 1, '&diff')
        let prompt = '[Diff mode] make session anyway? (y/n) '
        break
      elseif bufname(tabpagebuflist(tab + 1)[0]) == '.git/COMMIT_EDITMSG'
        let prompt = '[Git commit] make session anyway? (y/n)'
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

command! -nargs=0 StashSessionBackup call StashSessionBackup()
command! -nargs=0 StashSessionBackupPop call StashSessionBackup(1)
function! StashSessionBackup(...)
  let l:stash = a:0 > 0 ? a:1 : 0
  if l:stash
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
command! -nargs=0 CleanMakeGSession call CleanMakeGSession()
function! CleanMakeGSession()
  let save_ssop = &sessionoptions
  set sessionoptions-=globals
  set sessionoptions-=localoptions
  set sessionoptions-=options
  abclear
  mapclear
  mapclear!
  GSessionMake
  execute "set sessionoptions=" . save_ssop
  echomsg 'For clearer saving, quit and re-enter Vim now.'
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

" Overwrite default mapping ys, because y is for yank.
nmap s  <plug>Ysurround
nmap ss <plug>Yssurround

" }}}2   wokmarks   {{{2

let g:wokmarks_do_maps = 0
let g:wokmarks_pool = "abcdefghijklmnopqrstuvwxyz"
nmap mm <Plug>ToggleMarkWok
map mj <Plug>NextMarkWok
map mk <Plug>PrevMarkWok
autocmd User WokmarksChange :ShowMarksOn

" }}}2    tComment    {{{2

let g:tcommentMapLeaderOp1 = ''
let g:tcommentMapLeaderOp2 = ''
let g:tc_option = ' col=1'
noremap <silent> <expr> <LocalLeader>cc ":TComment " .       (exists('b:tc_option') ? b:tc_option : g:tc_option) . "<CR>"
noremap <silent> <expr> <LocalLeader>cb ":TCommentBlock " .  (exists('b:tc_option') ? b:tc_option : g:tc_option) . "<CR>"
noremap <silent> <expr> <LocalLeader>ci ":TCommentInline " . (exists('b:tc_option') ? b:tc_option : g:tc_option) . "<CR>"
noremap <silent> <expr> <LocalLeader>c$ ":TCommentRight " .  (exists('b:tc_option') ? b:tc_option : g:tc_option) . "<CR>"
map <silent><expr> <LocalLeader>ca IsInComment() ?
      \ "vac:TComment " . (exists('b:tc_option') ? b:tc_option : g:tc_option) . "<CR>" :
      \ ":TComment " . (exists('b:tc_option') ? b:tc_option : g:tc_option) . "<CR>"

" }}}2    CamelCaseMotion    {{{2

let g:camelcasemotion_leader = 'g'

" }}}2    EasyMotion    {{{2

" let g:EasyMotion_do_mapping = 0
noremap [emotion] <Nop>
map 0 [emotion]
let g:EasyMotion_leader_key = '[emotion]'
" hi EasyMotionTarget ctermbg=none ctermfg=green
" hi EasyMotionShade  ctermbg=none ctermfg=blue

" }}}2    histwin    {{{2

let g:undo_tree_help = 0
let g:undo_tree_dtl = 0
let g:undo_tree_width = 40
" let g:undo_tree_nomod = 0

" }}}2    Cycle    {{{2

let g:cycle_no_mappings = 1
let g:cycle_max_conflict = 7
" let g:cycle_max_conflict = 1
let g:cycle_phased_search = 1
silent! nmap <silent> <LocalLeader>a <Plug>CycleNext
silent! vmap <silent> <LocalLeader>a <Plug>CycleNext

let g:cycle_default_groups = [
      \   [['true', 'false']],
      \   [['yes', 'no']],
      \   [['on', 'off']],
      \   [['+', '-']],
      \   [['>', '<']],
      \   [['"', "'"]],
      \   [['==', '!=']],
      \   [['0', '1']],
      \   [['是', '否']],
      \   [['and', 'or']],
      \   [['in', 'out']],
      \   [['min', 'max']],
      \   [['get', 'set']],
      \   [['add', 'remove']],
      \   [['to', 'from']],
      \   [['read', 'write']],
      \   [['next', 'prev', 'previous']],
      \   [['only', 'except']],
      \   [['without', 'with']],
      \   [['exclude', 'include']],
      \   [['width', 'height']],
      \   [['asc', 'desc']],
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
      \   [["first", "last"]],
      \ ]
" HTML               }}}3 {{{3
let g:cycle_default_groups += [
      \   [['h1', 'h2', 'h3'], 'sub_tag'],
      \   [['ul', 'ol'], 'sub_tag'],
      \   [['em', 'strong', 'small'], 'sub_tag'],
      \ ]

" }}}3

" FileType ruby
let g:cycle_default_groups_for_ruby = [
      \   [['accessible', 'protected']],
      \   [['stylesheet_link_tag ', 'javascript_include_tag ']],
      \ ]

" }}}2    ambicmd    {{{2

" cnoremap <expr> <Space> ambicmd#expand("\<Space>")
" cnoremap <expr> <CR> ambicmd#expand("\<CR>")

" }}}2    SnipMate    {{{2

" }}}2    delimitMate    {{{2

let delimitMate_matchpairs = "(:),[:],{:},「:」,（:）"
let delimitMate_excluded_regions = ""
" let delimitMate_expand_space = 1
" let delimitMate_expand_cr = 1
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

" }}}2    open-browser    {{{2

nmap <Leader><CR> <Plug>(openbrowser-smart-search)
vmap <Leader><CR> <Plug>(openbrowser-smart-search)
nmap <Leader>s<CR> <Plug>(openbrowser-search)
vmap <Leader>s<CR> <Plug>(openbrowser-search)
let g:openbrowser_search_engines = {
      \   'morebile': 'http://www.google.com.tw/m/search?site=dictionary&gdm=1&wtr=1&q={query}',
      \   'dictionary': 'http://www.google.com/dictionary?q={query}',
      \   'google': 'http://google.com/search?q={query}',
      \ }
let g:openbrowser_default_search = 'morebile'

" remove ["'"]
let g:openbrowser_iskeyword = join(
      \   range(char2nr('A'), char2nr('Z'))
      \   + range(char2nr('a'), char2nr('z'))
      \   + range(char2nr('0'), char2nr('9'))
      \   + ['_', ':', '/', '.', '-', '+', '%', '#', '?', '&', '=', ';', '@', '$', ',', '[', ']', '!', "(", ")", "*", "~", ],
      \ ',')

" }}}2


" }}}1    Plugins            =================================================


" TabLine Setting:             {{{1 ==========================================

" TODO movetab
" TODO mark tab

function! SetTabLine()
  " NOTE: left/right padding of each tab was hard coded as 1 space.
  " NOTE: require Vim 7.3 strwidth() to display fullwidth text correctly.

  " settings
  let tabMinWidth = 0
  let tabMaxWidth = 40
  let tabMinWidthResized = 15
  let tabScrollOff = 5
  let tabEllipsis = '…'
  let tabDivideEquel = 0

  let s:tabLineTabs = []

  let tabCount = tabpagenr('$')
  let tabSel = tabpagenr()

  " fill s:tabLineTabs with {n, filename, split, flag} for each tab
  for i in range(tabCount)
    let tabnr = i + 1
    let buflist = tabpagebuflist(tabnr)
    let winnr = tabpagewinnr(tabnr)
    let bufnr = buflist[winnr - 1]

    let filename = bufname(bufnr)
    let filename = fnamemodify(filename, ':p:t')
    let buftype = getbufvar(bufnr, '&buftype')
    if filename == ''
      if buftype == 'nofile'
        let filename .= '[Scratch]'
      else
        let filename .= '[New]'
      endif
    endif
    let split = ''
    let winCount = tabpagewinnr(tabnr, '$')
    if winCount > 1   " has split windows
      let split .= winCount
    endif
    let flag = ''
    if getbufvar(bufnr, '&modified')  " modified
      let flag .= '+'
    endif
    if strlen(flag) > 0 || strlen(split) > 0
      let flag .= ' '
    endif

    call add(s:tabLineTabs, {'n': tabnr, 'split': split, 'flag': flag, 'filename': filename})
  endfor

  " variables for final oupout
  let s = ''
  let l:tabLineTabs = deepcopy(s:tabLineTabs)

  " overflow adjustment
  " 1. apply min/max tabWidth option
  if s:TabLineTotalLength(l:tabLineTabs) > &columns
    unlet i
    for i in l:tabLineTabs
      let tabLength = s:CalcTabLength(i)
      if tabLength < tabMinWidth
        let i.filename .= repeat(' ', tabMinWidth - tabLength)
      elseif tabMaxWidth > 0 && tabLength > tabMaxWidth
        let reserve = tabLength - StrWidth(i.filename) + StrWidth(tabEllipsis)
        if tabMaxWidth > reserve
          let i.filename = StrCrop(i.filename, (tabMaxWidth - reserve), '~') . tabEllipsis
        endif
      endif
    endfor
  endif
  " 2. try divide each tab equal-width
  if tabDivideEquel
    if s:TabLineTotalLength(l:tabLineTabs) > &columns
      let divideWidth = max([tabMinWidth, tabMinWidthResized, &columns / tabCount, StrWidth(tabEllipsis)])
      unlet i
      for i in l:tabLineTabs
        let tabLength = s:CalcTabLength(i)
        if tabLength > divideWidth
          let i.filename = StrCrop(i.filename, divideWidth - StrWidth(tabEllipsis), '~') . tabEllipsis
        endif
      endfor
    endif
  endif
  " 3. ensure visibility of current tab
  let rhWidth = 0
  let t = tabCount - 1
  let rhTabStart = min([tabSel - 1, tabSel - tabScrollOff])
  while t >= max([rhTabStart, 0])
    let tab = l:tabLineTabs[t]
    let tabLength = s:CalcTabLength(tab)
    let rhWidth += tabLength
    let t -= 1
  endwhile
  while rhWidth >= &columns
    let tab = l:tabLineTabs[-1]
    let tabLength = s:CalcTabLength(tab)
    let lastTabSpace = &columns - (rhWidth - tabLength)
    let rhWidth -= tabLength
    if rhWidth > &columns
      call remove(l:tabLineTabs, -1)
    else
      " add special flag (will be removed later) indicating that how many
      " columns could be used for last displayed tab.
      if tabSel <= tabScrollOff || tabSel < tabCount - tabScrollOff
        let tab.flag .= '>' . lastTabSpace
      endif
    endif
  endwhile

  " final ouput
  unlet i
  for i in l:tabLineTabs
    let tabnr = i.n

    let split = ''
    if strlen(i.split) > 0
      if tabnr == tabSel
        let split = '%#TabLineSplitNrSel#' . i.split .'%#TabLineSel#'
      else
        let split = '%#TabLineSplitNr#' . i.split .'%#TabLine#'
      endif
    endif

    let text = ' ' . split . i.flag . i.filename . ' '

    if i.n == l:tabLineTabs[-1].n
        if match(i.flag, '>\d\+') > -1 || i.n < tabCount
        let lastTabSpace = matchstr(i.flag, '>\zs\d\+')
        let i.flag = substitute(i.flag, '>\d\+', '', '')
        if lastTabSpace <= strlen(i.n)
          if lastTabSpace == 0
            let s = strpart(s, 0, strlen(s) - 1)
          endif
          let s .= '%#TabLineMore#>'
          continue
        else
          let text = ' ' . i.split . i.flag . i.filename . ' '
          let text = StrCrop(text, (lastTabSpace - strlen(i.n) - 1), '~') . '%#TabLineMore#>'
          let text = substitute(text, ' ' . i.split, ' ' . split, '')
        endif
        endif
    endif

    let s .= '%' . tabnr . 'T'  " start of tab N

    if tabnr == tabSel
      let s .= '%#TabLineNrSel#' . tabnr . '%#TabLineSel#'
    else
      let s .= '%#TabLineNr#' . tabnr . '%#TabLine#'
    endif

    let s .= text

  endfor

  let s .= '%#TabLineFill#%T'
  if exists('s:tabLineResult') && s:tabLineResult !=# s
    let s:tabLineNeedRedraw = 1
  endif
  let s:tabLineResult = s
  return s
endfunction


function! s:CalcTabLength(tab)
  return strlen(a:tab.n) + 2 + strlen(a:tab.split) + strlen(a:tab.flag) + StrWidth(a:tab.filename)
endfunction


function! s:TabLineTotalLength(dict)
  let length = 0
  for i in (a:dict)
    let length += strlen(i.n) + 2 + strlen(i.split) + strlen(i.flag) + StrWidth(i.filename)
  endfor
  return length
endfunction

" }}}1    TabLine Setting             ========================================


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

" }}}2   字串長度（column 數）   {{{2

function! StrWidth(str)
  if exists('*strwidth')
    return strwidth(a:str)
  else
    let strlen = strlen(a:str)
    let mstrlen = strlen(substitute(a:str, ".", "x", "g"))
    if strlen == mstrlen
      return strlen
    else
      " Note: 暫不處理全形字（以下值不正確）
      return strlen
    endif
  endif
endfunction

" }}}2   依字串長度（column 數）裁切多餘文字   {{{2

function! StrCrop(str, len, ...)
  let l:padChar = a:0 > 0 ? a:1 : ' '
  if exists('*strwidth')
    let text = substitute(a:str, '\%>' . a:len . 'c.*', '', '')
    let remainChars = split(substitute(a:str, text, '', ''), '\zs')
    while strwidth(text) < a:len
      let longer = len(remainChars) > 0 ? (text . remove(remainChars, 0)) : text
      if strwidth(longer) < a:len
        let text = longer
      else
        let text .= l:padChar
      endif
    endwhile
    return text
  else
    " Note: 暫不處理全形字（以下值不正確）
    return substitute(a:str, '\%>' . a:len . 'c.*', '', '')
  endif
endfunction

" }}}2    git difftool     {{{2

" Most adopted from Bob Hiestand's vsccommand plugin
" http://www.vim.org/scripts/script.php?script_id=90
command! -nargs=? GitDiff call GitDiff(<f-args>)
function! GitDiff(...)
  let rev = "HEAD~" . (a:0 > 0 ? a:1 : 0)
  let oldDir = getcwd()
  let newDir = fnameescape(expand('%:p:h'))
  let filetype = &filetype
  let cdCommand = haslocaldir() ? 'lcd' : 'cd'

  execute cdCommand . " " . newDir
  let prefix = substitute(system("git rev-parse --show-prefix"), '\n$', '', '')
  let subject = system("git log -1 --format=format:%s " . rev)
  let info = system("git log -1 --format=format:%s\\ %n%h' -- '%an' -- '%ai\\ '('%ar')' " . rev)
  let result = system("git show " . rev . ":" . shellescape(prefix . expand('%:.')))
  execute cdCommand . " " . oldDir

  redraw!
  if v:shell_error
    echohl ErrorMsg | echomsg "GitDiff ERROR: " . substitute(result, '[\n]', ' ', 'g') | echohl None
  else
    let b:stashFoldMethod=&foldmethod
    execute 'vertical new'
    silent put=result | 0delete _
    execute 'set filetype=' . filetype
    let t:git_diff_info = info
    set buftype=nofile
    diffthis | wincmd p | diffthis
  endif
endfunction

command! GitDiffOff call GitDiffOff()
function! GitDiffOff()
  if &diff
    if bufname("%") =~ '^\[git '
      wincmd q
    endif
    only | call MyDiffOff()
  endif
endfunction

" }}}2   Custom diffoff     {{{2

command! MyDiffOff call MyDiffOff()
function! MyDiffOff()
  if &diff
    setlocal diff&
    setlocal scrollbind&
    setlocal cursorbind&
    set scrollopt=ver,hor,jump
    setlocal wrap&
    let foldmethod = exists('b:stashFoldMethod') ? b:stashFoldMethod : 'marker'
    execute "setlocal foldmethod=" . foldmethod
    setlocal foldcolumn&
  else
    echomsg 'Not in diff mode.'
  endif
endfunction

" }}}2   Big File     {{{2

" ref LargeFile http://www.vim.org/scripts/script.php?script_id=1506
function! BigFile(fname)
  if getfsize(a:fname) >= g:BigFile
    syntax clear

    if !exists('b:eikeep')
      let b:eikeep = &eventignore
      let b:ulkeep = &undolevels
      let b:bhkeep = &bufhidden
      let b:foldmethodkeep= &foldmethod
      let b:swfkeep= &swapfile
    endif

    set eventignore=FileType undolevels=-1
    setlocal noswapfile bufhidden=unload foldmethod=manual
    nnoremap <buffer> <LocalLeader>ddd :EmptyFile<CR>

    let fname=escape(substitute(a:fname,'\','/','g'),' ')

    execute "autocmd BigFile BufEnter ".fname." set undolevels=-1"
    execute "autocmd BigFile BufRead ".fname.' call FileTypeForBigFile(expand("<afile>"))'
    execute "autocmd BigFile BufLeave ".fname." set undodir=" . b:ulkeep . " eventignore=" . b:eikeep
    execute "autocmd BigFile BufUnload ".fname." autocmd! BigFile * ". fname
  endif
endfunction

command! BigFileUndo call BigFileUndo()
function! BigFileUndo()
  set eventignore&
  set undolevels&
  set bufhidden&
  setlocal foldmethod=marker
  set noswapfile
endfunction

function! FileTypeForBigFile(fname)
  if fnamemodify(a:fname, ":p:h") =~ '/home/www/fc/\(\w\+/\)\?log'
    if &fileencoding != 'utf-8'
      edit! ++enc=utf-8
    endif
    syntax match railslogEscape '\e\[[0-9;]*m' conceal
  elseif fnamemodify(a:fname, ":p:h") == '/home/www/logs'
    set syntax=httplog
  endif
endfunction

" }}}2   Context sensitive H,L.     {{{2

" Ref: tyru - https://github.com/tyru/dotfiles
nnoremap <silent> H :<C-u>call HContext()<CR>
nnoremap <silent> L :<C-u>call LContext()<CR>
" xnoremap <silent> H <ESC>:<C-u>call HContext()<CR>mzgv`z
" xnoremap <silent> L <ESC>:<C-u>call LContext()<CR>mzgv`z

function! HContext()
  let l:moved = MoveCursor("H")
  if !l:moved && line('.') != 1
    execute "normal! " . "\<ScrollWheelUp>H"
  endif
endfunction

function! LContext()
  let l:moved = MoveCursor("L")

  if !l:moved && line('.') != line('$')
    execute "normal! " . "\<ScrollWheelDown>L"
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

"}}}

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

" }}}2   Firefox reload    {{{2

" http://vim.wikia.com/wiki/Refresh_Firefox_%28preserving_scroll%29_on_Vim_save,_using_MozRepl
command! FirefoxReload silent call FirefoxReload()
function! FirefoxReload()
  update
  silent !echo  'vimYo = content.window.pageYOffset;
        \ vimXo = content.window.pageXOffset;
        \ BrowserReload();
        \ content.window.scrollTo(vimXo,vimYo);
        \ repl.quit();'  |
        \ rlwrap nc localhost 4242 2>&1 > /dev/null
  redraw!
endfunction
cnoreabbrev <expr> ww ((getcmdtype() == ':' && getcmdpos() <= 3) ? 'FirefoxReload<CR>'  : 'ww')

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
  let synStack =  synstack(line("."), col("."))
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
    setlocal nobuflisted nowrap cursorline nonumber fdc=0
    set filetype="eval"
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

  " TODO 實作
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
vnoremap * :<C-U>set hlsearch<CR>:call <SID>search_selected_text_literaly('N')<CR>

function! s:search_selected_text_literaly(search_command)
  let reg_0 = [@0, getregtype('0')]
  let reg_u = [@", getregtype('"')]

  normal! gvy
  let @/ = @0
  call histadd('/', '\V' . escape(@0, '\'))
  execute 'normal!' a:search_command
  let v:searchforward = a:search_command ==# 'n'

  call setreg('0', reg_0[0], reg_0[1])
  call setreg('"', reg_u[0], reg_u[1])
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

let g:html_use_css = 1
let use_xhtml = 1

" }}}2   JavaScript   {{{2

function! s:js_rc()
  let b:tc_option = ''
  let g:SimpleJsIndenter_BriefMode = 1
  setlocal iskeyword+=$
  setlocal iskeyword-=58
  setlocal cindent
endfunction

" }}}2   CSS   {{{2

function! s:css_rc()
  set foldmethod=marker
  setlocal iskeyword-=58
endfunction

" }}}2   SCSS   {{{2

function! s:scss_rc()
  let b:tc_option = ''
  setlocal foldmethod=marker
  setlocal formatoptions=l2
endfunction

" }}}2   HAML   {{{2

function! s:haml_rc()
  inoremap <LocalLeader>br <br><CR>
  let b:tc_option = ''
  setlocal iskeyword-=58
endfunction

" }}}2   HTML   {{{2

function! s:html_rc()
  inoremap <LocalLeader>br <br><CR>
  let html_no_rendering = 1
  let g:html_indent_inctags = "html,body,head,tbody"
  let g:event_handler_attributes_complete = 0
  let g:rdfa_attributes_complete = 0
  let g:microdata_attributes_complete = 0
  let g:atia_attributes_complete = 0
  if exists('g:xmldata_html5')
    let b:html_omni_flavor = 'html5'
  end
endfunction

" }}}2   Ruby   {{{2

function! s:ruby_rc()
  let b:tc_option = ''
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
  let b:tc_option = ''
  " let g:vim_indent_cont = 0
  set path+=~/.vim/bundle
endfunction

" }}}2   zsh   {{{2

function! s:zsh_rc()
  let b:tc_option = ''
  setlocal iskeyword-=-
endfunction

" }}}2   git commit   {{{2

function! s:gitcommit_rc()
  setlocal textwidth=72
endfunction

" }}}2   nginx config   {{{2

function! s:nginx_rc()
  setlocal iskeyword-=.
  setlocal iskeyword-=/
endfunction

" }}}2   logs   {{{2

function! s:logs_rc()
endfunction

" }}}2

" }}}1    Filetype Specific      =============================================


" Autocommands:             {{{1 =============================================

augroup my_vimrc

  autocmd FileType * setlocal formatoptions=roql2

  autocmd FileType php,xml,html inoremap <buffer> <LocalLeader>/ </<C-X><C-O>

  autocmd FileType ruby call s:ruby_rc()
  autocmd FileType html call s:html_rc()
  autocmd FileType haml call s:haml_rc()
  autocmd FileType php call s:php_rc()
  autocmd FileType javascript call s:js_rc()
  autocmd FileType css call s:css_rc()
  autocmd FileType scss call s:scss_rc()
  autocmd FileType help call s:help_rc()
  autocmd FileType vim call s:vim_rc()
  autocmd FileType zsh call s:zsh_rc()
  autocmd FileType gitcommit call s:gitcommit_rc()
  autocmd FileType nginx call s:nginx_rc()

  " autocmd FileType httplog :call s:logs_rc()
  " autocmd FileType railslog :call s:logs_rc()

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

  autocmd BufRead,BufNewFile /opt/nginx/conf/*.conf,/opt/nginx/conf/*.conf.default setfiletype nginx
  autocmd BufRead /home/www/logs/*.log setfiletype httplog

  " let apache_version = "2.0"
  " let dosbatch_cmdextversion = 2

  autocmd CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
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

  " Modified from http://nanabit.net/blog/2007/11/03/vim-cursorline/
  " Note: not recover when canceling FuzzyFinder.
  " autocmd WinLeave * setlocal nocursorline
  " autocmd WinEnter,BufRead * setlocal cursorline

augroup END

" http://vim.wikia.com/wiki/VimTip343?cb=4828
let g:BigFile = 28*1024
if !exists("big_file_autocmd_loaded")
  let big_file_autocmd_loaded = 1
  augroup BigFile
    autocmd BufReadPre *.log call BigFile(expand("<afile>"))
  augroup END
endif

" }}}1    Autocommands             ===========================================


" Finish:                  {{{1 ==============================================

if !exists('s:vimrc_loaded')
  let s:vimrc_loaded = 1
endif

set secure

" vim: expandtab softtabstop=2 shiftwidth=2 foldmethod=marker
