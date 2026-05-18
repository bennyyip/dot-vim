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

    this.job = job_start([&shell, &shellcmdflag, this.cmd], {
      exit_cb: function(Exit_cb, [this]),
      out_cb: function(Out_cb, [this]),
      err_cb: function(Err_cb, [this]),

      in_io: 'null',

      cwd: this.cwd,
    })

    this.id = _id_
    g:async_jobs[_id_] = this
    _id_ += 1
  enddef

  def Kill(how: string='term')
    this.job->job_stop(how)
  enddef

  def OutToQF()
    const qfkind = this.kind == 'grep' ? 'grep' : 'make'
    exe $'silent doautocmd QuickFixCmdPre {qfkind}'

    # TODO: local append
    setqflist([], ' ', {
      efm: this.efm,
      lines: this.out + this.err,
      title: this.cmd
    })
    execute 'botright copen'
    if this.jump
      execute 'cfirst'
    endif

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

endclass

def StopJobs(how: string='term')
  for id in g:async_jobs->keys()
    g:async_jobs[id].Kill(how)
    g:async_jobs->remove(id)
    echom $'kill job {id}'
  endfor
enddef


def Err_cb(jo: Job, ch: channel, line: string)
  jo.err->add(line)
enddef

def Out_cb(jo: Job, ch: channel, line: string)
  jo.out->add(line)
enddef

def Exit_cb(jo: Job, _: job, status: number)
  if jo.kind == 'grep'
    if status == 0
      jo.OutToQF()
    elseif status == 1 && jo.err->empty()
      echo 'No results'
    else
      Error([$'Exit status: {status}', $'Command: {jo.cmd}'] + jo.out + jo.err)
    endif
  elseif jo.kind == 'echo'
    if status == 0
      Echo(jo.out + jo.err)
    else
      Error([$'Exit status: {status}', $'Command: {jo.cmd}'] + jo.out + jo.err)
    endif
  else
    jo.OutToQF()
  endif

  g:async_jobs->remove(jo.id)
enddef


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
