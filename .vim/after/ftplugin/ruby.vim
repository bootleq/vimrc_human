if exists('*RailsRoot')
  " Add back `RailsRoot` to path, which is removed by vim-ruby ftplugin
  execute "setlocal path+=" . RailsRoot()

  if !empty(rails#app())
    for dir in ['models', 'services']
      let app_dir = rails#app().path('app/' . dir)
      if isdirectory(app_dir)
        execute "setlocal path+=" . app_dir
      endif
    endfor
  endif
endif
