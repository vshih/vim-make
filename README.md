
Make.vim
========

Modestly enhanced `make` for Vim.

- Finds the closest parent directory of the current buffer with a Makefile and runs `make` with the passed arguments.


Options
-------

`g:Make_quickfix_always_open`

- 0 (default):  If the result is a single line, echo it.  Otherwise, output the result to the quickfix buffer.
- 1: Always use the quickfix buffer, even on no/minimal output.

`g:Make_loaded`

- A flag denoting that this script has run.


Command Usage
-------------

Trigger by executing

	:Make [typical_make_arguments]


Keyboard Shortcut Examples
--------------------------

Trigger `:Make` globally via F5 by adding this to your `.vimrc`:

	nnoremap <F5> :Make<CR>

Alternatively, register it to only certain file types under `.vim/ftplugin`:

	if exists('g:Make_loaded')
		map <buffer> <F5> :Make<CR>
		imap <buffer> <F5> <ESC>:Make<CR>
	endif

