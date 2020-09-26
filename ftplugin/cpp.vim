" This is shit, does sync writing, locks up in files under <1000 lines
function FormatOnSaveCppDumb()
    if &modified && !empty(findfile('.clang-format', expand('%:p:h') . ';'))
        let cursor_pos = getpos('.')
        :%!clang-format
        call setpos('.', cursor_pos)
   endif
endfunction

function! FormatOnSaveCpp()
    let l:formatdiff = 1
    pyf ~/clang-format.py
endfunction
autocmd BufWritePre <buffer> call FormatOnSaveCpp()
