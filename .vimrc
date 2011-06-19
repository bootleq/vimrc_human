" Vim configure file
" Author: bootleq <bootleq@gmail.com>
" Blog:   bootleq.blogspot.com
" ============================================================================

set nocompatible
let &termencoding = &encoding
set encoding=utf-8
set fileencodings=usc-bom,utf-8,taiwan,chinese,default,latin1
lang messages POSIX
filetype plugin indent on

" Vundle                 {{{1 ================================================

  " Setup {{{2

    let s:rtp="/tmp/vimrc_human/bootleq/.vim"

    " let s:rtp="~/.vim"
    " if has("gui_win32") | let s:rtp='c:\cygwin\home\admin\.vim' | endif
    " if expand("<sfile>") == '/etc/users/bootleq/.vimrc'
    "       \  && substitute(system("whoami"), '\n$', '', '') != 'bootleq'
    "       \  && ! exists("did_bootleq_runtime")
    "   let s:rtp="/etc/users/bootleq/.vim"
    "   let did_bootleq_runtime = 1
    " endif

    if !isdirectory(fnamemodify(s:rtp, ':p'))
      try
        call mkdir(fnamemodify(s:rtp, ':p'), "p")
      catch /^Vim\%((\a\+)\)\=:E739/
        echo "Error detected while processing: " . v:throwpoint . ":\n  " . v:exception .
              \  "\nCan't make vundle runtime directory. Skipped sourcing vimrc.\n"
        finish
      endtry
    endif

    exec "set rtp+=" . fnamemodify(s:rtp, ':p') . "bundle/vundle/"
    filetype off

    try
      call vundle#rc(fnamemodify(s:rtp, ':p') . "bundle")
    catch /^Vim\%((\a\+)\)\=:E117/
      echo "Error detected while processing: " . v:throwpoint . ":\n  " . v:exception .
            \ "\n\nNo Vundle installed for this vimrc. Skipped sourcing.\n\nTo install Vundle:\n  " .
            \ "git clone http://github.com/gmarik/vundle.git " . fnamemodify(s:rtp, ":p") . "bundle/vundle\n"
      finish
    endtry

    set rtp-=~/.vim

  " }}}2 Setup

  " plugin                                                                {{{2
      Bundle 'gmarik/vundle'
      Bundle 'L9'
      Bundle 'Align'
      Bundle 'FuzzyFinder'
      Bundle 'VisIncr'
      Bundle 'bootleq/camelcasemotion'
      Bundle 'bootleq/ShowMarks'
      Bundle 'git://github.com/bootleq/snipmate.vim.git'
      Bundle 'c9s/gsession.vim'
      Bundle 'netrw.vim'
      Bundle 'rails.vim'
      Bundle 'surround.vim'
      Bundle 'tComment'
      Bundle 'taglist.vim'
      Bundle 'wokmarks.vim'
  " ftplugin                                                         }}}2 {{{2
      Bundle 'bootleq/xml.vim'
  " syntax                                                           }}}2 {{{2
      Bundle 'JSON.vim'
      Bundle 'JavaScript-syntax'
      Bundle 'hail2u/vim-css3-syntax'
      Bundle 'hallison/vim-rdoc'
      Bundle 'httplog'
      Bundle 'nginx.vim'
      Bundle 'othree/html5.vim'
      Bundle 'plasticboy/vim-markdown'
      Bundle 'tpope/vim-haml'
  " indent                                                           }}}2 {{{2
      Bundle 'git://github.com/jiangmiao/simple-javascript-indenter.git'
  " colors                                                           }}}2 {{{2
    Bundle 'bootleq/vim-color-bootleg'
  "                                                                       }}}2

  filetype plugin indent on

" }}}1   Vundle                ===============================================

