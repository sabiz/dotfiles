scriptencoding utf-8

if !executable('git')
  echo 'Cannot find [git]...'
  finish
endif

let s:plugin_path = expand(g:vim_home_runtime_path.'/pack/plugin/start/')
let s:conf_path = expand(g:vim_home_runtime_conf_path.'/plugin')
let s:plugins = map(deepcopy(g:plugin_list), {_, repo -> #{
      \ repo: repo,
      \ name: matchstr(repo, '.\+\/\zs\(\w\|-\)\+\ze'),
      \ }})
let s:plugin_names = map(deepcopy(s:plugins), {_, p -> p.name})

let s:pending_messages = []

function! s:report(message) abort
  if v:vim_did_enter
    echomsg a:message
  else
    call add(s:pending_messages, a:message)
  endif
endfunction

function! s:flushMessages() abort
  if !empty(s:pending_messages)
    echomsg join(s:pending_messages, ' / ')
  endif
  let s:pending_messages = []
endfunction

" Runs git jobs in parallel and reports the outcome on a single line.
function! s:runJobs(label, requests) abort
  let jobs = map(a:requests, {_, r -> #{
        \ name: r.name,
        \ job: job_start(r.cmd, #{in_io: 'null', out_io: 'null', err_io: 'null'}),
        \ }})
  let total = len(jobs)
  let failed = []
  while !empty(jobs)
    sleep 50m
    for item in filter(copy(jobs), {_, j -> job_status(j.job) !=# 'run'})
      if job_info(item.job).exitval != 0
        call add(failed, item.name)
      endif
    endfor
    call filter(jobs, {_, j -> job_status(j.job) ==# 'run'})
  endwhile
  call s:report(a:label.': '.(total - len(failed)).'/'.total.' ok'
        \ .(empty(failed) ? '' : ', failed: '.join(failed, ', ')))
endfunction

function! s:updateHelptags(names) abort
  for name in a:names
    let doc = s:plugin_path.name.'/doc'
    if isdirectory(doc)
      execute 'helptags' fnameescape(doc)
    endif
  endfor
endfunction

function! s:deleteUnusedPlugins() abort
  for d in glob(s:plugin_path.'*', 1, 1)
    let name = fnamemodify(d, ':t')
    if index(s:plugin_names, name) == -1
      call delete(d, 'rf')
      call s:report('Deleted: '.name)
    endif
  endfor
endfunction

function! s:installMissingPlugins() abort
  let missing = filter(deepcopy(s:plugins), {_, p -> !isdirectory(s:plugin_path.p.name)})
  if empty(missing)
    return
  endif
  call s:runJobs('Plugin install', map(deepcopy(missing), {_, p -> #{
        \ name: p.name,
        \ cmd: ['git', 'clone', 'https://github.com/'.p.repo, s:plugin_path.p.name],
        \ }}))
  call s:updateHelptags(map(missing, {_, p -> p.name}))
endfunction

function! s:updatePlugins() abort
  let installed = filter(copy(s:plugin_names), {_, n -> isdirectory(s:plugin_path.n)})
  call s:runJobs('Plugin update', map(copy(installed), {_, n -> #{
        \ name: n,
        \ cmd: ['git', '-C', s:plugin_path.n, 'pull', '--ff-only'],
        \ }}))
  call s:updateHelptags(installed)
endfunction

function! s:loadPluginConfigs() abort
  for name in s:plugin_names
    let conf = s:conf_path.'/'.name.'.vim'
    if isdirectory(s:plugin_path.name) && filereadable(conf)
      execute 'source' fnameescape(conf)
    endif
  endfor
endfunction

if !isdirectory(s:plugin_path)
  call mkdir(s:plugin_path, 'p')
endif
call s:deleteUnusedPlugins()
call s:installMissingPlugins()
call s:loadPluginConfigs()

augroup myPluginLoader
  autocmd!
  autocmd VimEnter * ++once call s:flushMessages()
augroup END

command! PluginUpdate call s:updatePlugins()

" vim:ft=vim:fdm=marker:fmr={{{,}}}:ts=8:sw=2:sts=2:
