" Most of this file is a direct copy of @ChrisToomey's vimrc. His organization
" really spoke to me so I decided that imitation is the greatest form of
" flattery.

if !has('nvim')
  set nocompatible
endif

" Need to set the leader before defining any leader mappings
let mapleader = ';'
" In case I am using Scandinavian Keyboard (Breaks most cases anyways)
nmap ö ;

function! s:SourceConfigFilesIn(directory)
  let directory_splat = '~/.vim/' . a:directory . '/*'
  for config_file in split(glob(directory_splat), '\n')
    if filereadable(config_file)
      execute 'source' config_file
    endif
  endfor
endfunction

if !has('nvim')
  call plug#begin('~/.vim/bundle')
else
  call plug#begin('~/.local/share/nvim/plugged')
endif
call s:SourceConfigFilesIn('plugin_config')
call plug#end()

call glaive#Install()

call s:SourceConfigFilesIn('other_config')
