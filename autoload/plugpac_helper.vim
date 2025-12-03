vim9script
import autoload "./utils.vim" as Utils
import autoload "./plugpac.vim"

export def PackList(A: string, ...args: list<any>): list<string>
  plugpac#Init()
  const pluglist = minpac#getpluglist()->keys()->sort()
  return pluglist->Utils.Matchfuzzy(A)
enddef

export def PackSummary()
  plugpac#Init()
  const pluglist = minpac#getpluglist()
  const start_cnt = pluglist->mapnew((k, v) => v['type'])->count('start')
  const opt_cnt = pluglist->mapnew((k, v) => v['type'])->count('opt')

  echom $'{pluglist->len()} packages installed. {start_cnt} start, {opt_cnt} opt.'
enddef

export def PackUrl(pack: string)
  plugpac#Init()
  const url = minpac#getpluginfo(pack).url
  os#Open(url)
enddef

export def PackDir(pack: string)
  plugpac#Init()
  execute 'edit ' .. minpac#getpluginfo(pack).dir
enddef

export def PackRc(pack: string)
  call plugpac#Init()
  execute 'edit ' .. RcPath(minpac#getpluginfo(pack).name)
enddef

export def PackRcPre(pack: string)
  call plugpac#Init()
  execute 'edit ' .. RcPath(minpac#getpluginfo(pack).name, 'pre-')
enddef

def RcPath(name: string, prefix: string = ''): string
  return $"{g:plugpac_plugin_conf_path}/{prefix}{substitute(name, '\.n\?vim$', '', '')}.vim"->expand()
enddef


export def PackUnusedRC(only_minpac: bool = false): list<string>
  plugpac#Init()
  var rcs = []
  if only_minpac
    rcs = minpac#getpluglist()->keys()->mapnew((_, k) => [RcPath(k), RcPath(k, 'pre-')])->flattennew()
  else
    const pat = $'pack/*/*/*'
    final plugin_paths = filter(globpath(&packpath, pat, 0, 1), (k, v) => isdirectory(v))
    final result = {}
    for p in plugin_paths
      const k = substitute(p, '^.*[/\\]', '', '')
      rcs->add(RcPath(k))
      rcs->add(RcPath(k, 'pre-'))
    endfor
  endif
  return globpath(g:plugpac_plugin_conf_path, "*", 0, 1)->filter((_, x) => rcs->index(x) == -1)
enddef

export def StartPluginComplete(A: string, L: string, P: number): list<string>
  const plugins = plugpac#GetInstalledPlugins('start')->keys()
  return plugins->Utils.Matchfuzzy(A)
enddef

export def OptPluginComplete(A: string, L: string, P: number): list<string>
  const plugins = plugpac#GetInstalledPlugins('opt')->keys()
  return plugins->Utils.Matchfuzzy(A)
enddef

export def DisableEnablePlugin(plugin: string, disable: bool)
  var src_ = 'opt'
  var dst = 'start'

  if disable
    src_ = 'start'
    dst = 'opt'
  endif

  const plugins = plugpac#GetInstalledPlugins(src_)
  if !has_key(plugins, plugin)
    Err(plugin .. ' does not exists.')
    return
  endif

  const plugin_dir = plugins[plugin]

  const dst_dir = substitute(plugin_dir, '[/\\]' .. src_ .. '[/\\]\ze[^/]\+$', '/' .. dst .. '/', '')
  if isdirectory(dst_dir)
    Err(dst_dir .. 'exists.')
    return
  endif
  rename(plugin_dir, dst_dir)
enddef

def Err(msg: any)
  echohl ErrorMsg
  echom '[plugpac] ' .. msg
  echohl None
enddef

export def SetupCommands()
  command! PackSummary PackSummary()
  command! -nargs=1 -complete=customlist,PackList PackUrl   PackUrl(<q-args>)
  command! -nargs=1 -complete=customlist,PackList PackDir   PackDir(<q-args>)
  command! -nargs=1 -complete=customlist,PackList PackRc    PackRc(<q-args>)
  command! -nargs=1 -complete=customlist,PackList PackRcPre PackRcPre(<q-args>)
  command! -bang PackUnusedRC cexpr PackUnusedRC(<q-bang> == '!')->map((_, x) => $"{x}:1:1: Unused")<BAR>copen
  command! -bar -nargs=1 -complete=customlist,StartPluginComplete PackOpt call DisableEnablePlugin(<q-args>, true)
  command! -bar -nargs=1 -complete=customlist,OptPluginComplete PackStart call DisableEnablePlugin(<q-args>, false)
enddef