" 基本設定               {{{1 ================================================

  " }}}2    檔案格式    {{{2

    set fileformats=unix
    set noendofline

  " }}}2   GUI    {{{2

    if has("gui_running")
      set antialias=true
      so $VIMRUNTIME/delmenu.vim
      set langmenu=zh_TW.UTF-8
      so $VIMRUNTIME/menu.vim
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
    set cinkeys-=:      " TODO 經常亂縮
    set cinoptions+=(0
    set textwidth=78
    setlocal formatoptions=roql2
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
    set ruler
    set showcmd
    set shortmess+=I
    set nolinebreak
    set listchars=tab:>-,eol:¬,trail:*
    set bg=dark
    set ambiwidth=double
    syntax on
    colorscheme bootleg

    set title titlestring=%t%(\ %M%)%(\ (%{expand(\"%:~:.:h\")})%)%(\ %a%)
    set statusline=%<%f\ %h%m%r%w%=%-14.(%l,%c%V%)\ %P
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

    " set autochdir    " NOTE: 與某些 plugin 不合
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

  " }}}2   拼字檢查    {{{2

    nnoremap <silent><F8> :setlocal spell! spelllang=en_us<CR>

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

  " }}}2   :TOhtml 設定    {{{2

    let g:html_use_css = 1
    let use_xhtml = 1

  " }}}2

" }}}1   基本設定              ===============================================

" MAPPINGS             {{{1 ==================================================

  let maplocalleader = ","
  noremap  <Leader><LocalLeader> <LocalLeader>
  noremap! <Leader><LocalLeader> <LocalLeader>
  noremap  <LocalLeader>, <C-\><C-N>
  noremap! <LocalLeader>, <C-\><C-N>

  "   各種移動    {{{2

    noremap <expr> <Space>  repeat('<ScrollWheelDown>', 2)
    noremap <expr> z<Space> repeat('<ScrollWheelUp>', 2)
    noremap <expr> <C-Down> repeat('<ScrollWheelDown>', 3)
    noremap <expr> <C-Up>   repeat('<ScrollWheelUp>', 3)

    noremap <Up> gk
    inoremap <expr> <Up> pumvisible() ? "\<C-P>" : "\<C-O>gk"
    noremap <Down> gj
    inoremap <expr> <Down> pumvisible() ? "\<C-N>" : "\<C-O>gj"

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

    vnoremap * "9y/<C-R>=escape(@9, '\\/.*$^~[]')<CR><CR>
    vnoremap # "9y?<C-R>=escape(@9, '\\/.*$^~[]')<CR><CR>

    nnoremap ' `

    nmap <LocalLeader>w <C-W>
    nnoremap <C-W>gf :tab wincmd f<CR>
    nnoremap <expr> <CR> &modifiable ? "i<CR><C-\><C-N>" : "<C-]>"
    nnoremap <expr> <BS> &modifiable ? "i<C-W><C-\><C-N>" : "<C-O>"
    nnoremap <LocalLeader>cn :cn<CR>
    nnoremap <LocalLeader>cp :cp<CR>

    nnoremap <silent> 99gt :tablast<CR>
    nnoremap gr gT

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

    inoremap <C-Z> <C-O>u
    inoremap <LocalLeader>o <C-O>

    noremap <silent> <C-S> :update<CR>
    inoremap <silent> <C-S> <C-\><C-N>:update<CR>
    xnoremap <silent> <C-S> <C-\><C-N>:update<CR>

    noremap <C-Del> :quit<CR>
    noremap <C-kDel> :quit<CR>
    map <kDel> <Del>

  " }}}2   功能鍵    {{{2

    map  <F1> :help <C-R>=expand('<cword>')<CR><CR>
    map  <LocalLeader><F1> :tab help <C-R>=expand('<cword>')<CR><CR>
    xmap <F1> :<C-U>call RegStash(1)<CR>gvy:let b:tempReg=@"<CR>:call RegStash()<CR>:help <C-R>=b:tempReg<CR><CR>
    xmap <LocalLeader><F1> :<C-U>call RegStash(1)<CR>gvy:let b:tempReg=@"<CR>:call RegStash()<CR>:help <C-R>=b:tempReg<CR><CR>
    nmap <F2> :%s/<C-R><C-W>
    xmap <F2> :<C-U>call RegStash(1)<CR>gvy:let b:tempReg=@"<CR>:call RegStash()<CR>gv:<C-U>%s/ <C-R>=b:tempReg<CR>
    nmap <F4><F4> :qa<CR>
    nnoremap <F5> :call SynStackInfo()<CR>
    nnoremap <Leader><F5> :tabdo e!<CR>
    nnoremap <F6> :GitDiffOff<CR>
    set pastetoggle=<F11>
    map  <silent> <F12> :set list!<CR>
    imap <silent> <F12> <C-O>:set list!<CR>

  " }}}2   自動完成    {{{2

    cnoremap <LocalLeader>. <C-E>

    inoremap <LocalLeader>. <C-X><C-O>
    inoremap <expr> <C-J> pumvisible() ? "\<C-N>" : "\<C-J>"
    inoremap <expr> <C-K> pumvisible() ? "\<C-P>" : "\<C-K>"
    inoremap <expr> <Tab> pumvisible() ? "\<C-N>" : "\<Tab>"
    inoremap <expr> <S-Tab> pumvisible() ? "\<C-P>" : "\<S-Tab>"

  " }}}2   跨 Vim 剪貼    {{{2

    " http://vim.wikia.com/wiki/Transfer_text_between_two_Vim_instances
    nmap <Leader>xp :r $HOME/.vimxfer<CR>
    nmap <Leader>xy V:w! $HOME/.vimxfer<CR>
    vmap <Leader>xy :w! $HOME/.vimxfer<CR>
    vmap <Leader>xa :w>> $HOME/.vimxfer<CR>

  " }}}2

" }}}1   MAPPINGS              ==============================================

" ABBREVS             {{{1 ===================================================

  cnoreabbrev <expr> t ((getcmdtype() == ':' && getcmdpos() <= 2) ? 'tabnew'  : 't')
  cnoreabbrev <expr> m ((getcmdtype() == ':' && getcmdpos() <= 2) ? 'messages'  : 'm')
  cnoreabbrev <expr> tm ((getcmdtype() == ':' && getcmdpos() <= 3) ? 'TabMessage'  : 'tm')
  cnoreabbrev ll <lt>LocalLeader>
  inoreabbrev ll <lt>LocalLeader>

" }}}1    ABBREVS             ================================================

" CSCOPE                  {{{1 ===============================================

if has("cscope") && filereadable("/usr/bin/cscope")
  set cscopeprg=/usr/bin/cscope
  set cscopetag
  set cscopetagorder=0
  set cscopeverbose
  set cscopequickfix=s-,c-,d-,i-,t-,e-
  if filereadable("cscope.out")
    silent cs add cscope.out
  elseif $CSCOPE_DB != ""
    silent cs add $CSCOPE_DB
  endif
  let s:outFiles = [
      \   '/home/www/cscope.out',
      \   '/home/www/include/cscope.out',
      \ ]
  for outFile in s:outFiles
    if filereadable(outFile)
      try
        silent exe 'cs add ' . expand(outFile)
      catch /^Vim(cscope):E568:/
      endtry
    endif
  endfor
endif

" }}}1    CSCOPE            ==================================================

" CTAGS                  {{{1 ================================================

  " from hotoo http://gist.github.com/476387
  let tlist_html_settings   = 'html;h:Headers;o:IDs;c:Classes'
  let tlist_xhtml_settings   = 'html;h:Headers;o:IDs;c:Classes'
  " let tlist_php_settings   = 'html;h:Headers;o:IDs;c:Classes'
  let tlist_javascript_settings = 'js;f:Functions;c:Classes;o:Objects'
  let tlist_css_settings = 'css;c:Classes;o:Objects(ID);t:Tags(Elements)'

  set tags+=../tags,./*/tags
  if has("gui_running")
    noremap <silent> <M-z> :TlistToggle<CR>
  else
    noremap <silent> z :TlistToggle<CR>
  endif

" }}}1    CTAGS            ===================================================

" PLUGINS             {{{1 ===================================================

  runtime! ftplugin/man.vim    " 啟用 |:Man| 指令
  runtime! macros/matchit.vim

  " Netrw    {{{2

    " "let g:netrw_ftp = 1
    " let g:netrw_preview = 1
    " let g:netrw_ignorenetrc = 0
    " "let g:netrw_ftpextracmd = 'passive'

    let g:netrw_liststyle = 3
    let g:netrw_winsize = 20
    " let g:netrw_browsex_viewer = '-'
    let g:netrw_timefmt = '%Y-%m-%d %T'
    " if exists("g:qfix_win") && a:forced == 0
    nmap <leader>e :Vexplore<CR>

  " }}}2    L9    {{{2

    cnoreabbrev <expr> g ((getcmdtype() == ':' && getcmdpos() <= 2) ? 'L9GrepBufferAll'  : 'g')

  " }}}2    FuzzyFinder    {{{2

    nnoremap <LocalLeader>ff :FufFileWithCurrentBufferDir<CR>
    " nnoremap <LocalLeader>fd :FufDir<CR>
    nnoremap <LocalLeader>fr :FufMruFile<CR>
    " nnoremap <LocalLeader>fm :FufBookmark<CR>
    nnoremap <LocalLeader>fb :FufBuffer<CR>
    " nnoremap <LocalLeader>fd :FufBookmarkDir<CR>
    nnoremap <LocalLeader>fc :FufChangeList<CR>
    nnoremap <LocalLeader>ft :FufBufferTagAll<CR>
    nnoremap <LocalLeader>fh :FufHelp<CR>
    nnoremap <LocalLeader>fq :FufQuickfix<CR>
    nnoremap <silent> <LocalLeader>f<F5> :FufRenewCache<CR>

    let g:fuf_dataDir = '~/.vim/fuf-data'
    let g:fuf_modesDisable = ['coveragefile', 'dir', 'line', 'bookmarkdir', 'bookmarkfile', 'mrucmd', 'jumplist', 'taggedfile', 'givenfile', 'givedir']
    let g:fuf_keyOpen=''
    let g:fuf_keyOpenSplit=''
    let g:fuf_keyOpenVsplit='<LocalLeader><CR>'
    let g:fuf_keyOpenTabpage='<CR>'
    let g:fuf_keyPreview='<Space>'
    let g:fuf_buffer_keyDelete='<C-D>'
    if $OSTYPE == 'cygwin'
      let g:fuf_abbrevMap = {
            \   "^r:" : [ "/cygdrive/g/repository/", "/cygdrive/n/repository/" ],
            \   "^w:" : ["/cygdrive/g/web"],
            \   "^c:" : ["~/webdev/code-snippets"],
            \   "^d:" : ["~/webdev/"],
            \   '^vr:' : map(filter(split(&runtimepath, ','), 'v:val !~ "after$"'), 'v:val . ''/**/'''),
            \ }
    else
      let g:fuf_abbrevMap = {
            \   "^r:" : [ "~/repository/" ],
            \   "^g:" : [ "/opt/ruby/lib/ruby/gems/1.8/gems/" ],
            \   "^w:" : [ "/home/www/" ],
            \   "^c:" : ["~/webdev/code-snippets"],
            \   "^d:" : ["~/webdev/"],
            \   '^vr:' : map(filter(split(&runtimepath, ','), 'v:val !~ "after$"'), 'v:val . ''/**/'''),
            \ }
    endif
    let g:fuf_mrufile_maxItem = 100
    let g:fuf_mrucmd_maxItem = 100
    let g:fuf_maxMenuWidth = 90
    " After VimEnter, set bookmark-dir with command 'FufBookmarkDirAdd'.
    " Also use 'FufEditDataFile'.

    autocmd BufEnter \[fuf\] setlocal pumheight=0   " can punheight setlocal?
    autocmd BufLeave \[fuf\] setlocal pumheight=25
    autocmd BufEnter \[fuf\] setlocal nowrap
    autocmd BufEnter \[fuf\] inoremap <buffer> <Tab> <C-N>
    autocmd BufEnter \[fuf\] inoremap <buffer> <S-Tab> <C-P>

    " }}}3    FuzzyFinder find registers    {{{3
      let g:fuf_regListener = {}
      let g:fuf_regListener.putBefore = 0   " 0: p, 1: P

      function! g:fuf_regListener.onComplete(item, method)
        let l:regName = strpart(a:item, 1, 1)
        if a:method == 4
          silent exec 'normal "' . l:regName . (g:fuf_regListener.putBefore ? 'P' : 'p')
        else
          exec '7new [@' . escape( l:regName, '"' ) . ']'
          setlocal noswapfile buftype=nofile bufhidden=wipe
          exec '0put=@' . l:regName
          redraw
          setlocal nomodified
        endif
      endf
      function g:fuf_regListener.onAbort()
      endf

      function! g:fuf_regFinder(putBefore)
        let g:fuf_regListener.putBefore = a:putBefore
        redir => l:regs
        silent exec ':registers'
        redir END
        let l:regList = split(l:regs, '\n')
        let l:regList = filter(l:regList, 'v:val =~ "' . escape('\m^".\s\{3,}\S\+', '\"') . '"')  " remove non-register lines
        " let l:regList = map(l:regList, 'substitute(v:val, "\\m.\\{' . &columns . '}\\zs.*", "...", "")')  " has problem with long line
        call fuf#callbackitem#launch('', 1, 'registers>', g:fuf_regListener, l:regList, 0)
      endf

      nnoremap <LocalLeader>fp :call g:fuf_regFinder(0)<CR>
      nnoremap <LocalLeader>fP :call g:fuf_regFinder(1)<CR>

    " }}}3    FuzzyFinder find tabs    {{{3

      let g:fuf_tabListener = {}

      function! g:fuf_tabListener.onComplete(item, method)
        let l:tabnr = matchstr(a:item, '\d\+')
        if a:method == 4
          silent exec 'normal ' . l:tabnr . 'gt'
        else
          silent exec 'tabclose ' . l:tabnr
        endif
      endf
      function g:fuf_tabListener.onAbort()
      endf
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
      endf
      nnoremap <LocalLeader>fg :call g:fuf_tabFinder()<CR>

    " }}}3    FuzzyFinder find tabs

  " }}}2   Align    {{{2

    let g:Align_xstrlen = 3
    vnoremap <silent> <Leader>= :Align! l: => = :<CR>

    " Modified from http://lilydjwg.is-programmer.com/posts/24706
    fun! Lilydjwg_Align(type) range
      try
        let pat = g:Lilydjwg_align_def[a:type]
      catch /^Vim\%((\a\+)\)\=:E716/
        echohl ErrorMsg | echoerr "對齊方式 " . a:type . " 沒有定義。" | echohl None
        return
      endtry
      call Align#AlignPush()
      call Align#AlignCtrl(pat[0])
      if len(pat) == 3
        call Align#AlignCtrl(pat[2])
      endif
      exe a:firstline.','.a:lastline."call Align#Align(0, '". pat[1] ."')"
      call Align#AlignPop()
    endf
    fun!  Lilydjwg_Align_complete(ArgLead, CmdLine, CursorPos)
      return keys(g:Lilydjwg_align_def)
    endf
    command -nargs=1 -range -complete=customlist,Lilydjwg_Align_complete
          \ LA <line1>,<line2>call Lilydjwg_Align("<args>")
    let g:Lilydjwg_align_def = {
          \   'css': ['WP0p1l:', ':\@<=', 'v \v^\s*/\*|\{|\}'],
          \ }

  " }}}2   Rails    {{{2

    " let g:loaded_rails = 1
    let g:rails_statusline = 1
    let g:rails_url = 'http://localhost/'
    " set title titlestring=%t%(\ %M%)%(\ (%{expand(\"%:~:.:h\")})%)%(\ %a%)%(\ %{rails#statusline(1)})%
    autocmd User Rails command! Rnginx exec "!sudo\ /etc/init.d/nginx\ restart"
    autocmd User Rails command! Rclearlog exec "silent Rake log:clear"

  " }}}2   TagList   {{{2

    if ! executable('ctags')
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

    let g:gsession_non_default_mapping = 1
    nnoremap <leader>ss    :call MakeSessionWithSafety()<CR>
    nnoremap <leader>se    :GSessionEliminateCurrent<CR>
    nnoremap <leader>sn    :NamedSessionMake<CR>
    nnoremap <leader>sl    :NamedSessionLoad<CR>
    " nnoremap <leader>sm    :NamedSessionMenu<CR>

    " 特定情形下，不直接存 sessoin
    function! MakeSessionWithSafety()
      let prompt = 0
      if exists('b:eikeep')
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

      if ! empty(prompt)
        redraw | echomsg prompt | redraw
        let yes = getchar()
        if nr2char(yes) != 'y'
          echomsg 'Aborted.' | redraw
        else
          :silent call StashSessionBackup(1)
          :GSessionMake
        end
      else
        :silent call StashSessionBackup(1)
        :GSessionMake
      endif
    endf

    " 備份／還原 session 檔案
    let g:session_back_dir = expand('~/.vim/session/backup')
    if !isdirectory(g:session_back_dir)
      call mkdir(g:session_back_dir, "p")
    endif

    command! -nargs=? StashSessionBackup call StashSessionBackup()
    command! -nargs=? StashSessionBackupPop call StashSessionBackup(1)
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
    endf

    " FIXME 再讀取 session 時 filetype 也忘光了
    command! -nargs=0 CleanMakeGSession call CleanMakeGSession()
    function! CleanMakeGSession()
      let ssop = &ssop
      set sessionoptions-=globals
      set sessionoptions-=localoptions
      set sessionoptions-=options
      abclear
      mapclear
      mapclear!
      :GSessionMake
      exec "set sessionoptions=" . ssop
      echomsg 'For clearer saving, quit and re-enter Vim now.'
    endf

  " }}}2   ShowMarks   {{{2

    let g:showmarks_include='abcdefghijklmnopqrstuvwxyz' . 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
    let g:showmarks_ignore_type=""
    let g:showmarks_textlower="\t"
    let g:showmarks_textupper="\t"
    let g:showmarks_textother="\t"
    let g:showmarks_auto_toggle = 0
    nnoremap <silent> mo :ShowMarksOn<CR>
    nnoremap <silent> mt :ShowMarksToggle<CR>

  " }}}2   wokmarks   {{{2

    let g:wokmarks_do_maps = 0
    let g:wokmarks_pool = "abcdefghijklmnopqrstuvwxyz"
    map mm <Plug>ToggleMarkWok
    map mj <Plug>NextMarkWok
    map mk <Plug>PrevMarkWok
    map <M-Left>  <Plug>SetMarkWok
    map <M-Right> <Plug>ToggleMarkWok
    map <M-Up>    <Plug>PrevMarkWok
    map <M-Down>  <Plug>NextMarkWok
    autocmd User WokmarksChange :ShowMarksOn

  " }}}2    tComment    {{{2

    let g:tcommentMapLeaderOp1 = ''
    let g:tcommentMapLeaderOp2 = ''
    let g:tc_option = ' col=1'
    noremap <silent> <expr> <LocalLeader>cc ":TComment       " . (exists('b:tc_option') ? b:tc_option : g:tc_option) . "<CR>"
    noremap <silent> <expr> <LocalLeader>cb ":TCommentBlock  " . (exists('b:tc_option') ? b:tc_option : g:tc_option) . "<CR>"
    noremap <silent> <expr> <LocalLeader>ci ":TCommentInline " . (exists('b:tc_option') ? b:tc_option : g:tc_option) . "<CR>"
    noremap <silent> <expr> <LocalLeader>c$ ":TCommentRight  " . (exists('b:tc_option') ? b:tc_option : g:tc_option) . "<CR>"
    map <silent><expr> <LocalLeader>ca IsInComment() ?
          \ "vac:TComment " . (exists('b:tc_option') ? b:tc_option : g:tc_option) . "<CR>" :
          \ ":TComment " . (exists('b:tc_option') ? b:tc_option : g:tc_option) . "<CR>"

    let g:EnhCommentifyRespectIndent = 'No'
    let g:EnhCommentifyUseSyntax = 'Yes'
    let g:EnhCommentifyPretty = 'Yes'
    let g:EnhCommentifyBindInInsert = 'No'
    let g:EnhCommentifyMultiPartBlocks = 'Yes'
    let g:EnhCommentifyCommentsOp = 'Yes'
    let g:EnhCommentifyAlignRight = 'Yes'
    " let g:EnhCommentifyUseBlockIndent = 'Yes'

  " }}}2    CamelCaseMotion    {{{2

    let g:camelcasemotion_leader='g'

  " }}}2


" }}}1    PLUGINS            =================================================

" TabLine 設定             {{{1 ==============================================

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
  endf

  function! s:CalcTabLength(tab)
    return strlen(a:tab.n) + 2 + strlen(a:tab.split) + strlen(a:tab.flag) + StrWidth(a:tab.filename)
  endf

  function! s:TabLineTotalLength(dict)
    let length = 0
    for i in (a:dict)
      let length += strlen(i.n) + 2 + strlen(i.split) + strlen(i.flag) + StrWidth(i.filename)
    endfor
    return length
  endf

" }}}1    TabLine 設定             ===========================================

" FUNCTIONS     {{{1 =========================================================

  "     清除多餘 Tab, 空白    {{{2

    command -nargs=0 TidySpaces call TidySpaces()
    function TidySpaces()
      let oldCursor = getpos(".")
      %s/\r//ge
      %s/\t/    /ge
      %s/\s\+$//ge
      call setpos('.', oldCursor)
    endf

  "     變更編碼    {{{2

    command! -nargs=0 Utf8 call ReloadWithEncoding("utf-8")
    command! -nargs=0 Big5 call ReloadWithEncoding("big-5")
    function! ReloadWithEncoding(encoding)
      exec "e! ++enc=" . a:encoding
    endf

  " }}}2   清除／復原 search pattern   {{{2

    let g:lastSearchPattern = ''
    function! ToggleSearchPattern()
      if @/ != ''
        let g:lastSearchPattern = @/
        let @/ = ''
      else
        let @/ = g:lastSearchPattern
      endif
    endf
    nmap <silent> <F3> :call ToggleSearchPattern()<CR>
    imap <silent> <F3> <C-O>:call ToggleSearchPattern()<CR>

  " }}}2   暫存／復原 position    {{{2

    " @params stash/pop
    function PosStash(...)
      let l:stash = a:0 > 0 ? a:1 : 0
      if l:stash
        let s:stashCursor = getpos(".")
        let g:stashCursor = s:stashCursor
      else
        call setpos('.', s:stashCursor)
      endif
    endf

  " }}}2   暫存／復原 register 內容   {{{2

    " @params stash/pop, regname
    function RegStash(...)
      let l:stash = a:0 > 0 ? a:1 : 0
      let l:regname = a:0 > 1 ? a:2 : v:register
      if l:stash
        let s:stashReg = [getreg(l:regname), getregtype(l:regname)]
        let g:stashReg = s:stashReg
      else
        call setreg(l:regname, s:stashReg[0], s:stashReg[1])
      endif
    endf

  " }}}2   暫存／復原 mark 內容   {{{2

    " @params stash/pop, markname
    function MarkStash(...)
      let l:stash = a:0 > 0 ? a:1 : 0
      let l:markname = a:0 > 1 ? a:2 : 'm'
      if l:stash
        let s:stashMark = getpos("'" . l:markname)
        let g:stashMark = s:stashMark
      else
        call setpos("'" . l:markname, s:stashMark)
      endif
    endf

  " }}}2   字串長度（column 數）   {{{2

    function StrWidth(str)
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
    endf

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
    endf

  " }}}2    git difftool     {{{2

    " Most adopted from Bob Hiestand's vsccommand plugin
    " http://www.vim.org/scripts/script.php?script_id=90
    command! -nargs=? GitDiff cal GitDiff(<f-args>)
    function! GitDiff(...)
      let rev = "HEAD~" . (a:0 > 0 ? a:1 : 0)
      let oldDir = getcwd()
      let newDir = fnameescape(expand('%:p:h'))
      let filetype = &filetype
      let cdCommand = haslocaldir() ? 'lcd' : 'cd'

      exec cdCommand . " " . newDir
      let prefix = substitute(system("git rev-parse --show-prefix"), '\n$', '', '')
      let subject = system("git log -1 --format=format:%s " . rev)
      let info = system("git log -1 --format=format:%s\\ %n%h' -- '%an' -- '%ai\\ '('%ar')' " . rev)
      let result = system("git show " . rev . ":" . shellescape(prefix . expand('%:.')))
      exec cdCommand . " " . oldDir

      redraw!
      if v:shell_error
        echohl ErrorMsg | echomsg "GitDiff ERROR: " . substitute(result, '[\n]', ' ', 'g') | echohl None
      else
        let b:stashFoldMethod=&fdm
        exec 'vertical new'
        silent put=result | 0delete _
        exec 'set filetype=' . filetype
        let t:git_diff_info = info
        set buftype=nofile
        diffthis | wincmd p | diffthis
      endif
    endf

    command! GitDiffOff cal GitDiffOff()
    function! GitDiffOff()
      if &diff
        if bufname("%") =~ '^\[git '
          wincmd q
        endif
        only | call MyDiffOff()
      endif
    endf

  " }}}2   Custom diffoff     {{{2

    command! MyDiffOff cal MyDiffOff()
    function! MyDiffOff()
      if &diff
        setlocal diff&
        setlocal scrollbind&
        setlocal cursorbind&
        set scrollopt=ver,hor,jump
        setlocal wrap&
        let fdm = exists('b:stashFoldMethod') ? b:stashFoldMethod : 'marker'
        exec "setlocal foldmethod=" . fdm
        setlocal foldcolumn&
      else
        echomsg 'Not in diff mode.'
      endif
    endf

  " }}}2   Big File     {{{2

    " ref LargeFile http://www.vim.org/scripts/script.php?script_id=1506
    function! BigFile(fname)
      if getfsize(a:fname) >= g:BigFile
        syn clear
        if ! exists('b:eikeep')
          let b:eikeep = &eventignore
          let b:ulkeep = &undolevels
          let b:bhkeep = &bufhidden
          let b:fdmkeep= &foldmethod
          let b:swfkeep= &swapfile
        endif

        set eventignore=FileType
        setlocal noswapfile bufhidden=unload fdm=manual undolevels=-1

        let fname=escape(substitute(a:fname,'\','/','g'),' ')
        exe "au BigFile BufEnter ".fname." set ul=-1"
        exe "au BigFile BufRead ".fname.' call FileTypeForBigFile(expand("<afile>"))'
        exe "au BigFile BufLeave ".fname." let &ul=".b:ulkeep."|set ei=".b:eikeep
        exe "au BigFile BufUnload ".fname." au! BigFile * ". fname
      endif
    endf

    command! BigFileUndo call BigFileUndo()
    function! BigFileUndo()
      set eventignore&
      set undolevels&
      set bufhidden&
      set foldmethod=marker
      set noswapfile
    endf

    function! FileTypeForBigFile(fname)
      if fnamemodify(a:fname, ":p:h") =~ '/home/www/fc/\(\w\+/\)\?log'
        if &fileencoding != 'utf-8'
          e! ++enc=utf-8
        endif
        syn match railslogEscape '\e\[[0-9;]*m' conceal
      elseif fnamemodify(a:fname, ":p:h") == '/home/www/logs'
        set syntax=httplog
      endif
    endf

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
          normal g^
        else
          normal ^
        endif
      else
        if &wrap
          normal g0
        else
          normal 0
        endif
      endif
      if a:mode == "v"
        call MarkStash(1, 'm')
        call setpos("'m", getpos('.'))
        normal gv`m
        call MarkStash(0, 'm')
      endif
      return ""
    endfunction

    function SmartEnd(mode)
      let curcol = col(".")
      let lastcol = a:mode == "i" ? col("$") : col("$") - 1
      " gravitate towards ending for wrapped lines
      if curcol < lastcol - 1
        call RegStash(1)
        normal yl
        let l:charlen = byteidx(getreg(), 1)
        call cursor(0, curcol + l:charlen)
        call RegStash()
      endif
      if curcol < lastcol
        if &wrap
          normal g$
        else
          normal $
        endif
      else
        normal g_
      endif
      " correct edit mode cursor position, put after current character
      if a:mode == "i"
        call RegStash(1)
        normal yl
        let l:charlen = byteidx(getreg(), 1)
        call cursor(0, col(".") + l:charlen)
        call RegStash()
      endif
      if a:mode == "v"
        call MarkStash(1, 'm')
        call setpos("'m", getpos('.'))
        normal gv`m
        call MarkStash(0, 'm')
      endif
      return ""
    endfunction

  " }}}2   clipboard 存取    {{{2

    " http://vim.wikia.com/wiki/Using_the_Windows_clipboard_in_Cygwin_Vim
    " TODO 正確處理字元編碼
    function! Putclip(type, ...) range
      let sel_save = &selection
      let &selection = "inclusive"
      let reg_save = @@
      if a:type == 'n'
        silent exe a:firstline . "," . a:lastline . "y"
      elseif a:type == 'c'
        silent exe a:1 . "," . a:2 . "y"
      else
        silent exe "normal! `<" . a:type . "`>y"
      endif
      call system('putclip', @@)
      let &selection = sel_save
      let @@ = reg_save
    endf

    if has('clipboard')
      if $OSTYPE == 'cygwin'
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
      let reg_save = @@
      let @@ = system('getclip')
      setlocal paste
      exe 'normal p'
      setlocal nopaste
      let @@ = reg_save
    endf

    if has('clipboard')
      if $OSTYPE == 'cygwin'
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

  " }}}2   開啟 URL    {{{2

    " 參考自依云的 vimrc: http://lilydjwg.is-programmer.com/
    fun! OpenURL(...)
      if a:0 > 0
        let url = a:1
      else
        " from syntax/help.vim
        let re = '\v(https?://|ftp://|file:/{3}|(www|web|w3)[a-z0-9_-]*\.[a-z0-9._-]+\.)[^.]+\..+'
        let url = matchstr(expand('<cWORD>'), re)
      endif
      if strlen(url) > 0
        if has('win32unix') || has('win32') || has('win64')
          call system("cmd /q /c start \"" . url . "\"")
        else
          call system("gnome-open " . url)
        endif
        echomsg "Launched URL: " . url
      else
        echohl WarningMsg | echomsg "No URL under cursor." | echohl None
      endif
    endf
    nnoremap <Leader><CR> :call OpenURL()<CR>

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
    endf
   cnoreabbrev <expr> ww ((getcmdtype() == ':' && getcmdpos() <= 3) ? 'FirefoxReload<CR>'  : 'ww')

  " }}}2   LastTab    {{{2

    function LastTab(act)

      let lt = g:lasttab
      let tabClosed = tabpagenr('$') < lt.knownLength ? 1 : 0

      if a:act ==# 'TabLeave'
        if ! tabClosed
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
          exe "tabn " . lastTab
        endif
      endif

      let lt.knownLength = tabpagenr('$')

    endf

    if ! exists('g:lasttab')
      let g:lasttab = {'leave':1, 'prevLeave':1, 'knownLength':1}
    endif
    au TabLeave * :call LastTab('TabLeave')
    au TabEnter * :call LastTab('TabEnter')
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
          exec "echohl " . list[0]
          echomsg repeat(' ', level) . list[1]
          let level += 1
          echohl None
        endfor
      endif
    endf
    function! SynInfo(syn)
      let synAttr =  synIDattr(a:syn, "name")
      if synAttr == ''
        echomsg 'No synID here.'
      else
        let idTrans = synIDtrans(a:syn)
        let syn = synIDattr(idTrans, "name")
        return [syn, synAttr . " - " . syn . " {fg: " . synIDattr(idTrans, 'fg') . ', bg: ' . synIDattr(idTrans, 'bg') . "}" ]
      endif
    endf
    " function! SynInfoSimple()
    "   let synAttr =  synIDattr(synID(line("."), col("."), 1), "name")
    "   if synAttr == ''
    "     echomsg 'No synID here.'
    "   else
    "     let synAttr .= " (" . synIDattr(synID(line("."), col("."), 0), "name") . ")"
    "     let idTrans = synIDtrans(synID(line("."), col("."), 1))
    "     let syn = synIDattr(idTrans, "name")
    "     exec "echohl " . syn
    "     let synAttr .= " - " . syn
    "     let synAttr .= " {fg: " . synIDattr(idTrans, 'fg')
    "     let synAttr .= ", bg: " . synIDattr(idTrans, 'bg')
    "     let synAttr .= "}"
    "     echo synAttr
    "     echohl None
    "   endif
    " endf

  " }}}2   TabMessage   {{{2

    " http://vim.wikia.com/wiki/Capture_ex_command_output
    function! TabMessage(cmd)
      redir => redirMessage
      silent execute a:cmd
      redir END
      tabnew
      silent put=redirMessage
      set nomodified
      setlocal buftype=nofile
      setlocal bufhidden=hide
      setlocal noswapfile
    endf
    command! -nargs=+ -complete=command TabMessage call TabMessage(<q-args>)

  " }}}2   自動補全成對括號    {{{2

    " from hotoo - http://hotoo.googlecode.com/svn/blog/vim-autocomplete-pairs.html
    inoremap ( <C-R>=OpenPair('(')<CR>
    inoremap ) <C-R>=ClosePair(')')<CR>
    inoremap { <C-R>=OpenPair('{')<CR>
    inoremap } <C-R>=ClosePair('}')<CR>
    inoremap [ <C-R>=OpenPair('[')<CR>
    inoremap ] <C-R>=ClosePair(']')<CR>
    function! OpenPair(char)
      let PAIRs = {
            \ '{' : '}',
            \ '[' : ']',
            \ '(' : ')',
            \ '<' : '>'
            \}
      let line = getline('.')
      let oL = len(split(line, a:char, 1))-1
      let cL = len(split(line, PAIRs[a:char], 1))-1

      let txt = strpart(line, col('.')-1)
      let ol = len(split(txt, a:char, 1))-1
      let cl = len(split(txt, PAIRs[a:char], 1))-1

      if oL>=cL || (oL<cL && ol>=cl)
        return a:char . PAIRs[a:char] . "\<Left>"
      else
        return a:char
      endif
    endfunction

    function! ClosePair(char)
      if getline('.')[col('.')-1] == a:char
        return "\<Right>"
      else
        return a:char
      endif
    endf

    inoremap ' <C-R>=CompleteQuote("'")<CR>
    inoremap " <C-R>=CompleteQuote('"')<CR>
    function! CompleteQuote(quote)
      let ql = len(split(getline('.'), a:quote, 1))-1
      " a:quote length is odd.
      if (ql%2)==1
        return a:quote
      elseif getline('.')[col('.') - 1] == a:quote
        return "\<Right>"
      'elseif '"'==a:quote && "vim"==&ft && 0==match(strpart(getline('.'), 0, col('.')-1), "^[\t ]*$")
      " 'elseif '"'==a:quote && '"'==strpart(&commentstring, 0, 1) && 0==match(strpart(getline('.'), 0, col('.')-1), "^[\t ]*$")
      " Todo: 改用 searchpairpos('(', '', ')', 'n') 也許更好？
      " Todo: 改用 &matchpairs 或 &commentstring
        " for vim comment.
        return a:quote
      elseif "'"==a:quote && 0==match(getline('.')[col('.')-2], "[a-zA-Z0-9]")
        " for Name's Blog.
        return a:quote
      else
        return a:quote . a:quote . "\<Left>"
      endif
    endfunction

  " }}}2   ToggleTextOption    {{{2

    " http://vim.wikia.com/wiki/Toggling_yes-no
    function! ToggleTextOption()

      let w = expand("<cword>")
      call RegStash(1, '"') | normal yl
      let c = @" | call RegStash(0, '"')
      let pairs = [
            \   ["true", "false"],
            \   ["0", "1"],
            \   ["yes", "no"],
            \   ["on", "off"],
            \   ["是", "否"],
            \   ["show", "hide"],
            \   ["left", "right"],
            \   ["before", "after"],
            \   ["absolute", "relative"],
            \   ["decode", "encode"],
            \   ["asc", "desc"],
            \   ["define", "undef"],
            \   ["exclude", "include"],
            \   ["if", "unless"],
            \   ["blank", "present"],
            \   ["while", "until"],
            \   ["first", "last"],
            \   ["in", "out"],
            \   ["get", "post"],
            \   ["to", "from"],
            \   ["only", "except"],
            \   ["foreign_key", "primary_key"],
            \   ["inspect", "to_yaml"],
            \   ["add_column", "remove_column"],
            \ ]

      let c_orig = c
      if     c=="+"      | let c="-"
      elseif c=="-"      | let c="+"
      elseif c=="<"      | let c=">"
      elseif c==">"      | let c="<"
      else               | let c=""
      endif
      if c != ""
        exec "normal r" . c
        return
      else
        let c = c_orig
      endif

      if match(w, c) >= 0   " cursor should not under a keyword
        for pair in pairs
          if w == pair[0]
            let w = s:ToggleTextOption_caseToggle(w, pair[1])
            break
          elseif w == pair[1]
            let w = s:ToggleTextOption_caseToggle(w, pair[0])
            break
          endif
        endfor
        if w != "" && w != expand('<cword>')
          call PosStash(1)
          exec "normal! \"_ciw\<C-R>=w\<CR>\<Esc>"
          call PosStash()
        endif
      endif

    endfunc

    fun! s:ToggleTextOption_caseToggle(in, out)
      if a:in =~ '^\u*$'
        return toupper(a:out)
      elseif a:in =~ '^\u'
        return toupper(strpart(a:out, 0, 1)) . strpart(a:out, 1)
      else
        return a:out
      endif
    endf

    nnoremap <silent> <LocalLeader>a :call ToggleTextOption()<CR>

  " }}}2   EvalVimScriptRegion    {{{2

    " from c9s - http://gist.github.com/444528 http://gist.github.com/572191
    fun! EvalVimScriptRegion(s,e)
      let lines = getline(a:s,a:e)
      let file = tempname()
      cal writefile(lines,file)
      redir @e
      silent exec ':source ' . file
      cal delete(file)
      redraw
      redir END
      echo "Region evaluated."

      if strlen(getreg('e')) > 0
        10new
        redraw
        silent file "EvalResult"
        setlocal noswapfile buftype=nofile bufhidden=wipe
        setlocal nobuflisted nowrap cursorline nonumber fdc=0
        " syntax init
        set filetype="eval"
        syn match ErrorLine +^E\d\+:.*$+
        hi link ErrorLine Error
        silent $put =@e
      endif
    endf
    augroup VimEval
      au!
      au filetype vim :command! -range Eval :cal EvalVimScriptRegion(<line1>,<line2>)
      au filetype vim :vnoremap <silent> <Leader>e <C-\><C-N>:call PosStash(1)<CR>gv:Eval<CR>:call PosStash()<CR>
      au filetype vim :vnoremap <silent> <F5> <C-\><C-N>:call PosStash(1)<CR>gv:Eval<CR>:call PosStash()<CR>
    augroup END

  " }}}2   fold expr - help 檔案以分隔線（====）分割區塊    {{{2

    fun! HelpDelimFoldLevel(line)
      if  getline(a:line-1)=~'=\{78,\}'
        return '>1'
      elseif getline(a:line+1)=~'=\{78,\}'
        return '<1'
      else
        return '='
      endif
    endf

  " }}}2   camelCase / under_score 轉換    {{{2

    " TODO when no keyword is under/after the cursor, try looking backward to find a word.
    fun! WordTransform()
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
        exec "normal f" . strpart(w, 0, 1)
        exec "normal \"_ciw\<C-R>=x\<CR>"
      else
        exec "normal \"_ciw\<C-R>=x\<CR>"
      endif
    endf
    nnoremap <LocalLeader>x :call WordTransform()<CR>

  " }}}2   :symbol / 'string' 轉換    {{{2

      " TODO 未實作
      " fun! SymbolStringTransform()
      "     let w = expand("<cword>")
      "     let x = ''
      "     let c = strpart(getline('.'), col('.') - 1, 1)
      " endf

  " }}}2   w!!    {{{2

    cnoremap <expr> w!! ((getcmdtype() == ':' && getcmdpos() <= 1) ? 'w !sudo tee % >/dev/null'  : 'w!!')

  " }}}2   JSLint   {{{2

    command! -nargs=* JSLint call JSLint(<f-args>)
    " @param boolean interact: 1 to prompt before lint.
    " @param string options: custom options for running JSLint. in JSON string, ex: '{"onevar":false}'
    fun! JSLint(...)
      if ! executable('jslint')
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
    endf

    fun! DoJSLint(cmd, file)
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
    endf

  " }}}2   js 壓縮（Closure Compiler）    {{{2

    if ! exists('g:enable_js_compress')
      let g:enable_js_compress = 1
    endif

    command! ToggleJsCompress call ToggleJsCompress()
    function! ToggleJsCompress()
      let g:enable_js_compress = ! g:enable_js_compress
    endf

    command! -bang -nargs=* JsCompress call JsCompress(<bang>0, <f-args>)
    " @param boolean save     0: save to temp file and return compressed content.
    "                         1: save with alternative filename, return the new name.
    " @param boolean interact 1 to prompt before starting compression.
    " @param string options   extra options for running the compiler.
    fun! JsCompress(save, ...)
      if ! g:enable_js_compress
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

      if ! executable(jar)
        echohl WarningMsg | echoerr "Can't execute java jar." | echohl None
        return
      endif

      if ! a:save
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
    endf

    fun! DoJsCompress(cmd, file, save)
      let makeprg_orig = &makeprg
      exec "set makeprg=" . escape(a:cmd, ' \"')
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
    endf

  " }}}2   bookmarklet 壓縮    {{{2

    command! -nargs=* Bookmarklet call Bookmarklet(<f-args>)
    fun! Bookmarklet(...)
      let result = JsCompress(0, 0, '--compilation_level=WHITESPACE_ONLY')
      if len(getqflist()) == 0 && strlen(result) > 0
        let reuse_win = 0
        for winnr in tabpagebuflist(tabpagenr())
          if bufname(winnr) == '[Bookmarklet]'
            exec winnr . 'wincmd w'
            let reuse_win = winnr
          endif
        endfor
        if ! reuse_win
          exec 'belowright 5new [Bookmarklet]'
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
    endf

  " }}}2   Toggle QuickFix window    {{{2

    " http://vim.wikia.com/wiki/Toggle_to_open_or_close_the_quickfix_window
    command! -bang -nargs=? QFix cal QFixToggle(<bang>0)
    fu! QFixToggle(forced)
      if exists("g:qfix_win") && a:forced == 0
        cclose
        unlet g:qfix_win
      else
        copen 10
        let g:qfix_win = bufnr("$")
      endif
    endf
    nnoremap <silent> <LocalLeader>q :QFix<CR>

  " }}}2   text-object for continuous comment    {{{2

    " NOTE: limitations
    " 1. Only test if first non-blank character is highlighted with "Comment".
    " 2. Always linewise.
    vnoremap <silent> ac :<C-U>call TxtObjComment()<CR>
    onoremap <silent> ac :<C-U>call TxtObjComment()<CR>
    fun! TxtObjComment()
      if exists("g:syntax_on")
        if ! IsInComment()
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
    endf

    fun! SearchContinuousComment(forward, lnum)
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
    endf

    fun! IsInComment(...)
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
    endf

  " }}}2

" }}}1    FUNCTIONS      =====================================================

" Filetype 個別設定             {{{1 =========================================
" iskeyword: ASCII 58 => :

  " }}}2   JavaScript   {{{2

    fun! s:js_rc()
      let b:tc_option = ''
      let g:SimpleJsIndenter_BriefMode = 1
      setlocal isk+=$
      setlocal isk-=58
      setlocal cindent
    endf

  " }}}2   CSS   {{{2

    fun! s:css_rc()
      let g:surround_99 = "/* \r */"
      set fdm=marker
      setlocal isk-=58
    endf

  " }}}2   SCSS   {{{2

    fun! s:scss_rc()
      let b:tc_option = ''
      let g:surround_99 = "/* \r */"
      setlocal fdm=marker
      setlocal formatoptions=l2
    endf

  " }}}2   HAML   {{{2

    fun! s:haml_rc()
      inoremap <LocalLeader>br <br><CR>
      let b:tc_option = ''
      setlocal iskeyword-=58
    endf

  " }}}2   HTML   {{{2

    fun! s:html_rc()
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
    endf

  " }}}2   Ruby   {{{2

    fun! s:ruby_rc()
      let b:tc_option = ''
      setlocal cindent
      setlocal iskeyword-=58

      " see |ft-ruby-omni|
      " let g:rubycomplete_buffer_loading = 1
      " let g:rubycomplete_classes_in_global = 1
      " let g:rubycomplete_rails = 1
      let ruby_operators = 1
      let ruby_space_errors = 1
      let ruby_no_expensive = 1
    endf

  " }}}2   PHP   {{{2

    fun! s:php_rc()
      let php_asp_tags = 1
      let php_parent_error_close = 1
      let php_parent_error_open = 1
      setlocal isk-=58 cindent
      set makeprg=php\ -l\ %
      set errorformat=%m\ in\ %f\ on\ line\ %l
    endf

  " }}}2   help   {{{2

    fun! s:help_rc()
      set number
      if version >= 703
        set conceallevel=1
        set concealcursor=nc
        set colorcolumn=+1
      endif
    endf

  " }}}2   Vim   {{{2

    fun! s:vim_rc()
      let b:tc_option = ''
      set path+=~/.vim/bundle
    endf

  " }}}2   zsh   {{{2

    fun! s:zsh_rc()
      let b:tc_option = ''
      setlocal iskeyword-=-
    endf

  " }}}2   git commit   {{{2

    fun! s:gitcommit_rc()
      setlocal textwidth=72
    endf

  " }}}2

" }}}1    Filetype 個別設定      =============================================

" AUTOCMD             {{{1 ===================================================

  augroup my_vimrc
    au!

    au FileType * :setlocal formatoptions=roql2

    " au BufNewFile,BufRead *.html set filetype=php
    au FileType php,xml,html inoremap <buffer> <LocalLeader>/ </<C-X><C-O>

    au FileType ruby :call s:ruby_rc()
    au FileType html :call s:html_rc()
    au FileType haml :call s:haml_rc()
    au FileType php :call s:php_rc()
    au FileType javascript :call s:js_rc()
    au FileType css :call s:css_rc()
    au FileType scss :call s:scss_rc()
    au FileType help :call s:help_rc()
    au FileType vim :call s:vim_rc()
    au FileType zsh :call s:zsh_rc()
    au FileType gitcommit :call s:gitcommit_rc()

    au FileType sh let g:is_bash=1

    au FileType vim setlocal tabstop=2 softtabstop=2 shiftwidth=2 foldmethod=marker
    au FileType rake,ruby,eruby,yaml setlocal tabstop=2 softtabstop=2 shiftwidth=2

    " au BufNewFile *.html  :0r ~/.vim/templates/html5.html
    au BufNewFile *.html  :0r ~/.vim/templates/html.html
    " au BufNewFile *.css  :0r ~/.vim/templates/style.css
    au BufNewFile *.css  :0r ~/.vim/templates/css.css
    au BufNewFile,BufRead /bootleq/notes/*.txt set modeline

    au BufRead www2.blogger.com*.txt setfiletype html
    au BufRead,BufNewFile /opt/nginx/conf/*.conf,/opt/nginx/conf/*.conf.default setfiletype nginx
    au BufRead /home/www/logs/*.log setfiletype httplog

    " let apache_version = "2.0"
    " let dosbatch_cmdextversion = 2

    au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
    au BufReadPost * if line("'\"") > 0 && line ("'\"") <= line("$") | exe "normal! g'\"" | endif
    au BufWinEnter * if exists('s:tabLineNeedRedraw') && s:tabLineNeedRedraw | redraw! | let s:tabLineNeedRedraw = 0 | endif
    au QuickFixCmdPost * :redraw!
    au QuickFixCmdPost * if len(getqflist()) > 0 | :QFix!<CR> | endif
    au FileType qf setlocal modifiable statusline=%q\ %1*%<%-.{exists('w:quickfix_title')\ ?\ w:quickfix_title\ :\ ''}%0*

    if has("gui_win32")
      au GUIEnter * simalt ~x
    else
      au GUIEnter * winpos 0 0 | redraw!
    endif

    au FileWritePost,BufWritePost *-\(debug\|src\).js :JsCompress! 1
    if has("autocmd") && exists("+omnifunc")
      autocmd Filetype *
      \ if &omnifunc == "" |
      \ setlocal omnifunc=syntaxcomplete#Complete |
      \ endif
    endif
  augroup END

  " http://vim.wikia.com/wiki/VimTip343?cb=4828
  let g:BigFile = 28*1024
  if ! exists("big_file_autocmd_loaded")
    let big_file_autocmd_loaded = 1
    augroup BigFile
      au BufReadPre *.log call BigFile(expand("<afile>"))
    augroup END
  endif

" }}}1    AUTOCMD             ================================================
