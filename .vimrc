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


" Bundles:                        {{{1 =======================================

" Bundler {{{2

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
  echoerr "Please install NeoBundle first: " .
        \ "git clone http://github.com/Shougo/neobundle.vim.git " . fnamemodify(s:rtp, ":p") . "bundle/neobundle.vim"
  finish
endtry

" }}}2    Listing    {{{2
let s:bundles = []
let s:bundles += [
      \   ['kana/vim-smartinput', {":skip": 1}],
      \   ['Raimondi/delimitMate'],
      \   ['kana/vim-surround'],
      \   ['kana/vim-repeat'],
      \   ['kana/vim-fakeclip'],
      \   ['junegunn/vim-easy-align'],
      \   ['Shougo/neosnippet'],
      \   ['Shougo/vimfiler'],
      \   ['Konfekt/FastFold'],
      \   ['thinca/vim-prettyprint'],
      \   ['thinca/vim-qfreplace'],
      \   ['thinca/vim-quickrun', {'lazy': 1}],
      \   ['thinca/vim-partedit', {'lazy': 1}],
      \   ['bootleq/vim-qrpsqlpq', {":prefer_local": 1}],
      \   ['mojako/ref-sources.vim'],
      \   ['bootleq/vim-ref-bingzh'],
      \   ['tpope/vim-rails'],
      \   ['tpope/vim-bundler'],
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
      \   ['chrisbra/vim-diff-enhanced'],
      \   ['bootleq/vim-hardmotion', {":skip": 1, ":prefer_local": 1}],
      \   ['bootleq/vim-wordword'],
      \   ['rking/ag.vim'],
      \   ['thinca/vim-zenspace'],
      \   ['Yggdroot/indentLine', {':skip': 0}],
      \   ['osyo-manga/vim-anzu', {':skip': 0, ":prefer_local": 0}],
      \   ['justinmk/vim-sneak', {':skip': 0}],
      \   ['easymotion/vim-easymotion'],
      \   ['t9md/vim-choosewin'],
      \   ['AndrewRadev/splitjoin.vim'],
      \   ['netrw.vim'],
      \   ['bootleq/LargeFile', {":prefer_local": 0}],
      \   ['majutsushi/tagbar'],
      \ ]
" filetype {{{3
let s:bundles += [
      \   ['leshill/vim-json', {':filetypes': ['json']}],
      \   ['depuracao/vim-rdoc', {':filetypes': ['rdoc']}],
      \   ['bootleq/JavaScript-syntax', {':filetypes': ['javascript'], ":skip": 1}],
      \   ['othree/yajs', {':filetypes': ['javascript'], ":skip": 0}],
      \   ['jelera/vim-javascript-syntax', {':filetypes': ['javascript'], ":skip": 1}],
      \   ['othree/vim-javascript-syntax', {':filetypes': ['javascript'], ":skip": 1}],
      \   ['jiangmiao/simple-javascript-indenter', {':filetypes': ['javascript']}],
      \   ['kchmck/vim-coffee-script', {':filetypes': ['coffee']}],
      \   ['groenewege/vim-less', {':filetypes': ['less']}],
      \   ['hail2u/vim-css3-syntax', {':filetypes': ['css']}],
      \   ['httplog', {':filetypes': ['httplog']}],
      \   ['nginx.vim', {':filetypes': ['nginx']}],
      \   ['othree/html5.vim', {':filetypes': ['html']}],
      \   ['plasticboy/vim-markdown', {':filetypes': ['mkd', 'markdown'], ':skip': 1}],
      \   ['jtratner/vim-flavored-markdown', {':filetypes': ['ghmarkdown']}],
      \   ['nelstrom/vim-markdown-folding', {':filetypes': ['mkd', 'markdown'], ':skip': 1}],
      \   ['timcharper/textile.vim', {':filetypes': ['textile']}],
      \   ['tpope/vim-haml', {':filetypes': ['haml']}],
      \   ['slim-template/vim-slim', {':filetypes': ['slim'], ':prefer_local': 0}],
      \   ['vim-ruby/vim-ruby', {':filetypes': ['ruby'], ':prefer_local': 1, ':skip': 0}],
      \   ['sunaku/vim-ruby-minitest', {':filetypes': ['ruby'], ':prefer_local': 1, ':skip': 0}],
      \   ['bruno-/vim-ruby-fold', {':filetypes': ['ruby'], ':prefer_local': 0, ':skip': 1}],
      \   ['cespare/vim-toml', {':filetypes': ['toml']}],
      \   ['tpope/vim-git', {'on_ft': ['gitcommit', 'gitconfig', 'gitrebase', 'gitsendemail', 'git']}],
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
      \   ['kana/vim-gf-user', {":skip": 1}],
      \ ]
" }}}3 unite {{{3
let s:bundles += [
      \   ['Shougo/unite.vim', {"rev": 'ver.6.1', ":prefer_local": 0}],
      \   ['Shougo/unite-session'],
      \   ['Shougo/unite-outline'],
      \   ['Shougo/neomru.vim', {":skip": 0}],
      \   ['tacroe/unite-mark'],
      \   ['thinca/vim-unite-history'],
      \   ['tsukkee/unite-help', {"rev": 'tags-caching'}],
      \   ['ujihisa/unite-gem'],
      \   ['basyura/unite-rails'],
      \ ]
" }}}3 colorschemes {{{3
let s:bundles += [
      \   ['itchyny/landscape.vim'],
      \   ['tomasr/molokai'],
      \   ['sk1418/last256'],
      \   ['altercation/vim-colors-solarized'],
      \ ]
" }}}3 neocomplete {{{3
if has('lua') && (v:version > 703 || (v:version == 703 && has('patch885')))
  let s:bundles += [['Shougo/neocomplete']]
else
  let s:bundles += [['Shougo/neocomplcache']]
endif
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
            \   "type": "none",
            \   "frozen": 1
            \ })
    endif
  endif

  if type(get(s:tmp_options, ":filetypes")) == type([])
    call extend(s:tmp_options, {
          \   "lazy": 1,
          \   "on_ft": get(s:tmp_options, ":filetypes")
          \ })
  endif

  call filter(s:tmp_options, "v:key[0] != ':'")
  call neobundle#add(s:i.bundle[0], s:tmp_options)
endfor
unlet! s:bundles s:tmp_options

" }}}2    Listing

" }}}1   Bundles                       =======================================


" Plugin Config:             {{{1 ============================================

runtime! ftplugin/man.vim    " 啟用 |:Man| 指令
runtime! macros/matchit.vim

let g:loaded_getscriptPlugin = 1

" Ag    {{{2

call neobundle#config('ag.vim', {
      \   'lazy': 1,
      \   'on_cmd': {'name': 'Ag', 'complete': 'dir'}
      \ })

" }}}2    Ref    {{{2

call neobundle#config('vim-ref', {
      \   'lazy':   1,
      \   'on_cmd': 'Ref'
      \ })

if neobundle#tap('vim-ref')
  let g:ref_cache_dir = expand('~/.vim/ref-cache')
  if $OSTYPE =~ '^darwin'  " Mac man has no `-T` option
    let g:ref_man_cmd = 'man -P cat'
  endif
  call neobundle#untap()
endif

" FIXME: enable 'lazy'
call neobundle#config('vim-ref-bingzh', {
      \   'lazy': 0,
      \   'depends': 'vim-ref',
      \   'autoload': {
      \     'commands': 'Ref',
      \     'function_prefix': 'ref'
      \   }
      \ })

if neobundle#tap('vim-ref-bingzh')
  if executable('opencc')
    let g:ref_bingzh_opencc_config = 't2s.json'
  endif

  function! neobundle#hooks.on_source(bundle)
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

  nnoremap <silent> <LocalLeader>K :normal! K<CR>
  xnoremap <silent> <LocalLeader>K :normal! K<CR>

  call neobundle#untap()
endif

" }}}2    qfreplace    {{{2

call neobundle#config('vim-qfreplace', {
      \   'lazy':  1,
      \   'on_ft': ['qf']
      \ })
autocmd my_vimrc FileType qf nnoremap <buffer> r :<C-U>Qfreplace tabnew<CR>

" }}}2   Zenkaku Space    {{{2

if neobundle#tap('vim-zenspace')
  let g:zenspace#default_mode = 'on'
  call neobundle#untap()
endif

" }}}2    neosnippet    {{{2

call neobundle#config('neosnippet', {
      \   'lazy':  1,
      \   'on_i':  1,
      \   'on_ft': 'snippet',
      \ })

if neobundle#tap('neosnippet')
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

  call neobundle#untap()
endif

" }}}2    Netrw    {{{2

call neobundle#config('netrw.vim', {
      \   'lazy':   1,
      \   'on_cmd': 'Explore'
      \ })
if neobundle#tap('netrw.vim')
  " let g:netrw_ftp = 1
  " let g:netrw_preview = 1
  " let g:netrw_ignorenetrc = 0
  " let g:netrw_ftpextracmd = 'passive'
  let g:netrw_liststyle = 3
  let g:netrw_winsize = 20
  " let g:netrw_browsex_viewer = '-'
  let g:netrw_timefmt = '%Y-%m-%d %T'
  " if exists("g:qfix_win") && a:forced == 0
  function! neobundle#tapped.hooks.on_source(bundle) "{{{
    nmap <leader>e :Vexplore<CR>
  endfunction "}}}
  call neobundle#untap()
