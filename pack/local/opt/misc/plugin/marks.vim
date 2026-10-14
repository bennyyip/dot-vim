vim9script

# show marks in `signcolumn'

def UpdateMarks(bufnr: number = bufnr())
    sign_unplace("marks", {buffer: bufnr})
    var local_marks = getmarklist(bufnr)->filter((_, v) => v.mark =~ '[[:alpha:]]')
    var global_marks = getmarklist()->filter((_, v) => v.mark =~ '[[:alpha:]]' && v.pos[0] == bufnr)
    var all_marks = local_marks->extend(global_marks)->filter((_, v) => v.mark != "'z")

    var signs = all_marks->map((_, v) => ({
        group: "marks",
        name: $"mark_{v.mark}",
        buffer: v.pos[0],
        lnum: v.pos[1]
    }))

    sign_placelist(signs)
enddef

def UpdateVisibleBuffersMarks(..._args: list<any>)
    var visible_buffers = getbufinfo({buflisted: 1, bufloaded: 1})
    visible_buffers->foreach((_, v) => {
        if !empty(v.windows)
            UpdateMarks(v.bufnr)
        endif
    })
enddef

augroup mark_signs
    au!
    au BufEnter,TextChanged * UpdateMarks()
    au CmdlineLeave :,/,? timer_start(0, UpdateVisibleBuffersMarks)
augroup END

for r in 'abcdefghijklmnopqrstuvwxyz'
    sign_define($"mark_'{r}", {text: $"{r}", culhl: "CursorLineNr", texthl: "Identifier"})
    exe $"nnoremap m{r} m{r}<scriptcmd>UpdateMarks()<CR>"
endfor
for r in 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
    sign_define($"mark_'{r}", {text: $"{r}", culhl: "CursorLineNr", texthl: "Identifier"})
    exe $"nnoremap m{r} m{r}<scriptcmd>UpdateVisibleBuffersMarks()<CR>"
endfor
