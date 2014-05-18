
Make.vim
========

Modestly enhanced `make` for Vim.

- Finds the closest parent directory of the current buffer with a Makefile and runs `make` with the passed arguments.
- If the result is a single line, echo it.
- Otherwise, output the result to the quickfix buffer.

`g:Make_loaded` is set when this script is run.


Command Usage
-------------

Trigger by executing

	:Make [typical_make_arguments]


Keyboard Shortcut Examples
--------------------------

Trigger `:Make` globally via F5 by adding this to your .vimrc:
	nnoremap <F5> :Make<CR>

Alternatively, register it to only certain file types under .vim/ftplugin:

	if exists('g:Make_loaded')
		map <buffer> <F5> :Make<CR>
		imap <buffer> <F5> <ESC>:Make<CR>
	endif

