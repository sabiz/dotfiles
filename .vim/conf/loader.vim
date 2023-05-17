scriptencoding utf-8

if !executable('git')
  echo 'Cannot find [git]...'
  finish
endif

let s:update_plugin = 0
let s:plugin_path = expand(g:vim_home_runtime_path.'/pack/plugin/start/')
let s:vim_home_runtime_conf_plugin_path = expand(g:vim_home_runtime_conf_path.'/plugin')
let s:plugin_names = map(deepcopy(g:plugin_list), {idx, repo-> matchstr(repo, '.\+\/\zs\(\w\|-\)\+\ze')})

function! s:deleteUnUsedPlugin()
  let dirList = split(glob(s:plugin_path.'*'), '\n')
  for d in dirList
    if match(s:plugin_names, fnamemodify(d, ':t')) == -1
      call delete(expand(d), 'rf')
      call echoraw("\x1b[94mDelete:\t\x1b[0m".fnamemodify(d, ':t'))
    endif
  endfor
endfunction

function! s:installAndUpdatePlugin() abort
  let job_list = []
  let idx = 0
  for k in s:plugin_names
    let clonePath = s:plugin_path . k
    if !isdirectory(clonePath)
      let cmd = 'git ' . 'clone https://github.com/' . g:plugin_list[idx] . ' ' . clonePath
      call echoraw("\x1b[33mNew:\x1b[0m\t".k."\n")
    elseif s:update_plugin
      let cmd = 'git --git-dir='.clonePath.'/.git pull origin'
      call echoraw("\x1b[33mUpdate:\x1b[0m\t".k."\n")
    else
      let cmd = 'git'
    endif
    let job = job_start(cmd, #{in_io: 'null', out_io: 'null', err_io: 'null'})
    call add(job_list, #{name: k, job: job, pos:idx})
    let idx += 1
  endfor
  call echoraw("\x1b[s") " Save cursor pos

  " Wait jobs
  while empty(job_list) == 0
    function! s:checkJobStatus(idx, val)
      let st = job_status(a:val.job)
      if st == 'dead'
        let info = job_info(a:val.job)
        if info.cmd[0] == 'git' " ignore
          return 0
        endif
        let exitval = info.exitval
        call echoraw("\x1b[u\x1b[".a:val.pos."A") " Restore cursor pos & Move cursor
        if exitval == 0
          call echoraw("\x1b[34mSuccess:\x1b[0m\t".a:val.name."\n")
        else
          call echoraw("\x1b[31mFailed:\x1b[0m\t".a:val.name."\n")
          echon " "
        endif
      endif
      return st !=# 'dead'
    endfunction
    call filter(job_list, function("s:checkJobStatus"))
  endwhile

endfunction

function! s:loadPlugin()
  for k in s:plugin_names
    let pluginPath = expand(s:plugin_path.'/'.k)
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

function! s:loadImpl() abort
  call s:deleteUnUsedPlugin()

  call s:installAndUpdatePlugin()

  call s:loadPlugin()
endfunction

def! DeleteUnUsedPlugin()
  var dirList = split(glob(s:plugin_path .. "*"), "\n")
  for d in dirList
   if match(s:plugin_names, fnamemodify(d, ":t")) == -1
     delete(expand(d), "rf")
     echoraw("\x1b[94mDelete: " .. fnamemodify(d, ':t') .. "\x1b[0m")
     echoraw("\n")
   endif
  endfor
enddef

def! InstallAndUpdatePlugin()
  var job_list = []
  var idx = 0
  for k in s:plugin_names
    var clonePath = s:plugin_path .. k
    var cmd = ''
    if !isdirectory(clonePath)
      cmd = 'git ' .. 'clone https://github.com/' .. g:plugin_list[idx] .. ' ' .. clonePath
      echoraw("\x1b[33mNew: " .. k .. "\x1b[0m")
      echoraw("\n")
      sleep 200m
    elseif s:update_plugin
      cmd = 'git --git-dir=' .. clonePath .. '/.git pull origin'
      echoraw("\x1b[33mUpdate: " .. k ..  "\x1b[0m")
      echoraw("\n")
      sleep 200m
    else
      continue
    endif
    var job = job_start(cmd, {'in_io': 'null', 'out_io': 'null', 'err_io': 'null'})
    add(job_list, {'name': k, 'job': job, 'pos': idx})
    idx += 1
  endfor
  echoraw("\x1b[s") # Save cursor pos

  # Wait jobs
  while empty(job_list) == 0
    filter(job_list, (i, value) => {
      var st = job_status(value.job)
      if st == 'dead'
        var info = job_info(value.job)
        if info.cmd[0] == 'git' # ignore
          return false
        endif
        var exitval = info.exitval
        echoraw("\x1b[u\x1b[" .. value.pos .. "A") # Restore cursor pos & Move cursor
        if exitval == 0
          echoraw("\x1b[34mSuccess: " .. value.name .. "\x1b[0m")
          echoraw("\n")
        else
          echoraw("\x1b[31mFailed: " .. value.name .. "\x1b[0m")
          echoraw("\n")
          echon " "
        endif
      endif
      return st !=# 'dead'
    })
  endwhile
enddef

def! LoadPlugin()
  for k in s:plugin_names
    var pluginPath = expand(s:plugin_path .. '/' .. k)
    if !isdirectory(pluginPath)
      continue
    endif

    # Load plugin help
    var docPath = pluginPath .. '/doc'
    if isdirectory(docPath)
      execute('autocmd vimenter * helptags ' .. expand(docPath))
    endif

    # Load plugin config
    var confFilePath = s:vim_home_runtime_conf_plugin_path .. '/' .. k .. '.vim'
    if filereadable(confFilePath)
      execute('source ' .. confFilePath)
    endif
  endfor
enddef

def! LoadImpl()

  g:DeleteUnUsedPlugin()

  g:InstallAndUpdatePlugin()

  g:LoadPlugin()

enddef

function! s:load() abort
  if !isdirectory(s:plugin_path)
    call mkdir(s:plugin_path, 'p')
  endif

  if v:version >= 900
    call LoadImpl()
  else
    call s:loadImpl()
  endif

endfunction

call s:load()

" vim:ft=vim:fdm=marker:fmr={{{,}}}:ts=8:sw=2:sts=2:
