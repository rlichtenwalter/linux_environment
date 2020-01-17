set encoding=utf-8
set nonumber
set nocompatible
set autoindent
set smartindent
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
set backspace=eol,start,indent
set noexpandtab
set showmatch
set ruler
set nowrap
set incsearch
set hlsearch
set synmaxcol=8192

" don't automatically add problematic linebreaks at the end of PHP files
autocmd FileType php setlocal noeol binary

if has('syntax') && (&t_Co > 2)
	syntax on
endif

syntax match NonASCII "[^\x00-\x7F]"

set background=dark
highlight clear
if exists("syntax_on")
    syntax reset
endif

highlight	Normal			guifg=white			guibg=black								ctermfg=white		ctermbg=black
highlight	ErrorMsg		guifg=white			guibg=#287eff							ctermfg=white		ctermbg=lightblue
highlight	Visual			guifg=#8080ff		guibg=fg		gui=reverse				ctermfg=lightblue	ctermbg=fg			cterm=reverse
highlight	VisualNOS		guifg=#8080ff		guibg=fg		gui=reverse,underline	ctermfg=lightblue	ctermbg=fg			cterm=reverse,underline
highlight	Todo			guifg=#d14a14		guibg=#1248d1							ctermfg=red			ctermbg=darkblue
highlight	Search			guifg=#20ffff		guibg=#2050d0							ctermfg=white		ctermbg=darkblue	cterm=underline				term=underline
highlight	IncSearch		guifg=#b0ffff		guibg=#2050d0							ctermfg=darkblue	ctermbg=gray
highlight	SpecialKey		guifg=darkcyan												ctermfg=darkcyan
highlight	Directory		guifg=cyan													ctermfg=cyan
highlight	Title			guifg=magenta						gui=bold				ctermfg=magenta							cterm=bold
highlight	WarningMsg		guifg=red													ctermfg=red
highlight	WildMenu		guifg=yellow		guibg=black								ctermfg=yellow		ctermbg=black		cterm=none					term=none
highlight	ModeMsg			guifg=#22cce2												ctermfg=lightblue
highlight	MoreMsg			ctermfg=darkgreen											ctermfg=darkgreen
highlight	Question		guifg=green							gui=none				ctermfg=green							cterm=none
highlight	NonText			guifg=#0030ff												ctermfg=darkblue
highlight	StatusLine		guifg=blue			guibg=darkgray	gui=none				ctermfg=blue		ctermbg=gray		cterm=none					term=none
highlight	StatusLineNC	guifg=black			guibg=darkgray	gui=none				ctermfg=black		ctermbg=gray		cterm=none					term=none
highlight	VertSplit		guifg=black			guibg=darkgray	gui=none				ctermfg=black		ctermbg=gray		cterm=none					term=none
highlight	Folded			guifg=#808080		guibg=black								ctermfg=darkgrey	ctermbg=black		cterm=bold					term=bold
highlight	FoldColumn		guifg=#808080		guibg=black								ctermfg=darkgrey	ctermbg=black		cterm=bold					term=bold
highlight	LineNr			guifg=white													ctermfg=green							cterm=none
highlight	DiffAdd			guibg=darkblue												ctermbg=darkblue						cterm=none					term=none
highlight	DiffChange		guibg=darkmagenta											ctermbg=magenta							cterm=none
highlight	DiffDelete		guifg=Blue			guibg=DarkCyan	gui=bold				ctermbg=cyan		ctermfg=blue
highlight	DiffText		guibg=Red							gui=bold				ctermbg=red			cterm=bold
highlight	Cursor			guifg=yellow		guibg=gray								ctermfg=yellow		ctermbg=gray
highlight	lCursor			guifg=black			guibg=white								ctermfg=black		ctermbg=white
highlight	Comment			guifg=#00ff00												ctermfg=green
highlight	Constant		guifg=Red													ctermfg=red								cterm=none
highlight	Special			guifg=Orange						gui=bold				ctermfg=166								cterm=bold
highlight	Identifier		guifg=#5080ff												ctermfg=blue							cterm=none
highlight	Statement		guifg=#ffff60						gui=bold				ctermfg=yellow							cterm=bold
highlight	PreProc			guifg=Orange						gui=bold				ctermfg=166								cterm=bold
highlight	type			guifg=lightgrey						gui=none				ctermfg=lightgrey						cterm=none
highlight	Underlined																											cterm=underline				term=underline
highlight	Ignore			guifg=bg													ctermfg=bg
highlight	Pmenu			guifg=#efefef		guibg=#333333							ctermfg=black		ctermbg=gray
highlight	PmenuSel		guifg=#101010		guibg=yellow							ctermfg=black		ctermbg=yellow
highlight	PmenuSbar		guifg=blue			guibg=darkgray							ctermfg=blue		ctermbg=darkgray
highlight	PmenuThumb		guifg=#c0c0c0
highlight	NonASCII		guibg=red													ctermbg=red															term=standout


" everything to EOF is necessary to accomplish easy remapped single-line navigation with wrapped text
function! NoremapNormalCmd(key, preserve_omni, ...)
  let cmd = ''
  let icmd = ''
  for x in a:000
    let cmd .= x
    let icmd .= "<C-\\><C-O>" . x
  endfor
  execute ":nnoremap <silent> " . a:key . " " . cmd
  execute ":vnoremap <silent> " . a:key . " " . cmd
  if a:preserve_omni
    execute ":inoremap <silent> <expr> " . a:key . " pumvisible() ? \"" . a:key . "\" : \"" . icmd . "\""
  else
    execute ":inoremap <silent> " . a:key . " " . icmd
  endif
endfunction

" Cursor moves by screen lines
call NoremapNormalCmd("<Up>", 1, "gk")
call NoremapNormalCmd("<Down>", 1, "gj")
call NoremapNormalCmd("<Home>", 0, "g<Home>")
call NoremapNormalCmd("<End>", 0, "g<End>")

" PageUp/PageDown preserve relative cursor position
call NoremapNormalCmd("<PageUp>", 0, "<C-U>", "<C-U>")
call NoremapNormalCmd("<PageDown>", 0, "<C-D>", "<C-D>")
