vimrc_human
===========

My edited _.vimrc_ for sharing with human.

- Use comments, make it easy to understand. (not implemented yet...)
- Use [NeoBundle](https://github.com/Shougo/neobundle.vim) to manage plugins, for quick and clean trying out.
- May not update frequently, since it's not necessary my in-use config.

Notes
--
- Require Vim 7.3 or higher.
- Not for gVim on Windows. Though I'm using it fine with gVim and [Cygwin](http://www.cygwin.com/).
- Please keep in mind that:  
  let Vim source others' scripts this way sure has **SECURITY CONCERN**.

Usage
--
1. Clone this repository to your _/tmp_ path.

    `git clone git://github.com/bootleq/vimrc_human.git /tmp/vimrc_human/bootleq`

2. Update submodule (will install NeoBundle):

    ```
    cd /tmp/vimrc_human/bootleq
    git submodule init
    git submodule update
    ```

3. Start Vim with my vimrc.

    `vim -u /tmp/vimrc_human/bootleq/.vimrc`

4. There would be errors during first run. Install plugins can fix them:  
   Launch `vim` and run `:NeoBundleInstall`

Blog post
--
[分享我的 Vim 設定 - vimrc_human](http://bootleq.blogspot.com/2011/06/vim-vimrchuman.html)