endif

" }}}2   FastFold    {{{2

if neobundle#tap('FastFold')
  nmap <SID>(DisableFastFoldUpdate) <Plug>(FastFoldUpdate)
  call neobundle#untap()
endif

" }}}2    open-browser    {{{2

call neobundle#config('open-browser.vim', {
      \   'lazy': 1,
      \   'autoload': {
      \     'mappings': ['<Plug>(openbrowser-search)', '<Plug>(openbrowser-smart-search)']
      \   }
      \ })

if neobundle#tap('open-browser.vim')
  let g:openbrowser_search_engines = {
        \   'morebile': 'http://www.google.com.tw/m/search?site=dictionary&gdm=1&wtr=1&q={query}',
        \   'dictionary': 'http://www.google.com/dictionary?q={query}',
        \   'google': 'http://google.com/search?q={query}',
        \ }
  let g:openbrowser_default_search = 'google'
  let g:openbrowser_force_foreground_after_open = 1

  " ["'"] removed
  let g:openbrowser_iskeyword = join(
        \   range(char2nr('A'), char2nr('Z'))
        \   + range(char2nr('a'), char2nr('z'))
        \   + range(char2nr('0'), char2nr('9'))
        \   + ['_', ':', '/', '.', '-', '+', '%', '#', '?', '&', '=', ';', '@', '$', ',', '[', ']', '!', "(", ")", "*", "~", ],
        \ ',')

  nmap <Leader><CR> <Plug>(openbrowser-smart-search)
  vmap <Leader><CR> <Plug>(openbrowser-smart-search)
  nmap <Leader>s<CR> <Plug>(openbrowser-search)
  vmap <Leader>s<CR> <Plug>(openbrowser-search)
  call neobundle#untap()
endif

" }}}2   giti    {{{2

if neobundle#tap('vim-unite-giti')
  call neobundle#config({
  \   'autoload' : {
  \     'unite_sources' : [
  \       'giti',
  \       'giti/status'
  \     ],
  \   }
  \ })
  call neobundle#untap()
endif

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
  let g:loaded_netrwPlugin = 1

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

" }}}2 vimfiler

" }}}1    Plugin Config            ===========================================


" Bundle Finish:                 {{{1 ========================================

call neobundle#end()
filetype plugin indent on

" }}}1   Bundle Finish                 =======================================


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
  if $OSTYPE == 'cygwin' || $VM_HOST_OS == 'cygwin'
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
  set showbreak=\\ 
catch /^Vim\%((\a\+)\)\=:E518/
endtry

try
  setlocal formatoptions=roql2mBj
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

if v:version > 704 || (v:version == 704 && has('patch314'))
  set shortmess+=c
endif

set nolinebreak
set display=lastline
set listchars=tab:>-,eol:¬,trail:*,extends:»,precedes:«
set background=dark
set ambiwidth=single
syntax on

if v:version > 704 || (v:version == 704 && has('patch88'))
else
  " http://blogger.godfat.org/2011/07/spellcheck-only-for-english-in-vim.html
  syntax match Normal /[^!-~]/ contains=@NoSpell
endif

if !exists('g:colors_name')
  set background=dark
  try
    colorscheme bootleg
  catch /^Vim\%((\a\+)\)\=:E185/
  endtry
endif

