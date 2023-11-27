let s:start		= '/*'
let s:end		= '*/'
let s:fill		= '*'
let s:length	= 80
let s:margin	= 5

let s:types		= {
			\'\.c$\|\.h$\|\.cc$\|\.hh$\|\.cpp$\|\.hpp$\|\.php':
			\['/*', '*/', '*'],
			\'\.htm$\|\.html$\|\.xml$':
			\['<!--', '-->', '*'],
			\'\.js$':
			\['//', '//', '*'],
			\'\.tex$':
			\['%', '%', '*'],
			\'\.ml$\|\.mli$\|\.mll$\|\.mly$':
			\['(*', '*)', '*'],
			\'\.vim$\|\vimrc$':
			\['"', '"', '*'],
			\'\.el$\|\emacs$':
			\[';', ';', '*'],
			\'\.f90$\|\.f95$\|\.f03$\|\.f$\|\.for$':
			\['!', '!', '/']
			\}

function! s:filetype()
	let l:f = s:filename()

	let s:start	= '#'
	let s:end	= '#'
	let s:fill	= '*'

	for type in keys(s:types)
		if l:f =~ type
			let s:start	= s:types[type][0]
			let s:end	= s:types[type][1]
			let s:fill	= s:types[type][2]
		endif
	endfor

endfunction

function! s:textline(left, right)
	let l:left = strpart(a:left, 0, s:length - s:margin * 2 - strlen(a:right))

	return s:start . repeat(' ', s:margin - strlen(s:start)) . l:left . repeat(' ', s:length - s:margin * 2 - strlen(l:left) - strlen(a:right)) . a:right . repeat(' ', s:margin - strlen(s:end)) . s:end
endfunction

function! s:line(n)
	if a:n == 1 || a:n == 11 " top and bottom line
		return s:start . ' ' . repeat(s:fill, s:length - strlen(s:start) - strlen(s:end) - 2) . ' ' . s:end
	elseif a:n == 2 || a:n == 3 || a:n == 10 " empty
		return s:textline('', '')
	elseif a:n == 4 " filename
		return s:textline("Filename: " . s:filename(), '')
	elseif a:n == 5 " author
		return s:textline("Author:   " . s:user() . " <" . s:mail() . ">", '')
	elseif a:n == 6 " github
		return s:textline("github:   " . s:github(), '')
	elseif a:n == 7 " licence
		return s:textline("Licence:  " . s:licence(), '')
	elseif a:n == 8 " created
		return s:textline("Created:  " . s:date(), '')
	elseif a:n == 9 " updated
		return s:textline("Updated:  " . s:date(), '')
	elseif a:n == 12 || a:n == 21 " newline
		return ""
	elseif a:n == 13 " semi
		return ";"
	elseif a:n == 14 " pragma
		return "#pragma GCC diagnostic push"
	elseif a:n == 15 " pragma
		return "#pragma GCC diagnostic ignored \"-Wpragmas\""
	elseif a:n == 16 " pragma
		return "#pragma GCC diagnostic warning \"-Weverything\""
	elseif a:n == 17 " pragma
		return "#pragma GCC diagnostic ignored \"-Wempty-translation-unit\""
	elseif a:n == 18 " pragma
		return "#pragma GCC diagnostic ignored \"-Wunused-macros\""
	elseif a:n == 19 " pragma
		return "#pragma GCC diagnostic ignored \"-Wextra-semi\""
	elseif a:n == 20 " pragma
		return ";"
	elseif a:n == 22 " pragma
		return "#pragma GCC diagnostic pop"
	endif
endfunction

function! s:licence()
	return "GPLv3"
endfunction

function! s:github()
	return "https://github.com/priezu-m"
endfunction

function! s:user()
	return "Peru Riezu"
endfunction

function! s:mail()
	return "riezumunozperu@gmail.com"
endfunction

function! s:filename()
	let l:filename = expand("%:t")
	if strlen(l:filename) == 0
		let l:filename = "< new >"
	endif
	return l:filename
endfunction

function! s:date()
	return strftime("%Y/%m/%d %H:%M:%S")
endfunction

function! s:insert()
	let l:line = 22

	" empty line after header
	"call append(0, "")

	" loop over lines
	while l:line > 0
		call append(0, s:line(l:line))
		let l:line = l:line - 1
	endwhile
endfunction

function! s:update()
	call s:filetype()
	if getline(9) =~ s:start . repeat(' ', s:margin - strlen(s:start)) . "Updated: "
		if &mod
			call setline(9, s:line(9))
		endif
		call setline(4, s:line(4))
		return 0
	endif
	return 1
endfunction

function! s:stdheader()
	if s:update()
		call s:insert()
		:d
	endif
endfunction

" Bind command and shortcut
command! Stdheader call s:stdheader ()
map <F1> :Stdheader<CR>
autocmd BufWritePre * call s:update ()
