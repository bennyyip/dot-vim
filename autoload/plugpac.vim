vim9script
# Author:  Ben Yip (yebenmy@gmail.com)
# URL:     https://github.com/bennyyip/plugpac.vim
# Version: 2.4
#
# Copyright (c) 2025 Ben Yip
#
# MIT License
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following condition
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
# ---------------------------------------------------------------------

var repos = {}

var lazy_plugins = []
var cached_installed_plugins = {}

var minpac_init_opts = {}

var package_name = "minpac"
var quiet = v:false

const plugpac_plugin_conf_path = get(g:, 'plugpac_plugin_conf_path', '')

export def Begin(opts: dict<any> = {})
  repos = {}

  minpac_init_opts = opts

  package_name = get(opts, 'package_name', 'minpac')
  quiet = get(opts, 'quiet', v:false)

  if exists('#PlugPac')
    augroup PlugPac
      autocmd!
    augroup END
    augroup! PlugPac
  endif

  SetupCommands()
enddef


export def End()
  autocmd_add([{
    event: 'VimEnter',
    pattern: '*',
    group: 'PlugPac',
    once: true,
    cmd: "call DelayLoadAll()",
  }])
enddef

export def Add(repo: string, opts: dict<any> = {})
  const name = get(opts, 'name', substitute(repo, '^.*/', '', ''))
  opts['name'] = name
  const default_type = get(g:, 'plugpac_default_type', 'start')
  var type = get(opts, 'type', default_type)

  if type == 'delay'
    opts['type'] = 'opt'
  endif

  repos[repo] = opts

  if !HasPlugin(name)
    # timer_start(20, (_) => {
    if !quiet
      echow $'Missing plugin `{repo}`. Run :PackInstall to install it.'
    endif
    # })
    return
  endif

  if type == 'delay'
    lazy_plugins->add(name)
  else
    const pre_rc_path = GetRcPath(name, true)
    if filereadable(pre_rc_path)
      execute $'source {pre_rc_path}'
    endif
  endif
enddef

def DelayLoadAll()
  timer_start(0, (_) => {
    # load by Add() order
    for name in lazy_plugins
      const pre_rc_path = GetRcPath(name, true)
      if filereadable(pre_rc_path)
        execute $'source {pre_rc_path}'
      endif
      execute $"packadd {name}"

      const rc_path = GetRcPath(name, false)
      if filereadable(rc_path)
        execute $'source {rc_path}'
      endif
    endfor

    for [repo, opts] in items(repos)
      if opts['type'] != 'start'
        continue
      endif
      const rc_path = GetRcPath(opts['name'], false)
      if filereadable(rc_path)
        execute $'source {rc_path}'
      endif
    endfor

    if exists('#User#PlugpacPost')
      doauto <nomodeline> User PlugpacPost
    endif

    doautocmd VimEnter
  })
enddef

def GetRcPath(plugin: string, is_pre: bool = false): string
  if plugpac_plugin_conf_path != '' && HasPlugin(plugin)
    const prefix = is_pre ? 'pre-' : ''
    return expand(plugpac_plugin_conf_path .. '/' .. prefix .. substitute(plugin, '\.n\?vim$', '', '') .. '.vim')
  else
    return ''
  endif
enddef

export def HasPlugin(plugin: string): bool
  return has_key(GetInstalledPlugins(), plugin)
enddef

def Assoc(dict: dict<any>, key: string, val: any)
  dict[key] = add(get(dict, key, []), val)
enddef

def ToArray(v: any): list<string>
  return type(v) == v:t_list ? v : [v]
enddef

def Err(msg: any)
  echohl ErrorMsg
  echom '[plugpac] ' .. msg
  echohl None
enddef

def SetupCommands()
  command! -bar -nargs=+ Pack call Add(<args>)
  command! -bar PackInstall {
    Init()
    minpac#pluglist->copy()
      ->filter((k, v) => !isdirectory(v.dir .. '/.git'))
      ->keys()
      ->minpac#update()
  }
  command! -bar PackUpdate  call Init() | call minpac#update('', {'do': 'call minpac#status()'})
  command! -bar PackClean   call Init() | call minpac#clean()
  command! -bar PackStatus  call Init() | call minpac#status()
  command! -bar -nargs=1 -complete=customlist,StartPluginComplete PackDisable call DisableEnablePlugin(<q-args>, v:true)
  command! -bar -nargs=1 -complete=customlist,OptPluginComplete PackEnable call DisableEnablePlugin(<q-args>, v:false)
enddef

export def Init()
  packadd minpac

  minpac#init(minpac_init_opts)
  for [repo, opts] in items(repos)
    minpac#add(repo, opts)
  endfor

  cached_installed_plugins = {}
enddef

def DisableEnablePlugin(plugin: string, disable: bool)
  var src_ = 'opt'
  var dst = 'start'

  if disable
    src_ = 'start'
    dst = 'opt'
  endif

  const plugins = GetInstalledPlugins(src_)
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

def Matchfuzzy(l: list<string>, str: string): list<string>
  if str == ''
    return l
  else
    return matchfuzzy(l, str)
  endif
enddef

def StartPluginComplete(A: string, L: string, P: number): list<string>
  const plugins = GetInstalledPlugins('start')->keys()
  return plugins->Matchfuzzy(A)
enddef

def OptPluginComplete(A: string, L: string, P: number): list<string>
  const plugins = GetInstalledPlugins('opt')->keys()
  return plugins->Matchfuzzy(A)
enddef

def GetInstalledPlugins(type_: string = 'all'): dict<string>
  if has_key(cached_installed_plugins, type_)
    return cached_installed_plugins[type_]
  endif

  var t = type_
  if type_ == 'all'
    t = '*'
  endif

  const pat = $'pack/{package_name}/{t}/*'
  final plugin_paths = filter(globpath(&packpath, pat, 0, 1), (k, v) => isdirectory(v))
  final result = {}
  for p in plugin_paths
    result[substitute(p, '^.*[/\\]', '', '')] = p
  endfor

  cached_installed_plugins[type_] = result
  return result
enddef
