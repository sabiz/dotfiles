scriptencoding utf-8

if !executable('git')
    echo 'Cannot find [git]...'
    finish
endif

let s:plugin_list = {
    \'ack' : 'https://github.com/mileszs/ack.vim.git',
    \'async' : 'https://github.com/prabirshrestha/async.vim.git',
    \'asyncomplete-file' : 'https://github.com/prabirshrestha/asyncomplete-file.vim',
    \'asyncomplete-lsp' : 'https://github.com/prabirshrestha/asyncomplete-lsp.vim.git',
    \'asyncomplete' : 'https://github.com/prabirshrestha/asyncomplete.vim.git',
    \'editorconfig-vim' : 'https://github.com/editorconfig/editorconfig-vim.git',
    \'lightline' : 'https://github.com/itchyny/lightline.vim.git',
    \'molokai' : 'https://github.com/tomasr/molokai.git',
    \'rainbow_csv' : 'https://github.com/mechatroner/rainbow_csv.git',
    \'skyline-color' : 'https://github.com/sabiz/skyline-color.vim.git',
    \'tagbar' : 'https://github.com/majutsushi/tagbar',
    \'tcomment_vim' : 'https://github.com/tomtom/tcomment_vim.git',
    \'vaffle' : 'https://github.com/cocopon/vaffle.vim.git',
    \'vim-autoclose' : 'https://github.com/Townk/vim-autoclose.git',
    \'vim-buftabline' : 'https://github.com/ap/vim-buftabline.git',
    \'vim-gitgutter' : 'https://github.com/airblade/vim-gitgutter.git',
    \'vim-indent-guides' : 'https://github.com/sabiz/vim-indent-guides.git',
    \'vim-lsp' : 'https://github.com/prabirshrestha/vim-lsp.git',
    \'vim-quickhl' : 'https://github.com/t9md/vim-quickhl.git',
    \'vim-auto-cursorline' : 'https://github.com/delphinus/vim-auto-cursorline',
    \'vim-svelte' : 'https://github.com/burner/vim-svelte.git',
    \'vim-c2view' : 'https://github.com/sabiz/vim-c2view.git',
    \'vim-themis' : 'https://github.com/thinca/vim-themis'
    \}

let s:plugin_path=expand(g:vim_home_runtime_path.'/pack/plugin/start/')
let s:vim_home_runtime_conf_plugin_path = g:vim_home_runtime_conf_path.'/plugin'

function! s:echoMessage(msg)
    call echoraw("\x1b[2K".a:msg)
endfunction

function! s:clearScreen()
    call echoraw("\x1b[2J")
endfunction

function! s:cursorMove(r,c)
    call echoraw("\x1b[".a:r.";".a:c."H")
endfunction


function! s:updatePlugin()

    if !isdirectory(s:plugin_path)
        call mkdir(s:plugin_path, 'p')
    endif

    let pluginNames = keys(s:plugin_list)
    " Remove unused plugins
    let dirList = split(expand(s:plugin_path . '*'), '\n')
    call s:clearScreen()
    call s:cursorMove(0, 0)
    let cursorRow=0
    if len(dirList) > 2
        for d in dirList
            if match(pluginNames, fnamemodify(d, ':t')) == -1
                call delete(expand(d), 'rf')
                call s:echoMessage("\x1b[35mDelete:\x1b[0m\t".fnamemodify(d, ':t')."\n")
                let cursorRow+=1
            endif
        endfor
    endif

    let job_list = []
    for k in pluginNames
        let clonePath = s:plugin_path . k
        if !isdirectory(clonePath)
            let cursorRow+=1
            let cmd = 'git ' . 'clone ' . s:plugin_list[k] . ' ' . clonePath
            call s:echoMessage("\x1b[33mNew:\x1b[0m\t".k."\n")
            let job = job_start(cmd, #{in_io: 'null', out_io: 'null', err_io: 'null'})
            call add(job_list, #{name: k, job: job, pos:cursorRow})
        endif
    endfor
    while empty(job_list) == 0
        function! s:checkJobStatus(idx, val)
            let st = job_status(a:val.job)
            if st == 'dead'
                let exitval = job_info(a:val.job).exitval
                call s:cursorMove(a:val.pos, 0)
                if exitval == 0
                    call s:echoMessage("\x1b[34mSuccess:\x1b[0m\t".a:val.name."\n")
                else
                    call s:echoMessage("\x1b[31mFailed:\x1b[0m\t".a:val.name."\n")
                    echon " "
                endif
            endif
            return st !=# 'dead'
        endfunction
        call filter(job_list, function("s:checkJobStatus"))
    endwhile
    call s:cursorMove(cursorRow, 0)
endfunction

function! s:loadPlugin()
    let pluginNames = keys(s:plugin_list)
    for k in pluginNames
        let pluginPath = s:plugin_path.k
        if !isdirectory(pluginPath)
            continue
        endif
        " Load plugin help
        let docPath = pluginPath.'/doc'
        if isdirectory(docPath)
            execute('autocmd vimenter * helptags '.expand(docPath))
        endif

        " Load plugin config
        let confFilePath = s:vim_home_runtime_conf_plugin_path.'/'.k.'.vim'
        if filereadable(confFilePath)
            execute('source '.confFilePath)
        endif
    endfor
endfunction

call s:updatePlugin()

call s:loadPlugin()

