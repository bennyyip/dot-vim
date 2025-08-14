vim9script
import autoload "./utils.vim" as Utils

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

export def PackUnusedRC(): list<string>
  plugpac#Init()
  const rcs = minpac#getpluglist()->keys()->mapnew((_, k) => [RcPath(k), RcPath(k, 'pre-')])->flattennew()
  return globpath(g:plugpac_plugin_conf_path, "*", 0, 1)->filter((_, x) => rcs->index(x) == -1)
enddef

