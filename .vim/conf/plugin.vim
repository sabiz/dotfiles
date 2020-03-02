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
    \'vim-c2view' : 'https://github.com/sabiz/vim-c2view.git'
    \}

let s:plugin_path=expand(g:vim_home_runtime_path.'/pack/plugin/start/')
let s:vim_home_runtime_conf_plugin_path = g:vim_home_runtime_conf_path.'/plugin'

function! UpdatePlugin()
    if !isdirectory(s:plugin_path)
        call mkdir(s:plugin_path, 'p')
    endif

    let pluginNames = keys(s:plugin_list)
    " Remove unused plugins
    let dirList = split(expand(s:plugin_path . '*'), '\n')
    for d in dirList
        if match(pluginNames, fnamemodify(d, ':t')) == -1
            call delete(expand(d), 'rf')
            echo 'Delete ' . fnamemodify(d, ':t')
        endif
    endfor

    for k in pluginNames
        let clonePath = s:plugin_path . k
        if !isdirectory(clonePath)
            call system('git ' . 'clone ' . s:plugin_list[k] . ' ' . clonePath)
            if v:shell_error == 0
                echo k . ' OK'
            else
                echo k . ' Error...'
                continue
            endif
        endif
    endfor
endfunction

function! LoadPlugin()
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


call UpdatePlugin()

call LoadPlugin()

