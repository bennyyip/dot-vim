vim9script
# ==============================================================================
# Run fzy asynchronously inside a Vim terminal-window
# File:         autoload/fzy.vim
# Author:       bfrg <https://github.com/bfrg>
# Website:      https://github.com/bfrg/vim-fzy
# Last Change:  Oct 21, 2022
# License:      Same as Vim itself (see :h license)
# ==============================================================================

const findcmd: list<string> =<< trim END
    find
      -name '.*'
      -a '!' -name .
      -a '!' -name .gitignore
      -a '!' -name .vim
      -a -prune
      -o '(' -type f -o -type l ')'
      -a -print 2> /dev/null
    | cut -b3-
END

def Error(msg: string)
    echohl ErrorMsg | echomsg msg | echohl None
enddef

def Tryexe(cmd: string)
    try
        execute cmd
    catch
        echohl ErrorMsg
        echomsg matchstr(v:exception, '^Vim\%((\a\+)\)\=:\zs.*')
        echohl None
    endtry
enddef

def Exit_cb(ctx: dict<any>, job: job, status: number)
    # Redraw screen in case a prompt like :tselect shows up after selecting an
    # item. If not redrawn, popup window remains visible
    if ctx.popupwin
        close
        redraw
    else
        const winnr: number = winnr()
        win_gotoid(ctx.winid)
        execute $':{winnr}close'
        redraw
    endif

    if filereadable(ctx.selectfile)
        try
            const content = readfile(ctx.selectfile)
            if content->len() < 2
                ctx.on_select_cb(content[0])
            else
                ctx.on_select_cb(content[1], content[0])
            endif

        catch /^Vim\%((\a\+)\)\=:E684/
        endtry
    endif

    delete(ctx.selectfile)
    if has_key(ctx, 'itemsfile')
        delete(ctx.itemsfile)
    endif
enddef

def Term_open(opts: dict<any>, ctx: dict<any>): number
    const cmd: list<string> = [&shell, &shellcmdflag, opts.shellcmd]

    var term_opts: dict<any> = {
        norestore: true,
        exit_cb: funcref(Exit_cb, [ctx]),
        term_name: 'fzy',
        term_rows: opts.rows
    }

    if has_key(opts, 'term_highlight')
        extend(term_opts, {term_highlight: opts.term_highlight})
    endif

    var bufnr: number
    if ctx.popupwin
        if !has_key(opts, 'term_highlight')
            extend(term_opts, {term_highlight: 'Pmenu'})
        endif

        bufnr = term_start(cmd, extend(term_opts, {
            hidden: true,
            term_finish: 'close'
        }))

        extend(opts.popup, {
            minwidth: &columns > 80 ? 80 : &columns - 4,
            padding: [0, 1, 0, 1],
            border: []
        }, 'keep')

        # Stop terminal job when popup window is closed with mouse
        popup_create(bufnr, deepcopy(opts.popup)->extend({
            minheight: opts.rows,
            callback: (_, i) => i == -2 ? bufnr->term_getjob()->job_stop() : 0
        }))
    else
        botright bufnr = term_start(cmd, term_opts)
        &l:number = false
        &l:relativenumber = false
        &l:winfixheight = true
        &l:bufhidden = 'wipe'
        &l:statusline = opts.statusline
    endif

    setbufvar(bufnr, '&filetype', 'fzy')
    return bufnr
enddef

def Opts(title: string, space: bool = false): dict<any>
    var opts: dict<any> = get(g:, 'fzy', {})->deepcopy()->extend({statusline: title})
    get(opts, 'popup', {})->extend({title: space ? ' ' .. title : title})
    return opts
enddef

