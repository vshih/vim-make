"=============================================================================
" File: vim-make.vim
" Author: Victor Shih <victor.shih@gmail.com>
" Last Change: 3/30/2011
" Version: 0.01
" WebPage: http://blog.vicshih.com/2011/03/fast-make-for-vim.html
" Description:
" Custom Make command:
" - if results are a single line, echo;
" - otherwise output to quickfix buffer
"
" Usage:
" Trigger via F5 by specifying:
"
"		if exists('g:make_loaded')
"			map <buffer> <F5> :Make<CR>
"			imap <buffer> <F5> <ESC>:Make<CR>
" 	endif
"
" in any desired ftplugin scripts.
"
" g:make_loaded is set when this script is run
"
function! Make(args)
	" Compile arguments
	let l:args = strlen(a:args) ? ' ' . a:args : ''
	let l:title = expand('%') . ' - Make' . l:args

	" Force write
	silent update!

	" Move to current directory
	lcd %:p:h

	" Make
	let l:out = split(system('make' . l:args), "\n")
	let l:len = len(l:out)

	" Output to quickfix
	cgetexpr l:out
	let w:quickfix_title = l:title

	" If no output, just report success
	if l:len == 0
		" Close quickfix
		cclose
		redraw
		echo l:title . ' succeeded'
	" If output is a single line, echo it
	elseif l:len == 1
		" Close quickfix
		cclose
		cc 1
		redraw
		echo l:out[0]
	else
		execute 'copen'
		cc 1
	endif
endfunction

command! -nargs=? Make call Make("<args>")

let g:make_loaded = 1

