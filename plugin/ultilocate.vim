" Name:         ultilocate
" Description:  利用locate(linux)/everything(windows)快速搜索电脑中所有文件
" Author:       加州旅客
" Email:        jiazhoulvke@gmail.com
" Blog:         http://www.jiazhoulvke.com
"--------------------------------------------------

if exists('g:ultilocate_loaded')
    finish
endif
let g:ultilocate_loaded=1

if !exists('g:ultilocate_locate_path')
    let g:ultilocate_locate_path='mlocate'
endif
if !exists('g:ultilocate_everything_path')
    let g:ultilocate_everything_path='es.exe'
endif
if !exists('g:ultilocate_new_window_mode')
    let g:ultilocate_new_window_mode='s'
endif
if !exists('g:ultilocate_window_height')
    let g:ultilocate_window_height='10'
endif
if !exists('g:UltiLocate_auto_close')
    let g:UltiLocate_auto_close=0
endif

let s:bname = '__UltiLocate_Search_Result__'

if has('win32') || has('win64')
    if !executable(g:ultilocate_everything_path)
        echo '无法运行everything,请先设置es.exe的路径'
        finish
    endif
else
    if !executable(g:ultilocate_locate_path)
        echo '无法运行locate,请先设置locate的路径'
    endif
endif

function! <SID>UltiLocate(ss)
    if has('win32') || has('win64')
        let cmd = g:ultilocate_everything_path . ' ' . a:ss
    else
        let cmd = g:ultilocate_locate_path . ' -i -b ' . a:ss
    endif
    let result = system(cmd)
    let winnum = bufwinnr(s:bname)
    if winnum != -1
        if winnr() != winnum
            exe winnum . 'wincmd w'
        endif
        setlocal modifiable
        silent! %delete _
    else
        let bufnum = bufnr(s:bname)
        if bufnum == -1
            let wcmd = s:bname
        else
            let wcmd = '+buffer' . bufnum
        endif
        exe 'silent! botright ' . g:ultilocate_window_height . 'split ' . wcmd
    endif
    setlocal buftype=nofile
    setlocal noswapfile
    setlocal nowrap
    setlocal nobuflisted
    setlocal winfixheight
    setlocal modifiable
    silent! %delete _
    silent! 0put = result
    silent! $delete _
    normal! gg
    setlocal nomodifiable
    call <SID>Key_Map()
endfunction

function! <SID>Key_Map()
    nmap <buffer> <C-e> :call <SID>Open_File('system')<CR>
    nmap <buffer> <CR> :call <SID>Open_File('curwindow')<CR>
    nmap <buffer> <C-CR> :call <SID>Open_File('newwindow')<CR>
    nmap <buffer> t :call <SID>Open_File('newtab')<CR>
    nmap <buffer> <ESC> :close<CR>
    nmap <buffer> q :close<CR>
endfunction

function! <SID>Open_File(mode)
    let orig_fname = getline('.')
    let s:esc_fname_chars = ' *?[{`$%#"|!<>();&'
    let fname=escape(orig_fname,s:esc_fname_chars)
    if fname == ''
        return
    endif
    if a:mode == 'curwindow'
        exec 'wincmd w'
        exec 'e ' . fname
        if g:UltiLocate_auto_close == 1
            exec 'wincmd w'
            exec 'close'
        endif
    elseif a:mode == 'newwindow'
        exec 'wincmd ' . g:ultilocate_new_window_mode
        exec 'e ' . fname
        if g:UltiLocate_auto_close == 1
            exec 'wincmd w'
            exec 'close'
        endif
    elseif a:mode == 'newtab'
        exec 'tabnew ' . fname
        exec 'tabprevious'
        exec 'close'
        exec 'tabnext'
    elseif a:mode == 'system'
        if has('win32') || has('win64')
            silent exe '!start explorer "' . iconv(fname,'utf-8','gb2312') . '"'
        else
            if executable('xdg-open')
                call system('xdg-open ' . fname)
            endif
        endif
    endif
endfunction

function! <SID>Toggle_Result_Window()
    let winnum = bufwinnr(s:bname)
    if winnum != -1
        if winnr() != winnum
            exe winnum . 'wincmd w'
            return
        else
            silent! close
            return
        endif
    endif
    let bufnum=bufnr(s:bname)
    if bufnum == -1
        let wcmd = s:bname
    else
        let wcmd = '+buffer' . bufnum
        exe 'silent! botright ' . '15' . 'split ' . wcmd
    endif
endfunction

" 如果安装了fuzzyfinder，则可以通过调用fuzzyfinder的api来显示搜索结果
function! <SID>FufUltiLocate(ss)
    if has('win32') || has('win64')
        call fuf#givenfile#launch('',0,'>',split(system(g:ultilocate_everything_path." ".a:ss),"\n"))
    else
        call fuf#givenfile#launch('',0,'>',split(system(g:ultilocate_locate_path." -i -b ".a:ss),"\n"))
    endif
endfunction

command! -nargs=1 UltiLocate call <SID>UltiLocate(<q-args>)
command! UltiLocateToggle call <SID>Toggle_Result_Window()
if exists('g:ultilocate_has_fuzzyfinder')
    command! -nargs=1 FufUltiLocate call <SID>FufUltiLocate(<q-args>)
endif

" vim: filetype=vim nowrap