export def Start(items: any, On_select_cb: func, options: dict<any> = {}): number
    if empty(items)
        Error('fzy-E10: No items passed')
        return 0
    endif

    var ctx: dict<any> = {
        winid: win_getid(),
        selectfile: tempname(),
        on_select_cb: On_select_cb,
        popupwin: get(options, 'popupwin') ? true : false
    }

    var opts: dict<any> = options->deepcopy()->extend({
        exe: exepath('fzf'),
        prompt: '> ',
        lines: 10,
        showinfo: 0,
        popup: {},
        statusline: 'fzy-term',
        _expect: ''
    }, 'keep')

    if !executable(opts.exe)
        Error($'fzy: executable "{opts.exe}" not found')
        return 0
    endif

    var lines: number = opts.lines < 3 ? 3 : opts.lines
    opts.rows = opts.showinfo ? lines + 2 : lines + 1

    var fzycmd: string = $"{opts.exe} --color={&bg}"
    fzycmd ..= $" --prompt={shellescape(opts.prompt)}"
    fzycmd ..= $" --info={opts.showinfo ? 'default' : 'hidden'}"
    if opts._expect != ''
        fzycmd ..= $" --expect={opts._expect}"
    endif
    if opts->has_key('extra_opts')
        fzycmd ..= $" {opts.extra_opts}"
    endif

    fzycmd ..= $" > {ctx.selectfile}"

    var fzybuf: number
    if type(items) ==  v:t_list
        ctx.itemsfile = tempname()

        # Automatically resize terminal window
        if len(items) < lines
            lines = len(items) < 3 ? 3 : len(items)
            opts.rows = get(opts, 'showinfo') ? lines + 2 : lines + 1
        endif

        opts.shellcmd = $'{fzycmd} < {ctx.itemsfile}'
        if !has('win32') && executable('mkfifo')
            system($'mkfifo {ctx.itemsfile}')
            fzybuf = Term_open(opts, ctx)
            writefile(items, ctx.itemsfile)
        else
            writefile(items, ctx.itemsfile)
            fzybuf = Term_open(opts, ctx)
        endif
    elseif type(items) == v:t_string
        opts.shellcmd = $'{items} | {fzycmd}'
        fzybuf = Term_open(opts, ctx)
    else
        Error('fzy-E11: Only list and string supported')
        return 0
    endif

    return fzybuf
enddef

export def Stop()
    if &buftype != 'terminal' || bufname() != 'fzy'
        Error('fzy-E12: Not a fzy terminal window')
        return
    endif
    bufnr()->term_getjob()->job_stop()
enddef

const open_file_actions = {
    'ctrl-t': 'tab split',
    'ctrl-x': 'split',
    'ctrl-v': 'vsplit',
}

export def OpenFile(items: list<string>, stl_text: string)
    const stl: string = $':edit ({stl_text})'
    var _opts = Opts(stl)
    _opts._expect = join(keys(open_file_actions), ',')
    _opts.extra_opts = _opts->get('extra_opts', '') .. ' --scheme=path'
    Start(items, funcref(Open_file_cb), _opts)
enddef

def Open_file_cb(choice: string, key: string = '')
    const fname: string = fnameescape(choice)
    const vim_cmd = open_file_actions->get(key, 'edit')
    Tryexe($'{vim_cmd} {fname}')
enddef

export def Find(dir: string)
    if !isdirectory(expand(dir, true))
        Error($'fzy-find: Directory "{expand(dir, true)}" does not exist')
        return
    endif

    const path: string = dir->expand(true)->fnamemodify(':~')->simplify()
    const cmd: string = printf('cd %s; %s',
        expand(path, true)->shellescape(),
        get(g:, 'fzy', {})->get('findcmd', join(findcmd))
    )
    const stl: string = $':edit [directory: {path}]'
    var _opts = Opts(stl)
    _opts._expect = join(keys(open_file_actions), ',')
    Start(cmd, funcref(Find_cb, [path]), _opts)
enddef

def Find_cb(dir: string, choice: string, key: string = '')
    var fpath: string = fnamemodify(dir, ':p:s?/$??') .. '/' .. choice
    fpath = fpath->resolve()->fnamemodify(':.')->fnameescape()
    const vim_cmd = open_file_actions->get(key, 'edit')
    Tryexe($'{vim_cmd} {fpath}')
enddef

export def Marks(bang: bool, ...args: list<string>)
    const output: list<string> = execute($'marks {args->join('')}')->split('\n')
    var _opts = Opts(output[0], true)
    _opts._expect = join(keys(open_file_actions), ',')
    Start(output[1 :], funcref(Marks_cb, [bang]), _opts)
enddef

def Marks_cb(bang: bool, item: string, key: string = '')
    const split_cmd = open_file_actions->get(key, '')
    if !empty(split_cmd)
        execute split_cmd
    endif
    const cmd: string = bang ? "g`" : "`"
    Tryexe($'normal! {cmd}{item[1]}')
enddef

