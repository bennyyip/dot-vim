vim9script
# https://github.com/skeeto/illume

def IllumeAppend(channel: channel, msg: string)
    var buf = ch_getbufnr(channel, 'err')
    var lines = split(msg, '\n', true)

    for i in range(len(lines))
        var pos: any = getbufvar(buf, 'illume_pos', '$')

        var line = getbufline(buf, pos)[0]
        setbufline(buf, pos, line .. lines[i])

        if i < len(lines) - 1
            appendbufline(buf, pos, '')
            if type(pos) == v:t_number
                setbufvar(buf, 'illume_pos', pos + 1)
            endif
        endif
    endfor
enddef

def IllumeStop()
    if exists('b:illume_job') && job_status(b:illume_job) == 'run'
        try
            job_stop(b:illume_job)
        catch
            # Ignore errors if job already dead
        endtry
    endif
    b:illume_job = null_job
enddef

def IllumeStart()
    b:illume_job = job_start(['illume'], {
        in_io: 'buffer',
        in_buf: bufnr(),
        out_cb: IllumeAppend,
        out_mode: 'raw',
        err_io: 'buffer',
        err_buf: bufnr(),
    })
enddef

def Illume()
    IllumeStop()
    b:illume_pos = '$'
    IllumeStart()
enddef

def IllumeInfill()
    IllumeStop()
    b:illume_pos = line('.') + 1
    appendbufline('', line('.'), '!infill')
    IllumeStart()
    setline(line('.') + 1, '')
enddef

nnoremap <localleader>a <scriptcmd>Illume()<cr>
nnoremap <localleader>f <scriptcmd>IllumeInfill()<cr>
nnoremap <localleader>s <scriptcmd>IllumeStop()<cr>
nnoremap <localleader>u Go<cr>!user<cr><cr>
