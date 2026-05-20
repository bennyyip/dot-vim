vim9script

g:async_jobs = {}

var async_last_job = {}
var qf_running = false

export def Run(args: string, opts: dict<any>)
  Job.new(args, opts)
enddef

export def ReRun(terminal: bool = false)
  Job.new(async_last_job['args'], async_last_job['opts']->extendnew({terminal: terminal}))
enddef

export def Compiler(bang: bool, local: bool, compiler: string, ...args: list<string>)
  exe $"compiler {compiler}"

  Run(args->join(' '), {
    kind: 'make',
    local: local,
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
  qf_running = false
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
  # opts begin
  var local: bool = false
  var jump: bool = false
  var append: bool = false
  var wall: bool = false
  var expand: bool = false
  var terminal: bool = false # :Term
  var kind: string = 'qf' # make | grep | echo | qf
  var efm: string # &efm
  var cwd: string # getcwd()
  # opts end

  var id: number
  var cmd: string

  var out: list<string>
  var err: list<string>
  var job: job

  var qf: bool
  var start_time: number
  var setqflist: func

  static var _id_ = 0

  def new(args: string, opts: dict<any> = {})
    async_last_job = {
      args: args,
      opts: opts,
    }

    this.out = []
    this.err = []

    this.local = opts->get('local', this.local)
    this.jump = opts->get('jump', this.jump)
    this.append = opts->get('append', this.append)
    this.wall = opts->get('wall', this.wall)
    this.expand = opts->get('expand', this.expand)
    this.terminal = opts->get('terminal', this.terminal)
    this.cwd = opts->get('cwd', getcwd())

    this.kind = opts->get('kind', this.kind)
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

    if this.terminal
      execute $':Term {this.cmd}'
    endif

    if this.local
      this.setqflist = function('setloclist', [0])
    else
      this.setqflist = function('setqflist')
    endif

    this.qf = this.kind != 'echo'
    if this.qf
      if qf_running
        Error(["Another quickfix task is running."])
        return
      endif
      this.QfStart()
      qf_running = true
    endif

    this.start_time = localtime()
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
    const qfkind = this.kind == 'grep' ? 'grep' : 'make'
    exe $'silent doautocmd QuickFixCmdPre {qfkind}'
    noautocmd this.setqflist([], ' ', { title: this.cmd })
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

    const time_spent = localtime() - this.start_time
    if time_spent > 2
      this.QfAppend([
        $"[Finished in {time_spent} seconds]",
      ])
    endif

    # TODO: append
    const cl = this.local ? 'l' : 'c'
    execute $'botright {cl}open'
    # XXX: better way to handle cwd in qf window?
    silent! execute $'lcd {this.cwd}'
    if this.jump
      execute $'{cl}first'
    endif

    noautocmd this.setqflist([], 'r', {title: $"{this.cmd} [finished]"})

    const qfkind = this.kind == 'grep' ? 'grep' : 'make'
    exe $'silent doautocmd QuickFixCmdPost {qfkind}'

    qf_running = false
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

    if this.qf
      this.QfEnd()
    endif

    g:async_jobs->remove(this.id)
  enddef

  def Out_cb(ch: channel, line: string)
    this.out->add(line)
    if this.qf && this.out->len() > 128
      this.QfAppend(this.out)
      this.out = []
    endif
  enddef

  def Err_cb(ch: channel, line: string)
    this.err->add(line)
    if this.qf && this.err->len() > 128
      this.QfAppend(this.err)
      this.err = []
    endif
  enddef

  def QfAppend(lines: list<string>)
    noautocmd this.setqflist([], 'a', { efm: this.efm, lines: lines, })
  enddef
endclass

def Echo(msgs: list<string>, hl: string = "None")
  if msgs->empty()
    return
  endif
  const cmd = [$"echohl {hl}"] +
    msgs->map((_, x) => $"echom {string(x)}") +
    ['echohl None']
  @z = cmd->join('|')
  feedkeys($":exe @z\n", 'n')
enddef

def Error(msgs: list<string>)
  Echo(msgs, "ErrorMsg")
enddef

export def MakeComplete(_, _, _): string
    if &shell != 'sh' || &makeprg !~# '^make'
        return ""
    endif
    return system("make -npq : 2> /dev/null | awk -v RS= -F: '$1 ~ /^[^#%.]+$/ { print $1 }' | sort -u")
enddef
