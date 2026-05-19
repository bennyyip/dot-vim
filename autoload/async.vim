vim9script

g:async_jobs = {}

export def Run(args: string, opts: dict<any>)
  Job.new(args, opts)
enddef

export def Compiler(bang: bool, compiler: string, ...args: list<string>)
  exe $"compiler {compiler}"

  Run(args->join(' '), {
    kind: 'make',
    jump: bang,
    wall: true,
  })
enddef

export def StopJobs(how: string='term')
  for id in g:async_jobs->keys()
    g:async_jobs[id].Kill(how)
    g:async_jobs->remove(id)
    echom $'kill job {id}'
  endfor
enddef

export def Spawn(...args: list<string>)
  job_start(args, {
    in_io: 'null',
    out_io: 'null',
    err_io: 'null',
    stoponexit: '',
  })
enddef

class Job
  var id: number

  var cmd: string
  var out: list<string>
  var err: list<string>
  var job: job

  var local: bool
  var winid: number  = -1

  var jump: bool
  var append: bool
  var wall: bool
  var expand: bool

  var kind: string # make | grep | echo | qf
  var efm: string
  var cwd: string

  var _qf: bool
  var _start_time: number

  static var _id_ = 0

  static final _default_opts = {
    kind: 'qf',
    jump: false,
    local: false,
    append: false,
    wall: false,
    expand: true,
  }

  def new(args: string, opts: dict<any> = {})
    this.out = []
    this.err = []

    this.local = opts->get('local', _default_opts['local'])
    if this.local
      # TODO
      # this.winid =
    endif
    this.jump = opts->get('jump', _default_opts['jump'])
    this.append = opts->get('append', _default_opts['append'])
    this.wall = opts->get('wall', _default_opts['wall'])
    this.expand = opts->get('expand', _default_opts['expand'])
    this.cwd = opts->get('cwd', getcwd())

    this.kind = opts->get('kind', _default_opts['kind'])
    if this.kind == 'grep'
      this.cmd = this.BuildCmd(&grepprg, args)
      this.efm = opts->get('efm', bufnr()->getbufvar('&gfm'))
    else
      if this.kind == 'make'
        this.cmd = this.BuildCmd(&makeprg, args)
      else
        this.cmd = this.BuildCmd('', args)
      endif
      this.efm = opts->get('efm', bufnr()->getbufvar('&efm'))
    endif

    if this.wall
      silent! wall
    endif

    this._qf = this.kind != 'echo'
    if this._qf
      this.QfStart()
    endif

    this._start_time = localtime()
    this.job = job_start([&shell, &shellcmdflag, this.cmd], {
      exit_cb: this.Exit_cb,

      in_io: 'null',
      out_cb: this.Out_cb,
      err_cb: this.Err_cb,

      out_mode: 'nl',
      err_mode: 'nl',

      cwd: this.cwd,
    })

    this.id = _id_
    g:async_jobs[_id_] = this
    _id_ += 1
  enddef

  def Kill(how: string='term')
    this.job->job_stop(how)
  enddef

  def QfStart()
    # TODO: global local
    const qfkind = this.kind == 'grep' ? 'grep' : 'make'
    exe $'silent doautocmd QuickFixCmdPre {qfkind}'
    noautocmd setqflist([], ' ', { title: this.cmd })
  enddef

  def QfEnd()
    if this.out->len() > 0
      this.QfAppend(this.out)
      this.out = []
    endif

    if this.err->len() > 0
      this.QfAppend(this.err)
      this.err = []
    endif

    const time_spent = localtime() - this._start_time
    if time_spent > 2
      this.QfAppend([
        $"[Finished in {time_spent} seconds]",
      ])
    endif

    # TODO: local append
    execute 'botright copen'
    # XXX: better way to handle cwd in qf window?
    execute $'lcd {this.cwd}'
    if this.jump
      execute 'cfirst'
    endif

    noautocmd setqflist([], 'r', {title: $"{this.cmd} [finished]"})

    const qfkind = this.kind == 'grep' ? 'grep' : 'make'
    exe $'silent doautocmd QuickFixCmdPost {qfkind}'
  enddef

  def BuildCmd(prg: string, args: string): string
    var ret = ''
    if prg  =~# '\$\*'
      ret = substitute(prg, '\$\*', args, 'g')
    elseif args == ''
      ret = prg
    else
      ret = $"{prg} {args}"
    endif

    if this.expand
      const flags = '<\=\%(:[p8~.htre]\|:g\=s\(.\).\{-\}\1.\{-\}\1\)*\%(:S\)\='
      const expandable = '\\*\%(<\w\+>\|%\|#\d*\)' .. flags
      ret = substitute(ret, expandable, '\=expand(submatch(0))', 'g')
    endif

    return ret->trim()
  enddef


  def Exit_cb(_: job, status: number)
    if !has_key(g:async_jobs, this.id)
      # canceled
      return
    endif

    if this.kind == 'grep'
      if status == 1 && this.err->empty()
        echo 'No results'
      elseif status != 0
        Error([$'Exit status: {status}', $'Command: {this.cmd}'] + this.out + this.err)
      endif
    elseif this.kind == 'echo'
      if status == 0
        Echo(this.out + this.err)
      else
        Error([$'Exit status: {status}', $'Command: {this.cmd}'] + this.out + this.err)
      endif
    endif

    if this._qf
      this.QfEnd()
    endif

    g:async_jobs->remove(this.id)
  enddef

  def Out_cb(ch: channel, line: string)
    this.out->add(line)
    if this._qf && this.out->len() > 128
      this.QfAppend(this.out)
      this.out = []
    endif
  enddef

  def Err_cb(ch: channel, line: string)
    this.err->add(line)
    if this._qf && this.err->len() > 128
      this.QfAppend(this.err)
      this.err = []
    endif
  enddef

  def QfAppend(lines: list<string>)
    noautocmd setqflist([], 'a', { efm: this.efm, lines: lines, })
  enddef
endclass

def Echo(msgs: list<string>, hl: string = "None")
  var cmd = [$"echohl {hl}"]
  cmd = cmd + msgs->map((_, x) => $"echom {string(x)}")
  cmd->add('echohl None')
  @z = cmd->join('|')
  feedkeys($":exe @z\n", 'n')
enddef

def Error(msgs: list<string>)
  Echo(msgs, "ErrorMsg")
enddef
