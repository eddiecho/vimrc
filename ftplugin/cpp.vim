function FormatOnSaveCpp()
    if &modified && !empty(findfile('.clang-format', expand('%:p:h') . ';'))
        let cursor_pos = getpos('.')
        :%!clang-format
        call setpos('.', cursor_pos)
   endif
endfunction
" autocmd BufWritePre <buffer> call FormatOnSaveCpp()
