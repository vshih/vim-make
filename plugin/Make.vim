"=============================================================================
" File: Make.vim
" Author: Victor Shih <victor.shih@gmail.com>
" Last Change: 5/18/2014
" Version: 0.01
" WebPage: http://blog.vicshih.com/2011/03/fast-make-for-vim.html
" Description: Modestly enhanced `make` for Vim.
"

function! Make(args)
	" Compile arguments.
	let l:args = strlen(a:args) ? ' ' . a:args : ''
	let l:title = expand('%') . ' - Make' . l:args

	" Force write.
	silent update!

	" Find the closest directory to the current file with a [Mm]akefile.
	let l:makefile_dir = s:find_makefile_dir()

	" Move to that directory and make.
	let l:out = split(system('cd ' . l:makefile_dir . ' && make' . l:args), "\n")
	let l:len = len(l:out)

	" Output to quickfix.
	cgetexpr l:out
	let w:quickfix_title = l:title

	" If no output, just report success.
	if l:len == 0
		" Close quickfix.
		cclose
		redraw
		echo l:title . ' succeeded'
	" If output is a single line, echo it.
	elseif l:len == 1
		" Close quickfix.
		cclose
		cc 1
		redraw
		echo l:out[0]
	else
		execute 'copen'
		cc 1
	endif
endfunction


function s:find_makefile_dir()
	let l:dir = expand('%:p:h')

	while 1
		" Ensure we have only one '/'.
		if !empty(glob(substitute(l:dir, '/$', '', '') . '/[Mm]akefile'))
			return l:dir
		else
			let l:parent = fnamemodify(l:dir, ':h')
			if l:parent ==# l:dir
				" We reached the root but didn't find a Makefile.
				return '.'
			endif

			let l:dir = l:parent
		endif
	endwhile
endfunction


" Register command.
command! -nargs=? Make call Make("<args>")

let g:Make_loaded = 1