export def Blines(arg: string)
    var cmd = ':keepj g/./'
    if arg != ''
        cmd = $':keepj g/{arg}/'
    endif
    try
        const save_view = winsaveview()
        const lazyredraw = &lazyredraw
        set lazyredraw
        var output: list<string> = execute(cmd)->split('\n')
        winrestview(save_view)
        &lazyredraw = lazyredraw

        var _opts = Opts(cmd)
        Start(output, funcref(Line_cb), _opts)
    catch
        echohl ErrorMsg
        echomsg matchstr(v:exception, '^Vim\%((\a\+)\)\=:\zs.*')
        echohl None
    endtry
enddef

def Line_cb(item: string)
    const lineno = item->split(' ')[0]->trim()
    Tryexe(':' .. lineno)
enddef

export def Buffers(bang: bool)
    const items: list<any> = range(1, bufnr('$'))
        ->filter(bang ? (_, i: number): bool => bufexists(i) : (_, i: number): bool => buflisted(i))
        ->mapnew((_, i: number): any => i->bufname()->empty() ? i : i->bufname()->fnamemodify(':~:.'))
    const str = $'{bang ? 'all' : 'listed'} buffers'
    OpenFile(items, str)
enddef

export def Oldfiles()
    const items: list<string> = v:oldfiles
        ->copy()
        ->filter((_, i: string): bool => i->fnamemodify(':p')->filereadable())
        ->map((_, i: string): string => fnamemodify(i, ':~:.'))
    OpenFile(items, 'oldfiles')
enddef

export def Arg(local: bool)
    const items: list<string> = local ? argv() : argv(-1, -1)
    const str: string = local ? 'local arglist' : 'global arglist'
    OpenFile(items, str)
enddef

const mod_actions = {
    'ctrl-t': 'tab',
    'ctrl-x': 'horizontal',
    'ctrl-v': 'vertical',
}

export def Help()
    const items: string = 'cut -f 1 ' .. findfile('doc/tags', &runtimepath, -1)->join()
    const stl: string = $':help (helptags)'
    var _opts = Opts(stl)
    _opts._expect = join(keys(mod_actions), ',')
    Start(items, funcref(Open_tag_cb, ['help', 'help']), _opts)
enddef

export def Tags()
    const items: any = executable('sed') && executable('cut') && executable('sort') && executable('uniq')
        ? printf("sed '/^!_TAG_/ d' %s | cut -f 1 | sort | uniq", tagfiles()->join())
        : taglist('.*')->mapnew((_, i: dict<any>): string => i.name)->sort()->uniq()
    const stl: string = printf(':tjump [%s]', tagfiles()->map((_, i: string): string => fnamemodify(i, ':~:.'))->join(', '))
    var _opts = Opts(stl)
    _opts._expect = join(keys(mod_actions), ',')
    # FIXME: menu is invisible when there is more than one match. (1<CR>)
    # Start(items, funcref(Open_tag_cb, ['tjump', 'stjump']), _opts)
    Start(items, funcref(Open_tag_cb, ['tag', 'stag']), _opts)
enddef

def Open_tag_cb(cmd: string, scmd: string, choice: string, key: string = '')
    var vim_cmd = cmd
    const mod = mod_actions->get(key, '')
    if mod != ''
        vim_cmd = $"{mod} {scmd}"
    endif
    Tryexe(vim_cmd .. ' ' .. escape(choice, '"'))
enddef

export def Grep(edit_cmd: string, args: string)
    const grep_cmd: string = get(g:, 'fzy', {})->get('grepcmd', &grepprg) .. ' ' .. args
    const grep_efm: string = get(g:, 'fzy', {})->get('grepformat', &grepformat)
    const stl: string = $':buffer ({grep_cmd})'
    var _opts = Opts(stl)
    _opts._expect = join(keys(mod_actions), ',')
    Start(grep_cmd, funcref(Grep_cb, [grep_efm]), _opts)
enddef

def Grep_cb(efm: string, choice: string, key: string = '')
    const items: list<any> = getqflist({lines: [choice], efm: efm})->get('items', [])
    if empty(items) || !items[0].bufnr
        Error('fzy: no valid item selected')
        return
    endif
    setbufvar(items[0].bufnr, '&buflisted', 1)

    var vim_cmd = 'buffer'
    const mod = mod_actions->get(key, '')
    if mod != ''
        vim_cmd = $"{mod} sbuffer"
    endif
    const cmd: string = $'{vim_cmd} {items[0].bufnr} | call cursor({items[0].lnum}, {items[0].col})'
    Tryexe(cmd)
enddef

# vim:sw=4:ts=4