set title titlestring=%t%(\ %M%)%(\ (%{expand(\"%:~:.:h\")})%)%(\ %a%)
set statusline=%<%f\ %h%m%r%w%=%-14.(%l,%c%V%)\ %P
set showtabline=2

" }}}2    尋找、搜尋    {{{2

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
set hidden

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

"   各種移動    {{{2

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
vnoremap <silent> <LocalLeader>I <Esc>:call SmartHome("v")<CR>
vnoremap <silent> <LocalLeader>A <Esc>:call SmartEnd("v")<CR>

map  <kHome> <Home>
map! <kHome> <Home>
map  <kEnd>  <End>
map! <kEnd>  <End>

nnoremap ' `

nmap <LocalLeader>w <C-W>
nnoremap <C-W>V :wincmd K <Bar> wincmd =<CR>
nnoremap <silent> <C-W>m :MoveIntoTabpage<CR>
nnoremap <silent> <C-W>M :MoveIntoTabpage <count> <C-R>=tabpagenr()-1<CR><CR>
nnoremap <silent> <localleader>z :wincmd z<CR>
nmap <localleader>gf <C-W>gf
vmap <localleader>gf <C-W>gf
nnoremap <expr> <CR> &modifiable ? "i<CR><C-\><C-N>" : "<C-]>"
nnoremap <expr> <BS> &modifiable ? "i<C-W><C-\><C-N>" : "<C-O>"

nnoremap gr gT
nnoremap <silent> gT :tablast<CR>
nnoremap <silent> gR :tabfirst<CR>
nnoremap <silent> <expr> <LocalLeader>gt printf(":tabmove %s<CR>", tabpagenr() == tabpagenr('$') ? 0 : tabpagenr() + 1)
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
noremap <C-BS> :quit<CR>
map <kDel> <Del>

" TODO command mode text-object delete
" noremap! <LocalLeader>w

cnoremap <LocalLeader>; <C-W>

cmap <LocalLeader>v <C-F>

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

if exists('v:hlsearch') " require Vim 7.4.079
  noremap <silent><expr> <F3> v:hlsearch ? ':nohlsearch<CR>' : ':set hlsearch<CR>'
  inoremap <silent><expr> <F3> v:hlsearch ? '<C-\><C-O>:nohlsearch<CR>' : '<C-\><C-O>:set hlsearch<CR>'
else
  noremap <silent> <F3> :nohlsearch<CR>
  inoremap <silent> <F3> <C-\><C-O>:nohlsearch<CR>
  noremap <silent> <F4> :set hlsearch<CR>
  inoremap <silent> <F4> <C-\><C-O>:set hlsearch<CR>
endif

nnoremap <F5> :call SynStackInfo()<CR>
nnoremap <silent> <F6> :QuickOff<CR>
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
      \   "\<Plug>(textobj-jabraces-parens-%)",
      \   "\<Plug>(textobj-jabraces-kakko-%)",
      \   "\<Plug>(textobj-jabraces-double-kakko-%)",
      \   "\<Plug>(textobj-jabraces-yama-kakko-%)",
      \   "\<Plug>(textobj-jabraces-double-yama-kakko-%)",
      \   "\<Plug>(textobj-jabraces-sumi-kakko-%)",
      \   '%(',
      \   '%[',
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

nnoremap <LocalLeader>G <C-G>

" }}}2

" }}}1   Mappings              ==============================================


" Commands:             {{{1 =================================================

command! -bang EmptyFile call <SID>empty_file(<bang>0)
function! s:empty_file(with_sudo) "{{{
  if executable('cat')
    let result = system(printf(
          \   "cat /dev/null | %s tee %s",
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

command! Rtouch call <SID>restart_passenger_or_unicorn()
command! Rpuma call <SID>restart_puma()
command! Rnginx execute "!sudo\ service nginx restart"

function! s:restart_puma() "{{{
  if isdirectory('tmp')
    let pid = ''
    if executable('puma') && filereadable('config/puma.rb')
      if filereadable('tmp/pids/puma.pid') && system('ps h -o pid -p `cat tmp/pids/puma.pid`') =~ '^\d'
        let pid = readfile('tmp/pids/puma.pid')[0]
      end

      if !empty(pid)
        let result = system('kill ' . pid)
        if v:shell_error
          echohl WarningMsg | echomsg printf("Failed to kill process: %s", result) | echohl None
        endif
      end

      if !v:shell_error
        let result = system(printf(
              \   'RAILS_RELATIVE_URL_ROOT=%s bundle exec puma -d -C config/puma.rb config.ru',
              \   '/' . fnamemodify(getcwd(), ':t')
              \ ))
        if v:shell_error
          echohl WarningMsg | echomsg printf("Error: %s", result) | echohl None
        else
          echomsg "Puma restarted."
        endif
      endif
    else
      echohl WarningMsg | echomsg 'ERROR: "puma" not available or config/puma.rb not found.' | echohl None
    endif
  else
    echohl WarningMsg | echomsg '"tmp" directory not found.' | echohl None
  endif
endfunction "}}}

function! s:restart_passenger_or_unicorn() "{{{
  if isdirectory('tmp')
    if executable('passenger')
      let result = system("touch tmp/restart.txt")
      if v:shell_error
        echohl WarningMsg | echomsg printf("Error: %s", result) | echohl None
      else
        echomsg '"tmp/restart.txt" touched.'
      endif
    elseif executable('unicorn_rails')
      if filereadable('tmp/pids/unicorn.pid')
        let result = system('kill -USR2 $(cat tmp/pids/unicorn.pid)')
        if v:shell_error
          echohl WarningMsg | echomsg printf("Error: %s", result) | echohl None
        else
          echomsg "unicorn process killed."
        endif
      elseif filereadable('config/unicorn.rb') && !empty($RAILS_ENV)
        let result = system('bundle exec unicorn_rails -D -E $RAILS_ENV -c config/unicorn.rb')
        if v:shell_error
          echohl WarningMsg | echomsg printf("Error: %s", result) | echohl None
        else
          echomsg "unicorn process started."
        endif
      else
        echohl WarningMsg | echomsg 'ERROR: no config for unicorn_rails.' | echohl None
      endif
    else
      echohl WarningMsg | echomsg 'ERROR: no "passenger" or "unicorn_rails" available.' | echohl None
    endif
  else
    echohl WarningMsg | echomsg '"tmp" directory not found.' | echohl None
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
command! -nargs=1 -complete=file Diff execute 'vertical diffsplit ' . fnameescape(<q-args>)

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
      \   expand('~/cscope.out'),
      \   expand('~/include/cscope.out'),
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


" Plugins:             {{{1 ==================================================

" NeoBundle    {{{2

let g:neobundle#log_filename = expand(printf('~/.vim/neobundle-logs/%s.neobundlelog', strftime('%m%d-%H%M%S')))
if !isdirectory(fnamemodify(g:neobundle#log_filename, ':p:h'))
  call mkdir(fnamemodify(g:neobundle#log_filename, ':p:h'), "p")
endif

" TODO apply to :Unite neobundle/log
function! s:view_NeoBundleUpdatesLog() "{{{
  TabMessage NeoBundleUpdatesLog
  setfiletype neobundlelog
endfunction "}}}
command! -nargs=0 ViewNeoBundleUpdatesLog call <SID>view_NeoBundleUpdatesLog()

function! s:neobundlelog_rc()
  setlocal conceallevel=2 concealcursor=nvc foldmethod=syntax foldlevel=1 nowrap
  nnoremap <buffer> <CR> :call <SID>do_NeoBundleLog_diff()<CR>
  call <SID>NeoBundleUpdatesLog_syntax()
  syntax sync fromstart
endfunction

autocmd FileType neobundlelog call s:neobundlelog_rc()
autocmd BufRead ~/.vim/neobundle-logs/*.neobundlelog setfiletype neobundlelog 

function! s:NeoBundleUpdatesLog_syntax() "{{{
  " Example Changes format:
  " ( 45/102): |neocomplete| Updated
  " |neocomplete| * a3b87cc [2 hours ago] Fix indent problem
  " or old style:
  " [neobundle] |html5.vim| * 54f8c09 [3 days ago] Reference vim-polyglot language pack
  syntax region NeoBundleLog_Changes start=_\v^\(.+\): \|.+\| +Updated\n(\[neobundle\] )?\|_ end=_^\(\(\[neobundle\] \)\?|\)\@!_ fold
  syntax match NeoBundleLog_TreeName _\v^(\[neobundle\] )?\|\S+\|_ contained containedin=NeoBundleLog_Changes conceal nextgroup=NeoBundleLog_GraphLink skipwhite
  syntax match NeoBundleLog_HeaderName %|\zs.\+\ze|% contained
  syntax match NeoBundleLog_HeaderError %\v.+Error$% contained
  syntax match NeoBundleLog_Header _^(.*$_ contained contains=NeoBundleLog_Header.* containedin=NeoBundleLog_Changes 

  syntax match NeoBundleLog_GraphLink % \zs\v[_\_\|/\\\* ]+\ze % contained nextgroup=NeoBundleLog_Commit
  syntax match NeoBundleLog_Commit %\v [a-z0-9]{7} \[[^\]]+]% contained
  syntax match NeoBundleLog_Rev %\v[a-z0-9]{7}\ze \[% contained containedin=NeoBundleLog_Commit

  syntax match NeoBundleLog_SectionH _^Update started: .*$_
  syntax match NeoBundleLog_Fatal %\v^fatal\ze: %
  syntax match NeoBundleLog_Skipped %^(.\+): .*Skipped$%
  syntax match NeoBundleLog_Locked %^(.\+): .*Locked$%
  syntax match NeoBundleLog_Failed %^(.\+): .*Error$%
  syntax keyword NeoBundleLog_FailedLabel Error containedin=NeoBundleLog_Failed
  syntax match NeoBundleLog_PullName %|\zs.\+\ze|% contained
  syntax match NeoBundleLog_CloneName %|\zs.\+\ze|% contained
  syntax match NeoBundleLog_Pull %^(.\+): |\S\+| git pull --ff.*$% contains=NeoBundleLog_Pull.*
  syntax match NeoBundleLog_Clone %^(.\+): |\S\+| git clone --recursive.*$% contains=NeoBundleLog_Clone.*
  syntax match NeoBundleLog_Ignore %\v^(Same revision\.|Outdated plugin\.)$%
  syntax match NeoBundleLog_Ignoring %\v^(is frozen\.)$%

  syntax region NeoBundleLog_Summary start=_^Updated bundles:$_ end=_^Completed._
  syntax match NeoBundleLog_SummaryTitle _\v(Updated bundles:|Completed\.)$_ contained containedin=NeoBundleLog_Summary
  syntax match NeoBundleLog_SummaryBundle _  \zs.\+\ze\s*(\d\+ changes\?)_ contained containedin=NeoBundleLog_Summary
  syntax match NeoBundleLog_SummaryURL _^\s\+https\?://.*$_ contained containedin=NeoBundleLog_Summary

  highlight link NeoBundleLog_Fatal Error
  highlight link NeoBundleLog_Header Constant
  highlight link NeoBundleLog_SectionH Statement
  highlight link NeoBundleLog_HeaderName Define
  highlight link NeoBundleLog_HeaderError Error
 
  highlight link NeoBundleLog_Pull Conceal
  highlight link NeoBundleLog_PullName Conceal
  highlight link NeoBundleLog_Clone NeoBundleLog_Header 
  highlight link NeoBundleLog_CloneName NeoBundleLog_HeaderName
  highlight link NeoBundleLog_Skipped Conceal
  highlight link NeoBundleLog_Failed WarningMsg
  highlight link NeoBundleLog_FailedLabel Error
  highlight link NeoBundleLog_Locked Comment
  highlight link NeoBundleLog_Ignore Conceal
  highlight link NeoBundleLog_Ignoring Comment
  highlight link NeoBundleLog_Commit Comment
  highlight link NeoBundleLog_Rev Identifier
  highlight link NeoBundleLog_GraphLink Comment

  highlight link NeoBundleLog_SummaryTitle Normal
  highlight link NeoBundleLog_SummaryBundle Include
  highlight link NeoBundleLog_SummaryURL Comment
endfunction "}}}

function! s:do_NeoBundleLog_diff()
  let rev = matchstr(getline('.'), '\v \zs[a-z0-9]{7}\ze ')
  let patterns = {
        \   'name': '^(.\+): |\(.\+\)|'
        \ }
  let bundle_name = ''
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
  call TmuxNewWindow({
        \   "text": "gitdiffall @" . rev,
        \   "title": '⎇',
        \   "directory": path
        \ })
endfunction

" }}}2    Unite.vim    {{{2

if neobundle#tap('unite.vim') "{{{
  " TODO unite scriptnames
  " TODO secondary default action
  " TODO bookmark should convert slashes for different OSes
  " TODO use vim-tabline for tabs
  " TODO switch between ,ff and ,F buffer

  " Launcher mappings {{{
  nnoremap [unite] <Nop>
  xnoremap [unite] <Nop>
  nmap <LocalLeader>f [unite]
  xmap <LocalLeader>f [unite]
  imap <LocalLeader>f <C-\><C-N>[unite]

  nnoremap <silent> [unite]f :<C-U>Unite
        \ -input=<C-R>=fnamemodify(unite#helper#get_buffer_directory(bufnr('%')), ':p:.')<CR>
        \ -buffer-name=files file file/new<CR>
  nnoremap <silent> [unite]F :<C-U>Unite
        \ -input=<C-R>=fnamemodify(unite#helper#get_buffer_directory(bufnr('%')), ':p:.')<CR>
        \ -buffer-name=files file file/new file_rec<CR>
  nnoremap <silent> <LocalLeader>F :<C-U>Unite -buffer-name=file_rec file_rec<CR>

  nnoremap <silent> [unite]r :<C-U>Unite -profile-name=mru file_mru<CR>
  nnoremap <silent> [unite]d :<C-U>Unite -buffer-name=mru directory_mru<CR>
  nnoremap <silent> [unite]/ :<C-U>Unite -buffer-name=search line<CR>
  nnoremap <silent> [unite]p :<C-U>Unite -buffer-name=registers -unique register<CR>
  xnoremap <silent> [unite]p "_d:<C-U>Unite -buffer-name=register -unique register<CR>
  nnoremap <silent> [unite]B :<C-U>Unite buffer<CR>
  nnoremap <silent> [unite]b :<C-U>Unite -no-start-insert bookmark<CR>
  nnoremap <silent> [unite]m :<C-U>Unite mark<CR>
  nnoremap <silent> [unite]h :<C-U>Unite -update-time=600 help<CR>
  nnoremap <silent> [unite]o :<C-U>Unite -no-start-insert outline<CR>
  nnoremap <silent> [unite]t :<C-U>Unite tab:no-current<CR>
  nnoremap <silent> [unite]g :<C-U>Unite tab:no-current<CR>
  nnoremap <silent> [unite]j :<C-U>Unite jump<CR>
  nnoremap <silent> [unite]c :<C-U>Unite change<CR>
  nnoremap <silent> [unite]y :<C-U>Unite -unique history/yank<CR>
  nnoremap <silent> [unite]R :<C-U>Unite -input=rails/ source<CR>
  nnoremap <silent> [unite]M :<C-U>Unite rails/model<CR>
  nnoremap <silent> [unite]V :<C-U>Unite rails/view<CR>
  nnoremap <silent> [unite]C :<C-U>Unite rails/controller<CR>
  " }}}

  " Configuration variables {{{
  let g:unite_data_directory = expand(s:rtp . '/.unite/')
  let g:unite_quick_match_table = {
        \   'a': 0,  'b': 1,  'c': 2,  'd': 3,  'e': 4,  'f': 5,  'g': 6,  'h': 7,  'i': 8,  'j': 9,
        \   'k': 10, 'l': 11, 'm': 12, 'n': 13, 'o': 14, 'p': 15, 'q': 16, 'r': 17, 's': 18, 't': 19,
        \   'u': 20, 'v': 21, 'w': 22, 'x': 23, 'y': 24, 'z': 25, ';': 26, '.': 27, '/': 28, 'A': 29, 'B': 30
        \ }
  let g:unite_ignore_source_files = [
        \   'window.vim',
        \   'window_gui.vim',
        \   'output.vim',
        \   'command.vim',
        \   'function.vim',
        \   'mapping.vim',
        \   'grep.vim',
        \   'vimgrep.vim',
        \   'launcher.vim',
        \   'menu.vim',
        \   'process.vim',
        \   'runtimepath.vim',
        \ ]

  let g:unite_source_history_yank_enable = 1
  let g:unite_source_history_yank_limit = 40
  let g:unite_source_history_yank_save_clipboard = 1
  let g:unite_source_session_path = expand('~/.vim/session/')

  let g:neomru#file_mru_limit = 800
  let g:neomru#time_format = "%m/%d %T "
  let g:neomru#directory_mru_limit = 80
  " }}}

  " In unite buffer setting {{{
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

    imap <buffer> ; <Plug>(unite_delete_backward_word)
    imap <buffer> <LocalLeader>; <Plug>(unite_delete_backward_path)
    imap <buffer> <LocalLeader>u <Plug>(unite_delete_backward_line)
    inoremap <buffer><expr> <LocalLeader>/ unite#do_action('narrow')

    nmap <buffer> <LocalLeader>: <Plug>(unite_narrowing_input_history)
    imap <buffer> <LocalLeader>e <Plug>(unite_quick_match_default_action)

    nmap <buffer> <LocalLeader><C-K> <Plug>(unite_print_candidate)
    nmap <buffer> <LocalLeader><C-A> <Plug>(unite_print_message_log)

    let unite = unite#get_current_unite()
    if index(unite.source_names, 'file') > -1 ||
          \   index(unite.source_names, 'file_mru') > -1 ||
          \   index(unite.source_names, 'file_rec') > -1
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
  " }}}

  " Sources customization {{{
  call unite#custom#default_action('file, source/bookmark/jump_list', 'tabswitch')
  call unite#custom#default_action('source/help/common', 'tabopen')
  call unite#custom#default_action('buffer', 'tabopen')

  " File related
  call unite#custom#source(
        \ 'file, file_rec, buffer, file_mru',
        \ 'matchers',
        \ ['matcher_hide_hidden_files', 'matcher_fuzzy'])
  let s:i.unite_sorter = has('ruby') ? 'sorter_selecta' : 'sorter_rank'
  call unite#custom#source(
        \ 'file, file_rec, buffer, file_mru',
        \ 'sorters',
        \ ['sorter_word', s:i.unite_sorter])
  call unite#custom#source(
        \ 'file, file_rec, buffer',
        \ 'converters',
        \ ['converter_relative_abbr'])

  call unite#custom#source('tab, outline', 'matchers', ['matcher_fuzzy'])
  call unite#custom_source('help', 'sorters', 'sorter_word')
  " }}}

  " Profile customization {{{
  call unite#custom#profile('default', 'context', {
        \   'start_insert': 1,
        \   'vertical': 1,
        \   'hide_source_names': 1
        \ })

  " Preserve built-in substitute_patterns
  for s:i.unite_pattern in values(unite#get_profile('files', 'substitute_patterns'))
    call unite#custom#profile('source/files', 'substitute_patterns', {
          \   'pattern': s:i.unite_pattern.pattern,
          \   'subst': s:i.unite_pattern.subst,
          \   'priority': s:i.unite_pattern.priority
          \ })
  endfor

  " Ref: thinca - http://d.hatena.ne.jp/thinca/20101027/1288190498
  call unite#custom#profile('files', 'substitute_patterns', {
        \   'pattern': '^@',
        \   'subst': '\=expand("#:p:h")."/*"',
        \   'priority': 1
        \ })
  " }}}

  command! -bar -nargs=? EditBookmarks call s:edit_bookmarks()
  function! s:edit_bookmarks() "{{{
    if !has_key(g:, 'unite_source_bookmark_directory')
      call unite#get_candidates(['bookmark'])
    endif
    execute printf("Unite -immediately -auto-resize file:%s", get(g:, 'unite_source_bookmark_directory', ''))
  endfunction "}}}

  call neobundle#untap()
endif "}}}

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

let g:neocomplete#sources#buffer#disabled_pattern = '*.log'

execute 'inoremap <expr><LocalLeader><C-H> ' . bundle.name . '#smart_close_popup()."\<BS>"'
execute 'inoremap <expr><LocalLeader><BS>  ' . bundle.name . '#smart_close_popup()."\<BS>"'
inoremap <expr> <CR> pumvisible() ? "\<C-Y>" : "\<CR>"


" }}}2   Easy Align    {{{2

xmap <CR> <Plug>(EasyAlign)
xmap <LocalLeader>A <Plug>(EasyAlign)
let g:easy_align_interactive_modes = ['l', 'a']
let g:easy_align_ignore_unmatched  = 0
" nmap <LocalLeader>= <Plug>(EasyAlign)

" }}}2   Indent Line    {{{2

if neobundle#tap('indentLine')
  let g:indentLine_color_term = 239
  " let g:indentLine_char = '┊'
  let g:indentLine_enabled = 0
  nnoremap <Leader>ig :IndentLinesToggle<CR>
  call neobundle#untap()
endif

" }}}2   Rails    {{{2

autocmd User Rails call s:rails_test_helpers()
autocmd User Rails if rails#buffer().relative() =~ '^config/locales/.\+.yml$' | call s:html_rc() | endif

function! s:rails_test_helpers() "{{{
  let type = rails#buffer().type_name()
  let relative = rails#buffer().relative()
  if type =~ '^test' || (type == 'javascript-coffee' && relative =~ '^test/')
    nmap <Leader>t [rtest]
    nnoremap <silent> [rtest]j :call <SID>rails_test_tmux('v')<CR>
    nnoremap <silent> [rtest]l :call <SID>rails_test_tmux('h')<CR>
    nnoremap <silent> [rtest]w :call <SID>rails_test_tmux('new-window')<CR>
    nnoremap <silent> [rtest]. :call <SID>rails_test_tmux('last')<CR>
    nnoremap <silent> [rtest]t :call <SID>rails_test_tmux('last')<CR>
    nnoremap <silent> [rtest]q :call <SID>rails_test_tmux('quit')<CR>
  end
endfunction "}}}

function! s:rails_test_tmux(method) "{{{
  let [it, path] = ['', '']

  let rails_type = rails#buffer().type_name()
  let rails_relative = rails#buffer().relative()

  if rails_type =~ '^test'
    let it = matchstr(
          \   getline(
          \     search('^\s*it\s\+\(\)', 'bcnW')
          \   ),
          \   'it\s*[''"]\zs.*\ze[''"]'
          \ )
    let path = rails_relative
  elseif rails_type == 'javascript-coffee' && rails_relative =~ '^test/'
    " Currently, teaspoon can't filter specs without 'describe' title
    " https://github.com/modeset/teaspoon/issues/304
    let desc = matchstr(
          \   getline(
          \     search('^\s*describe\s*\(\)', 'bcnW')
          \   ),
          \   'describe\s*[''"]\zs.*\ze[''"]'
          \ )
    let it = matchstr(
          \   getline(
          \     search('^\s*it\s\+\(\)', 'bcnW')
          \   ),
          \   'it\s*[''"]\zs.*\ze[''"]'
          \ )
    let it = (empty(desc) || empty(it)) ?
          \ '' :
          \ join([desc, it], ' ')
    let path = rails_relative
  end

  if empty(it) || empty(path)
    let it   = get(s:, 'rails_test_tmux_last_it', '')
    let path = get(s:, 'rails_test_tmux_last_path', '')
  end

  if empty(it) || empty(path)
    echohl WarningMsg | echomsg 'No `it` block found' | echohl None
    return
  end

  let s:rails_test_tmux_last_it = it
  let s:rails_test_tmux_last_path = path

  if rails_type == 'javascript-coffee'
    " https://github.com/modeset/teaspoon/wiki/Teaspoon-Configuration
    " TODO add back `--filter` if I can handle nested `describe` blocks
    " let test_command = printf('RAILS_RELATIVE_URL_ROOT= teaspoon %s --fail-fast -f pride --filter %s', path, shellescape(it))
    let test_command = printf('FAIL_FAST=true FORMATTERS=documentation rake teaspoon files=%s', path)
    let title = '☕️'
  elseif rails_type == 'test-integration'
    " TODO why can't just use ruby -Itest?
    let test_command = printf('RAILS_RELATIVE_URL_ROOT= bundle exec rake test:integration TEST=%s', path)
    let title = matchstr(rails_type, '\vtest-\zs.{4}')
  else
    let test_command = printf('bundle exec ruby -Itest %s --name /%s/', path, shellescape(escape(it, '()[]+?')))
    let type_short = matchstr(rails_type, '\vtest-\zs.{4}')
    if type_short == 'unit'
      let title = type_short
    elseif type_short == 'func'
      let title = type_short
    else
      let title = type_short
    endif
  endif
  "       
  " 
  "    
  "     
  "   '

  " ∫ ƒ
  call TmuxNewWindow({
        \   "text": test_command,
        \   "title": '∫ ' . title,
        \   "directory": rails#app().root,
        \   "remember_pane": 1,
        \   "method": a:method
        \ })
endfunction "}}}

let g:rails_projections = {
      \   "app/stylesheets/*.css.scss": {"command": "css"},
      \   "app/assets/stylesheets/*.css.scss": {"command": "css"},
      \   "app/assets/javascripts/*.js": {"command": "js"},
      \   "app/assets/javascripts/*.coffee": {"command": "js"},
      \   "log/*.log": {"command": "log"},
      \   "test/*_test.rb": {"command":  "test"},
      \ }

" }}}2   QuickRun    {{{2

function! s:init_quickrun()
  let g:quickrun_config = {
        \   '_': {
        \     'outputter/buffer/name': '[QuickRun]',
        \     'outputter/buffer/into': 1,
        \     'outputter/buffer/split': 'botright 8'
        \   }
        \ }

  " TODO hook output data, 0,2delete_ the output
  " TODO ehcomsg when success normally
  " TODO highlight catched errors
  let g:quickrun_config.vim = {
        \   'outputter': 'error',
        \   'outputter/error/success': 'message',
        \   'outputter/error/error': 'buffer',
        \   'outputter/buffer/name': '[QuickRun Vim]',
        \   'outputter/buffer/close_on_empty': 1
        \ }
endfunction
call s:init_quickrun()

" }}}2   qrpsqlpq    {{{2

function! s:init_qrpsqlpq()
  nmap <buffer> <Leader>r [qrpsqlpq]
  nnoremap <silent> <buffer> [qrpsqlpq]j :call qrpsqlpq#run('split')<CR>
  nnoremap <silent> <buffer> [qrpsqlpq]l :call qrpsqlpq#run('vsplit')<CR>
  nnoremap <silent> <buffer> [qrpsqlpq]r :call qrpsqlpq#run()<CR>

  if !exists('b:rails_root')
    call RailsDetect()
  endif
  if !exists('b:rails_root')
    let b:qrpsqlpq_db_name = 'postgres'
  endif
endfunction

if executable('psql')
  let g:qrpsqlpq_expanded_format_max_lines = -1
  autocmd FileType sql call s:init_qrpsqlpq()
endif

" }}}2   PartEdit    {{{2

if neobundle#tap('vim-partedit')
  " FIXME: not support tab split
  let g:partedit#opener = 'vsplit'
  vnoremap <LocalLeader>v :Partedit<CR>
  call neobundle#untap()
endif

" }}}2   fugitive  {{{2

command! -nargs=* -complete=customlist,<SID>fugitiveblame_complete GBlameA Gblame <args> | call <SID>fugitiveblame_after()
function! s:fugitiveblame_after() "{{{
  call feedkeys('A')
endfunction "}}}

function! s:fugitiveblame_complete(A, L, P) "{{{
  return ['--root', '--show-name'] + split('ltfnsew', '\zs') + ['M1', 'C1']
endfunction

function! s:fugitiveblame_gitdiffall(all) "{{{
  let rev = matchstr(getline('.'), '\v^\w{7}')
  let buffer = fugitive#buffer(bufname(b:fugitive_blamed_bufnr))
  let toplevel = buffer.repo().tree()
  if a:all
    " ⎇    
    call TmuxNewWindow({
          \   "text": "gitdiffall @" . rev,
          \   "title": '⎇',
          \   "directory": toplevel
          \ })
  else
    execute printf(
          \   "tabnew %s | silent GitDiff @%s",
          \   fnamemodify(toplevel . '/' . buffer.path(), ':.'),
          \   rev
          \ )
  endif
endfunction "}}}

autocmd! my_vimrc FileType fugitiveblame
      \ nnoremap <silent> <buffer> gf :call <SID>fugitiveblame_gitdiffall(0)<CR> |
      \ nnoremap <silent> <buffer> <LocalLeader>gf :call <SID>fugitiveblame_gitdiffall(1)<CR>

" }}}2   gitdiffall    {{{2

let g:gitdiffall_log_format = "medium"
let g:gitdiffall_min_hash_abbr = 7

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
nnoremap <silent><C-F6> :call <SID>gitdiff_next()<CR>

autocmd my_vimrc FileType gitdiffallinfo nnoremap <buffer> <silent> q :silent call gitdiffall#quit_info_window()<CR>

" }}}2   SimpleJavascriptIndenter    {{{2

if neobundle#tap('simple-javascript-indenter')
  let g:SimpleJsIndenter_BriefMode = 1
  let g:SimpleJsIndenter_CaseIndentLevel = -1
  call neobundle#untap()
endif

" }}}2   TagBar   {{{2

if !executable('ctags')
  let g:loaded_tagbar = 1
else
  let g:tagbar_ctags_bin = exepath('ctags')
  let g:tagbar_type_ruby = {
        \   'kinds' : [
        \     'm:modules',
        \     'c:classes',
        \     'd:describes',
        \     'C:contexts',
        \     'f:methods',
        \     'F:singleton methods'
        \   ]
        \ }
  let g:tagbar_autofocus = 1
  let g:tagbar_width = 50
endif

if has("gui_running")
  noremap <silent> <M-z> :TagbarToggle<CR>
else
  noremap <silent> z :TagbarToggle<CR>
  noremap <silent> Ω :TagbarToggle<CR> " For mac option-z
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
      let save_rtp = &runtimepath
      set runtimepath&
      GSessionMake
      execute "set runtimepath=" . save_rtp
    end
  else
    silent call StashSessionBackup(1)
    let save_rtp = &runtimepath
    set runtimepath&
    GSessionMake
    execute "set runtimepath=" . save_rtp
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

if neobundle#tap('ShowMarks')
  let g:showmarks_include = 'abcdefghijklmnopqrstuvwxyz' . 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
  let g:showmarks_ignore_type = ""
  let g:showmarks_textlower = "\t"
  let g:showmarks_textupper = "\t"
  let g:showmarks_textother = "\t"
  let g:showmarks_auto_toggle = 0
  let g:showmarks_no_mappings = 1
  nmap mt <Plug>ShowMarksToggle
  call neobundle#untap()
endif

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
nmap s  <Plug>Ysurround
nmap ss <Plug>Yssurround
nmap sss <Nop>

" }}}2   wokmarks   {{{2

if neobundle#tap('wokmarks.vim')
  let g:wokmarks_do_maps = 0
  let g:wokmarks_pool = "abcdefghijklmnopqrstuvwxyz"
  nmap mm <Plug>ToggleMarkWok
  map mj <Plug>NextMarkWok
  map mk <Plug>PrevMarkWok
  autocmd User WokmarksChange :ShowMarksOn
  call neobundle#untap()
end

" }}}2   anzu   {{{2

if neobundle#tap('vim-anzu')
  let g:anzu_status_format = "/%#Type#%p%#None#  %i/%l %#WarningMsg#%w"
  let g:airline#extensions#anzu#enabled = 0
  nmap n <Plug>(anzu-n-with-echo)
  nmap N <Plug>(anzu-N-with-echo)
  nmap * <Plug>(anzu-star-with-echo)
  nmap # <Plug>(anzu-sharp-with-echo)
  call neobundle#untap()
endif

" }}}2    tComment    {{{2

let g:tcommentMaps = 0
let g:tcomment#blank_lines = 0
let g:tcommentGuessFileType_haml = 1
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

" }}}2    Word Word    {{{2

if neobundle#tap('vim-wordword')
  let g:wordword_break_on_punctuation = 1
  let g:wordword_no_break_on_decimal_point = 1
  map gs <Plug>(operator-wordword)
  call neobundle#untap()
endif

" }}}2    EasyMotion    {{{2

if neobundle#tap('vim-easymotion')
  let g:EasyMotion_keys = tolower('asdghklqwertyuiopzxcvbnmfj;')
  let g:EasyMotion_use_upper = 0
  let g:EasyMotion_smartcase = 1
  let g:EasyMotion_startofline = 0
  let g:EasyMotion_space_jump_first = 1
  let g:EasyMotion_enter_jump_first = 1
  let g:EasyMotion_re_anywhere = '\v' .
        \ '(\l)\zs(\u)' . '|' .
        \ '(\l)\zs(\u)' . '|' .
        \ '(_\zs.)' . '|' .
        \ '(#\zs.)'
  let g:EasyMotion_re_anywhere .= '|' . '\s+\m\(\k\|\s\)\@!\zs.'

  map <LocalLeader>e <Plug>(easymotion-w)
  nmap <LocalLeader>E <Plug>(easymotion-overwin-w)
  xmap <LocalLeader>E <Plug>(easymotion-bd-w)
  omap <LocalLeader>E <Plug>(easymotion-bd-w)
  map <LocalLeader>L <Plug>(easymotion-j)
  map <LocalLeader>H <Plug>(easymotion-k)
  map <LocalLeader>n <Plug>(easymotion-n)
  map <LocalLeader>N <Plug>(easymotion-N)
  map <LocalLeader>s <Plug>(easymotion-overwin-f2)
  map <LocalLeader>ge <Plug>(easymotion-jumptoanywhere)
  " omap <LocalLeader>l <Plug>(easymotion-special-l)
  " omap <LocalLeader>p <Plug>(easymotion-special-p)
  " xmap <LocalLeader>l <Plug>(easymotion-special-l)
  " xmap <LocalLeader>p <Plug>(easymotion-special-p)
  nmap <LocalLeader>; <Plug>(easymotion-next)
  nmap <LocalLeader>: <Plug>(easymotion-prev)

  call neobundle#untap()
endif

" }}}2    Sneak    {{{2

if neobundle#tap('vim-sneak')
  let g:sneak#textobject_z = 0
  let g:sneak#use_ic_scs = 1
  let g:sneak#map_netrw = 0
  let g:sneak#prompt = 'Sneak: '
  nmap <Leader>; <Plug>SneakBackward
  xmap <Leader>; <Plug>VSneakBackward

  " workaround to disable `s` mappings
  nmap [nop] <Plug>Sneak_s
  nmap [nop] <Plug>Sneak_s

  for s:i.map_mode in ['n', 'o', 'x']
    execute s:i.map_mode . "map f <Plug>Sneak_f"
    execute s:i.map_mode . "map F <Plug>Sneak_F"
    execute s:i.map_mode . "map t <Plug>Sneak_t"
    execute s:i.map_mode . "map T <Plug>Sneak_T"
  endfor

  call neobundle#untap()
endif

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
      \   [['open', 'close']],
      \   [['start', 'end']],
      \   [['new', 'old']],
      \   [['是', '否']],
      \   [['有', '無']],
      \   [['上', '下']],
      \   [['左', '右']],
      \   [['前', '後']],
      \   [['內', '外']],
      \   [['少', '多']],
      \   [['長', '寬', '高']],
      \   [['男', '女']],
      \   [['出', '入']],
      \   [['新', '舊']],
      \   [['強', '弱']],
      \   [['，', '。', '、']],
      \   [['成功', '失敗']],
      \   [['host', 'guest']],
      \   [['east', 'west']],
      \   [['south', 'north']],
      \   [['internal', 'external']],
      \   [['prefix', 'suffix']],
      \   [['decode', 'encode']],
      \   [['short', 'long']],
      \   [['request', 'response']],
      \   [['pop', 'shift']],
      \   [['child', 'parent']],
      \   [['import', 'export']],
      \   [['ancestor', 'descendant']],
      \   [['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday',
      \     'Friday', 'Saturday'], ['hard_case', {'name': 'Days'}]],
      \   [['(:)', '（:）', '「:」', '『:』'], 'sub_pairs'],
      \ ]
" ruby, rails       {{{3
let g:cycle_default_groups += [
      \   [["if", "unless"]],
      \   [["blank?", "present?"]],
      \   [["any?", "empty?"]],
      \   [["while", "until"]],
      \   [["begin", "end"]],
      \   [['assert', 'refute']],
      \   [['must', 'wont']],
      \   [["foreign_key", "primary_key"]],
      \   [["new_record?", "persisted?"]],
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
      \   [['resolve', 'reject']],
      \ ]
" 少用項目               }}}3 {{{3
let g:cycle_default_groups += [
      \   [['日', '一', '二', '三', '四', '五', '六']],
      \   [['sell', 'buy']],
      \   [['portrait', 'landscape']],
      \   [['bright', 'intelligence']],
      \ ]

" }}}3

" FileType ruby
let g:cycle_default_groups_for_ruby = [
      \   [['stylesheet_link_tag ', 'javascript_include_tag ']],
      \ ]

" }}}2    delimitMate    {{{2

let delimitMate_matchpairs = "(:),{:},[:],<:>,《:》,〈:〉,［:］,（:）,「:」,『:』,‘:’,“:”"
let delimitMate_excluded_regions = ""
let delimitMate_expand_space = 1
let delimitMate_expand_cr = 1
" let delimitMate_smart_quotes = 0
" let delimitMate_smart_matchpairs = ''
let delimitMate_balance_matchpairs = 1

" }}}2    splitjoin    {{{2

let g:splitjoin_split_mapping = ''
let g:splitjoin_join_mapping = ''
nmap g<CR> :SplitjoinSplit<CR>
nmap gJ :SplitjoinJoin<CR>
let g:splitjoin_normalize_whitespace = 1
let g:splitjoin_align = 1

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

let g:prettyprint_show_expression = 1
let g:prettyprint_strin = ['split']

" }}}2    altercmd    {{{2

let bundle = neobundle#get('vim-altercmd')
function! bundle.hooks.on_post_source(bundle)
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
  AlterCommand diffoff SafeDiffOff
  AlterCommand do diffget
  AlterCommand dp diffput
  AlterCommand '<,'>d '<,'>diffget
  " AlterCommand '<,'>dp '<,'>diffput
  AlterCommand gits Gstatus
  AlterCommand gb[lame] GBlameA
  AlterCommand r[ename] Rename <C-R>%<C-R>=EatChar('\s')<CR>
  AlterCommand rpu[ma] Rpuma
  AlterCommand to[uch] Touch %<C-R>=EatChar('\s')<CR>
  AlterCommand qu[ickrun] QuickRun
  " AlterCommand '<,'>r[un] '<,'>QuickRun
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
  AlterCommand a A
  AlterCommand at AT
  AlterCommand tjs Tjs
  AlterCommand tcss Tcss
  AlterCommand bu NeoBundleUpdate
  AlterCommand bi NeoBundleInstall
  AlterCommand bl ViewNeoBundleUpdatesLog
endfunction

" Ref helpgrep Eatchar
function! EatChar(pattern)
  let c = nr2char(getchar(0))
  return (c =~ a:pattern) ? '' : c
endfunction

" TODO unlet bundle

" }}}2    LargeFile    {{{2

" TODO delcommand Large
" let g:LargeFile           = 40
" let g:LargeFile_size_unit = 1024    " KB
" let g:LargeFile_patterns  = '*.log,*.log.1,*.sql'
let g:LargeFile_verbose   = 0
" autocmd User LargeFileRead call s:large_file_read()
" autocmd User LargeFile call s:large_file_detected()

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
  if dir_name =~ '/home/\w+/fc/\(\w\+/\)\?log' || dir_name =~ '/home/\w\+/nerv/log'
    if &fileencoding != 'utf-8'
      edit! ++enc=utf-8
    endif
    syntax match railslogEscape '\e\[[0-9;]*m' conceal
  elseif dir_name =~ '/home/\w+/logs$'
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
command! -bang -bar -complete=file -nargs=? Gbk
      \ edit<bang> ++enc=gbk <args>
command! -bang -bar -complete=file -nargs=? ShiftJIS
      \ edit<bang> ++enc=shift-jis <args>

"     sudo write    {{{2

function! SudoWrite()
  " TODO 'autoread', prevent prompt for reload
  let modified = &l:modified
  setlocal nomodified
  silent! execute 'write !sudo tee % >/dev/null'
  let &l:modified = v:shell_error ? modified : 0
endfunction

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

command! SafeDiffOff call SafeDiffOff()
function! SafeDiffOff()
  if &diff
    if version >= 704 && 0  " won't happen, since diffoff broken sometimes
      normal! diffoff
    else
      setlocal diff& scrollbind& cursorbind& wrap& foldcolumn&
      set scrollopt=ver,hor,jump
      let &l:foldmethod = exists('b:save_foldmethod') ? b:save_foldmethod : 'marker'
    endif
  else
    echomsg 'Not in diff mode.'
  endif
endfunction

" }}}2   Re-diff with iwhite diffopt toggled     {{{2

function! s:diffupdate_toggle_w()
  if &diff
    let iwhite = index(split(&diffopt, ','), 'iwhite') < 0
    if iwhite
      set diffopt+=iwhite
      echomsg 'iwhite on'
    else
      set diffopt-=iwhite
      echomsg 'iwhite off'
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

  execute "normal! " . v:count1 . a:key
  let l:moved =
        \ l:cnum  != col('.')  ||
        \ l:lnum  != line('.') ||
        \ l:wline != winline()

  return l:moved
endfunction

" }}}2   Scroll     {{{2

function! s:scroll_down(...)
  let mode = a:0 ? a:1 : 'n'
  let l:count = a:0 > 1 ? a:2 : 2

  if has("gui_running") || winnr('$') > 1
    return '7j'
  else
    return repeat("\<ScrollWheelDown>", l:count)
  endif
endfunction


function! s:scroll_up(...)
  let mode = a:0 ? a:1 : 'n'
  let l:count = a:0 > 1 ? a:2 : 2

  if has("gui_running") || winnr('$') > 1
    return '7k'
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

  " Ref https://github.com/haya14busa/dotfiles/commit/10e6a24
  " started In Diff-Mode set diffexpr (plugin not loaded yet)
  let &diffexpr = 'EnhancedDiff#Diff("git diff", "--diff-algorithm=patience")'

  nnoremap <buffer> <LocalLeader>dh :diffget :2 <Bar> diffupdate<CR>
  nnoremap <buffer> <LocalLeader>dl :diffget :3 <Bar> diffupdate<CR>
  nnoremap <buffer> <LocalLeader>du :<C-U>diffupdate<CR>
  nnoremap <buffer> <silent> <LocalLeader>dU :call <SID>diffupdate_toggle_w()<CR>
endfunction

" }}}2   clipboard 存取    {{{2

let s:i.clipboard_pool = ''

if has('clipboard')
  if $OSTYPE == 'cygwin' || has("gui_win32")
    let s:i.clipboard_pool = '*'
  elseif $OSTYPE == 'linux-gnu' && exists('$DISPLAY')
    let s:i.clipboard_pool = '+'
  elseif $OSTYPE == 'darwin14.0'
    let s:i.clipboard_pool = '+'
  endif
endif

" http://vim.wikia.com/wiki/Using_the_Windows_clipboard_in_Cygwin_Vim
" TODO 正確處理字元編碼
function! Putclip(type, ...) range
  if !executable('putclip') && !executable('tmux')
    echohl WarningMsg | echomsg 'NOT SUPPORTED' | echohl None
    return
  endif

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

  if executable('putclip')
    call system('putclip', @@)
  else
    call system(printf(
          \   'tmux set-buffer "%s"',
          \   escape(@@, '"')
          \ ))
  endif

  let &selection = save_sel
  let @@ = save_reg
endfunction

function! Getclip()
  let save_reg = @@
  if executable('getclip')
    let @@ = system('getclip')
  elseif executable('tmux')
    let @@ = system('tmux show-buffer')
  else
    let @@ = 'NOT SUPPORTED'
  endif
  setlocal paste
  execute 'normal! p'
  setlocal nopaste
  let @@ = save_reg
endfunction

if !empty(s:i.clipboard_pool)
  execute printf('noremap <silent> <LocalLeader>y "%sy', s:i.clipboard_pool)
  execute printf('inoremap <silent> <LocalLeader>y <C-O>"%sy', s:i.clipboard_pool)
  if has("gui_win32") && s:i.clipboard_pool == '*'
    noremap! <S-Insert> <C-R>*
  endif

  execute printf('nnoremap <silent> <LocalLeader>p "%sp', s:i.clipboard_pool)
  execute printf('inoremap <silent> <LocalLeader>p <C-O>"%sp', s:i.clipboard_pool)
else
  vnoremap <silent> <LocalLeader>y :call Putclip(visualmode(), 1)<CR>
  nnoremap <silent> <LocalLeader>y :call Putclip('n', 1)<CR>
  inoremap <silent> <LocalLeader>y <C-O>:call Putclip('n', 1)<CR>

  nnoremap <silent> <LocalLeader>p :call Getclip()<CR>
  inoremap <silent> <LocalLeader>p <C-O>:call Getclip()<CR>
endif

" }}}2   Tmux   {{{2

" Bracketed Paste Mode {{{
"
" - http://slashdot.jp/journal/506765/Bracketed-Paste-Mode
" - https://cirw.in/blog/bracketed-paste
"
" - Use tmux 1.7 `paste-buffer -p` to paste
" - Use <F11> and tmux `send-keys "\e[201~"` for pastetoggle
"
" only required if lack of patch 8.0.0210
if !exists('&t_BE')
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
endif
" }}}

function! TmuxNewWindow(...) "{{{
  let options = a:0 ? a:1 : {}
  let text = get(options, 'text', '')
  let title = get(options, 'title', '')
  let directory = get(options, 'directory', getcwd())
  let method = get(options, 'method', 'new-window')
  let size = get(options, 'size', '40')
  let remember_pane = get(options, 'remember_pane', 0)
  let pane = ''

  if method == 'last'
    if !exists('s:last_tmux_pane') || empty(s:last_tmux_pane)
      echohl WarningMsg | echomsg "Can't find last tmux pane. Continue with 'new-window'." | echohl None
      let method = 'new-window'
    else
      " if system(printf('tmux list-pane -s -F "#{pane_id}" | egrep %%%s$', s:last_tmux_pane) =~ '%'
      "   let pane = s:last_tmux_pane
      " else
      "   echohl WarningMsg | echomsg "Can't find last tmux pane. Continue with 'new-window'." | echohl None
      "   let method = 'new-window'
      " endif
      let pane = s:last_tmux_pane
    endif
  elseif method == 'quit'
    if !exists('s:last_tmux_pane') || empty(s:last_tmux_pane)
      echohl WarningMsg | echomsg "Can't find last used pane." | echohl None
      return
    else
      call system('tmux kill-pane -t ' . matchstr(s:last_tmux_pane, '%\d\+'))
      unlet! s:last_tmux_pane
      return
    endif
  endif

  if empty(pane) && method != 'new-window'
    " use split pane if available
    let pane = matchstr(
          \   system('tmux list-pane -F "#{window_id}#{pane_id}:#{pane_active}" | egrep 0$'),
          \   '\zs@\d\+%\d\+\ze'
          \ )
  endif

  if empty(pane)
    if method == 'new-window'
      let cmd = 'tmux new-window -a '
            \ . (empty(title) ? '' : printf('-n %s', shellescape(title)))
            \ . printf(' -c %s', shellescape(directory))
    elseif method == 'v'
      let cmd = 'tmux split-window -d -v '
            \ . printf('-p %s -c %s ', size, shellescape(directory))
    elseif method == 'h'
      let cmd = 'tmux split-window -d -h '
            \ . printf(' -c %s ', shellescape(directory))
    endif

    let pane = substitute(
          \   system(cmd . ' -P -F "#{window_id}#{pane_id}"'), '\n$', '', ''
          \ )
  endif

  if remember_pane
    let s:last_tmux_pane = pane
  endif

  let window_id = matchstr(pane, '@\d\+')
  let pane_id = matchstr(pane, '%\d\+')

  if !empty(text)
    let cmd = printf(
          \   'tmux set-buffer %s \; paste-buffer -p -t %s -d \; send-keys -t %s Enter',
          \   shellescape(text),
          \   pane_id,
          \   pane_id
          \ )
    sleep 300m
    call system('tmux select-window -t ' . window_id)
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
function! s:move_window_into_tab_page(_, ...)
  " Move the current window into target_tabpagenr.
  " a:1 - target_tabpagenr : if not set, move into new tab page.
  " a:2 - open_relative : open new tab aside current tab (default 1).
  " a:3 - split_command : command to split buffer (default empty).
  " can also specify target_tabpagenr by v:count

  let target_tabpagenr = a:0 > 1 ? a:2 : 0
  let open_relative    = a:0 > 2 ? a:3 : 1
  let split_command    = a:0 > 3 ? a:4 : ''

  let original_tabnr = tabpagenr()
  let target_bufnr = bufnr('')
  let window_view = winsaveview()

  if v:count > 0
    let target_tabpagenr = v:count
  endif

  if target_tabpagenr > tabpagenr('$')
    let target_tabpagenr = tabpagenr('$')
    if original_tabnr == target_tabpagenr
      echohl WarningMsg | echomsg "Already in last tab." | echohl None
      return
    endif
  endif

  if target_tabpagenr == original_tabnr
    echohl WarningMsg | echomsg "Already in tab " . target_tabpagenr . "." | echohl None
    return
  elseif target_tabpagenr == 0 && winnr('$') == 1
    echohl WarningMsg | echomsg "Nothing to split out." | echohl None
    return
  endif

  if target_tabpagenr == 0
    tabnew
    if !open_relative
      tabmove
    endif
    execute target_bufnr 'buffer'
    let target_tabpagenr = tabpagenr()
  else
    execute target_tabpagenr 'tabnext'
    execute split_command 'new'
    execute target_bufnr 'buffer'
  endif
  call winrestview(window_view)

  execute original_tabnr 'tabnext'
  if winnr('$') == 1 && original_tabnr < target_tabpagenr
    let target_tabpagenr = target_tabpagenr - 1
  endif
  close

  execute target_tabpagenr 'tabnext'
endfunction " }}}

command! -nargs=* -count=0 MoveIntoTabpage call <SID>move_window_into_tab_page(<count>, <f-args>)

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
"
" example: autocmd FileWritePost,BufWritePost *-\(debug\|src\).js :JsCompress! 1
function! JsCompress(save, ...)
  if !g:enable_js_compress
    return
  endif
  let jar      = expand('~/') . 'bin/closure-compiler.jar'
  let defaults = ' --compilation_level=SIMPLE_OPTIMIZATIONS'
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

" }}}2   SQL 格式化   {{{2

function! SQLFormatter()
  if executable('anbt-sql-formatter')
    let endline = v:lnum + v:count - 1
    let text = join(getline(v:lnum, endline), '\n')

    execute printf('%s,%sdelete _', v:lnum, endline)

    let cmd = printf(
          \   'echo %s | anbt-sql-formatter',
          \   shellescape(text)
          \ )
    let result = split(system(cmd), '\n')

    call append(v:lnum - 1, result)
    return 0
  endif

  return 1
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
  let @/ = '\V' . pattern
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
    elseif <SID>quit_winodws_by_filetype('^ref-\w', '^quickrun')
      return
    elseif exists('t:gitdiffall_info')
      execute 'GitDiffOff'
    elseif winnr('$') > 1 && &diff
      execute 'wincmd t'
      call SafeDiffOff()
      only
    endif
  else
    echohl WarningMsg | echomsg "No other window to close" | echohl None
  endif
endfunction

function! s:quit_winodws_by_filetype(...) "{{{
  let win_count = winnr('$')
  for filetype_pattern in a:000
    silent windo if &filetype =~ filetype_pattern | execute "quit" | endif
  endfor
  execute 'wincmd t'
  return win_count > winnr('$')
endfunction "}}}

function! s:gblame_window_off()
  let win_count = winnr('$')
  silent windo if &filetype == 'fugitiveblame' | execute "normal gq" | endif
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
  setlocal foldmethod=marker
  setlocal iskeyword-=58
endfunction

" }}}2   SCSS   {{{2

function! s:scss_rc()
  setlocal foldmethod=marker
  setlocal formatoptions=l2
  try
    setlocal formatoptions+=j
  catch /^Vim\%((\a\+)\)\=:E539/
  endtry
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
  inoremap <buffer> <LocalLeader>br <br><CR>
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

  " Oh, these boolean were tested by exists()...
  " let g:ruby_fold = 1
  let g:ruby_no_expensive = 1
  let g:ruby_no_comment_fold = 1

  let g:ruby_indent_block_style = 'do'

  let g:ruby_minlines = 70

  let ruby_spellcheck_strings = 1

  let g:ruby_foldable_groups = 'NONE'
  " let g:ruby_foldable_groups = 'def'
  " let g:ruby_foldable_groups = 'do begin [ :'
  let g:ruby_minitest_fold = 1

  if !exists('b:rails_root')
    call RailsDetect()
  endif
  if exists('b:rails_root')
    let type = rails#buffer().type_name()
    if type =~ '^test'
      setlocal foldmethod=syntax foldlevel=4
    endif
  endif
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

" }}}2   SQL {{{2

function! s:sql_rc()
  if executable('anbt-sql-formatter')
    setlocal formatexpr=SQLFormatter()
  endif
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
  " VimEnter should come before `-c`, I don't know why this works
  autocmd VimEnter <buffer> normal! 0
endfunction

" }}}2   git commit   {{{2

function! s:gitcommit_rc(filename)
  setlocal textwidth=72
  if a:filename =~ "/nerv/.git/"
    syntax match gitcommitOverflowABAgile "\%>78c.*" contained contains=@Spell containedin=gitcommitOverflow
    highlight default link gitcommitOverflowABAgile Error
  endif
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
        \   setlocal formatoptions=roql2mBj |
        \ catch /^Vim\%((\a\+)\)\=:E539/ |
        \   setlocal formatoptions=roql2m |
        \ endtry

  autocmd FileType php,xml,html inoremap <buffer> <LocalLeader>/ </<C-X><C-O>

  autocmd FileType ruby call s:ruby_rc()
  autocmd FileType xml call s:xml_rc()
  autocmd FileType html,xhtml,haml,slim,eruby,phtml,markdown call s:html_rc()
  autocmd FileType haml call s:haml_rc()
  autocmd FileType php call s:php_rc()
  autocmd FileType sql call s:sql_rc()
  autocmd FileType javascript call s:js_rc()
  autocmd FileType css call s:css_rc()
  autocmd FileType scss call s:scss_rc()
  autocmd FileType help call s:help_rc()
  autocmd FileType vim call s:vim_rc()
  autocmd FileType zsh call s:zsh_rc()
  autocmd FileType gitcommit call s:gitcommit_rc(expand('<afile>:p'))
  autocmd FileType gitconfig call s:gitconfig_rc()
  autocmd FileType nginx call s:nginx_rc()
  autocmd FileType yaml call s:yaml_rc()

  autocmd FileType sh let g:is_bash=1

  autocmd FileType vim setlocal tabstop=2 softtabstop=2 shiftwidth=2 foldmethod=marker
  autocmd FileType rake,ruby,eruby,yaml setlocal tabstop=2 softtabstop=2 shiftwidth=2

  autocmd BufRead *.thor setfiletype ruby
  autocmd BufRead *.jbuilder setfiletype ruby

  autocmd BufRead *.adoc setfiletype asciidoc

  autocmd BufNewFile,BufRead /bootleq/notes/*.txt set modeline

  autocmd BufRead *.jsm setfiletype javascript
  autocmd BufRead */etc/hosts setfiletype hostconf

  " Firefox It's all text add-on
  " also see https://github.com/docwhat/itsalltext/issues/44
  autocmd BufRead www*.blogger.com*.itsalltext setfiletype html
  autocmd BufRead addons.mozilla.org.*.itsalltext setfiletype html
  autocmd BufRead github.com.*.itsalltext setfiletype markdown
  autocmd BufRead redmine.*.com*.itsalltext setfiletype textile
  autocmd BufRead pma.*com.*.itsalltext setfiletype sql
  autocmd BufRead redmine.*.com*.itsalltext setfiletype textile
  autocmd BufRead gitlab.*.itsalltext setfiletype markdown

  " Moztw
  autocmd BufRead firefox/download/downloadurl.txt setlocal binary
  autocmd BufRead *.shtml setlocal expandtab

  autocmd BufRead,BufNewFile *.md,*.markdown,*.mkd set filetype=ghmarkdown
  autocmd BufRead,BufNewFile /opt/nginx*/conf/*.conf,/opt/nginx*/conf/*.default set filetype=nginx
  autocmd BufRead,BufNewFile /etc/nginx*/*.conf,/etc/nginx*/*.default,/etc/nginx/sites-*/* set filetype=nginx
  autocmd BufRead /home/www/logs/*.log,/var/log/nginx/*.log setfiletype httplog

  autocmd BufRead /home/*/log/*.log,/var/log/*/*.log nnoremap <buffer> <LocalLeader>ddd :EmptyFile<CR>

  " let apache_version = "2.0"
  " let dosbatch_cmdextversion = 2

  autocmd CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
  autocmd InsertLeave * if &paste | set nopaste | set paste? | endif
  autocmd BufReadPost * if &ft != 'gitcommit' && line("'\"") > 0 && line ("'\"") <= line("$") | execute "normal! g'\"" | endif
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

  if has("autocmd") && exists("+omnifunc")
    autocmd Filetype *
          \ if &l:omnifunc == "" |
          \ setlocal omnifunc=syntaxcomplete#Complete |
          \ endif
  endif

  autocmd FilterWritePre * call s:config_in_diff_mode()

augroup END

" }}}1    Autocommands             ===========================================


" For Pair:                  {{{1 ============================================

if !empty($VM_HOST_OS)
  inoremap jj <C-\><C-N>
endif

if 0 && has('vim_starting')
  if executable('w')
    let result = system("w --no-header --short | wc -l")
    if str2nr(result) > 1
      noremap  ,, <C-\><C-N>
      noremap! ,, <C-\><C-N>

      nnoremap <silent> <Tab>   :bnext<CR>
      nnoremap <silent> <s-Tab> :bprevious<CR>

      nnoremap gr gT

      nunmap <C-H>

      nmap <silent> <C-P> <LocalLeader>F

      autocmd User Rails call s:rails_test_helpers_for_pair()

      function! s:rails_test_helpers_for_pair() "{{{
        let type = rails#buffer().type_name()
        let relative = rails#buffer().relative()
        if type =~ '^test' || (type == 'javascript-coffee' && relative =~ '^test/')
          nmap \t [rtest]
          nnoremap <silent> [rtest]l :call <SID>rails_test_tmux('h')<CR>
          nnoremap <silent> [rtest]w :call <SID>rails_test_tmux('new-window')<CR>
          nnoremap <silent> [rtest]. :call <SID>rails_test_tmux('last')<CR>
        end
      endfunction "}}}
    endif
  endif
endif

" }}}1    For Pair            ================================================


" Finish:                  {{{1 ==============================================

unlet! s:i
set secure

" vim: expandtab softtabstop=2 shiftwidth=2 foldmethod=marker
