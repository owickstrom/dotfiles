" Vim compiler file
" Compiler:         RDL type checker for Ruby
" Maintainer:       Oskar Wickstrom <oskar.wickstrom@gmail.com>
" Latest Revision:  2018-03-02

if exists('current_compiler')
  finish
endif
let current_compiler = 'ruby-rdl'

let s:cpo_save = &cpoptions
set cpoptions-=C

if !exists('g:ruby_rdl_require')
  throw 'g:ruby_rdl_require must be set!'
endif

CompilerSet errorformat=
      \%-Gwarning:%.%#,
      \%-G%.%#from\ %.%#:in\ %.%#,
      \%-G%.%#~~~~%.%#,
      \%E%f:%l:%c:\ error:\ %m,
      \%-G%f:%l:in\ %.%#,
      \%-G%f:%l:\ %.%#,
      \%-Z%.%#

" CompilerSet makeprg=bundle\ exec\ ruby\ -r\ rubygems\ -r\ bundler/setup\ -r\ rdl\ -r\ empowerment\ -e\ \'RDL.do_typecheck\ :later\'

if exists('g:ruby_rdl_bundler_gem') && g:ruby_rdl_bundler_gem
  execute ("CompilerSet makeprg=bundle\\ exec\\ ruby\\ -r\\ rubygems\\ -r\\ bundler/setup\\ -r\\ rdl\\ -r\\ " . g:ruby_rdl_require . "\\ -e\\ \\'RDL.do_typecheck\\ :later\\'")
else
  execute ("CompilerSet makeprg=ruby\\ -r\\ rdl\\ -r\\ " . g:ruby_rdl_require . "\\ -e\\ \\'RDL.do_typecheck\\ :later\\'")
endif

let &cpoptions = s:cpo_save
unlet s:cpo_save
