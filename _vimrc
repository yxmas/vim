"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" This vimrc is based on the vimrc by Amix - http://amix.dk/
" You can find the latest version on:
"       http://blog.csdn.net/easwy
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
"
" Examples
" replace special line with nothing(not space or empty line)
" 1,10 s/.*abc.*\n//gc
" vundle {
" set rtp+=~/.vim/bundle/vundle/
" 如果在windows下使用的话，设置为
set rtp+=$HOME/.vim/bundle/vundle/
call vundle#rc()
" }
"
" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'

" original repos on github （Github网站上非vim-scripts仓库的插件，按下面格式填写）
" Bundle 'tpope/vim-fugitive'
" vim-scripts repos （vim-scripts仓库里的，按下面格式填写）
" Bundle 'FuzzyFinder'

" non github repos （非上面两种情况的，按下面格式填写）
" Bundle 'git://git.wincent.com/command-t.git'
"
" Brief help
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install(update) bundles
" :BundleSearch(!) foo - search(or refresh cache first) for foo
" :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
" vundle主要就是上面这个四个命令，例如BundleInstall是全部重新安装，BundleInstall!则是更新
" 一般安装插件的流程为，先BundleSearch一个插件，然后在列表中选中，按i安装
" 安装完之后，在vimrc中，添加Bundle 'XXX'，使得bundle能够加载，这个插件，同时如果
" 需要配置这个插件，也是在vimrc中设置即可
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle command are not allowed..

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Get out of VI's compatible mode..
set nocompatible
"set helplang=cn
"set enc=2byte-gb18030
set t_kb=

" Platform
function! MySys()
	return "linux"
endfunction

"Sets how many lines of history VIM har to remember
set history=400
" Chinese
if MySys() == "windows"
	"set encoding=utf-8
	"set langmenu=zh_CN.UTF-8
	"language message zh_CN.UTF-8
	"set fileencodings=ucs-bom,utf-8,gb18030,cp936,big5,euc-jp,euc-kr,latin1
endif

set scrolloff=3
set showmode
set modeline
set modelines=1
set showcmd
"set wildchar=<TAB>
"set wildmode=list:longest
set wildignore=*.o,*.a,*.so,*.lo,*.la
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc
autocmd BufRead *.[ch] set cindent

"autocmd BufRead *.txt set tw=70 | set linebreak
"command GNU set formatoptions=croql cindent comments=sr:/*,mb:*,el:*/,:// sw=4 expandtab softtabstop=2 cinoptions={.5s,:.5s,+.5s,t0,g0,^-2,e-2,n-2,p2s,(0,=.5s,f0
autocmd BufRead,BufNewFile *.py set sw=4|set expandtab|set softtabstop=4
"cobalt style
autocmd BufRead,BufNewFile {*.[chC]} set sw=4|set expandtab|set softtabstop=4
" Linux-Kernel coding style
"autocmd BufRead,BufNewFile {*.[chC],*.cc,*.hh} set sw=8|set noexpandtab|set softtabstop=8
autocmd BufRead,BufNewFile {*.mk} set sw=8|set noexpandtab|set softtabstop=8
"command LINUX set sw=8|set noexpandtab|set softtabstop=8
" DirectFB coding style
"command DFB set sw=5 sts=5 et
" PW coding style
"command PW set sw=4 sts=4 et

map <C-Tab> :tabn<CR>

"Enable filetype plugin
filetype plugin indent on

"Set to auto read when a file is changed from the outside
set autoread

"Have the mouse enabled all the time:
"set mouse=a
"double click left mouse will enable a ptag
"map <2-LeftMouse> :exe "pta ". expand("<cword>")<CR> 
"map <2-LeftMouse> :exe "/". expand("<cword>")<CR> 
"map <2-LeftMouse> :exe "sp ". expand("<cword>").".h"<CR> 
"map <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
map <F2> :%s/^\s*//g<CR>gg=G:w<CR>/aaaaaaaaa<CR>
"map <F4> argdo 
""%s/^\s*//g | exec 'normal gg=G'| w"

"Set mapleader
let mapleader = ","
let g:mapleader = ","


" Switch to buffer according to file name
function! SwitchToBuf(filename)
	"let fullfn = substitute(a:filename, "^\\~/", $HOME . "/", "")
	" find in current tab
	let bufwinnr = bufwinnr(a:filename)
	if bufwinnr != -1
		exec bufwinnr . "wincmd w"
		return
	else
		" find in each tab
		tabfirst
		let tab = 1
		while tab <= tabpagenr("$")
			let bufwinnr = bufwinnr(a:filename)
			if bufwinnr != -1
				exec "normal " . tab . "gt"
				exec bufwinnr . "wincmd w"
				return
			endif
			tabnext
			let tab = tab + 1
		endwhile
		" not exist, new tab
		exec "tabnew " . a:filename
	endif
endfunction

"Fast edit vimrc
if MySys() == 'linux'
	"Fast reloading of the .vimrc
	map <silent> <leader>ss :source ~/.vimrc<cr>
	"Fast editing of .vimrc
	map <silent> <leader>ee :call SwitchToBuf("~/.vimrc")<cr>
	"When .vimrc is edited, reload it
	"autocmd! bufwritepost .vimrc source ~/.vimrc
elseif MySys() == 'windows'
	" Set helplang
	set helplang=cn
	"Fast reloading of the _vimrc
	map <silent> <leader>ss :source ~/_vimrc<cr>
	"Fast editing of _vimrc
	map <silent> <leader>ee :call SwitchToBuf("~/_vimrc")<cr>
	"When _vimrc is edited, reload it
	autocmd! bufwritepost _vimrc source ~/_vimrc
	"Fast copying from linux
	func! CopyFromZ()
		autocmd! bufwritepost _vimrc
		exec 'split y:/.vimrc'
		exec 'normal 17G'
		exec 's/return "linux"/return "windows"/'
		exec 'w! ~/_vimrc'
		exec 'normal u'
		exec 'q'
	endfunc
	nnoremap <silent> <leader>uu :call CopyFromZ()<cr>:so ~/_vimrc<cr>
endif

" For windows version
if MySys() == 'windows'
	source $VIMRUNTIME/mswin.vim
	behave mswin

	set diffexpr=MyDiff()
	function! MyDiff()
		let opt = '-a --binary '
		if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
		if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
		let arg1 = v:fname_in
		if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
		let arg2 = v:fname_new
		if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
		let arg3 = v:fname_out
		if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
		let eq = ''
		if $VIMRUNTIME =~ ' '
			if &sh =~ '\<cmd'
				let cmd = '""' . $VIMRUNTIME . '\diff"'
				let eq = '"'
			else
				let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
			endif
		else
			let cmd = $VIMRUNTIME . '\diff'
		endif
		silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
	endfunction
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"Set font
"if MySys() == "linux"
"  set gfn=Monospace\ 11
"endif

" Avoid clearing hilight definition in plugins
if !exists("g:vimrc_loaded")
	"Enable syntax hl
	syntax enable

	" color scheme
	if has("gui_running")
		"set guioptions-=T
		"set guioptions-=m
		"set guioptions-=L
		"set guioptions-=r
		colorscheme darkblue_my
		"hi normal guibg=#294d4a
	else
		colorscheme desert_my
	endif " has
endif " exists(...)
set guifont=Bitstream\ Vera\ Sans\ Mono\ 6
"Some nice mapping to switch syntax (useful if one mixes different languages in one file)
map <leader>1 :set syntax=c<cr>
map <leader>2 :set syntax=xhtml<cr>
map <leader>3 :set syntax=python<cr>
map <leader>4 :set ft=javascript<cr>
map <leader>$ :syntax sync fromstart<cr>

map <silent> <leader>cf :set guifont=Bitstream\ Vera\ Sans\ Mono\ 10<cr>
map <silent> <leader>ct : set sw=4|set expandtab|set softtabstop=4

"Highlight current
"if has("gui_running")
"  set cursorline
"  hi cursorline guibg=#333333
"  hi CursorColumn guibg=#333333
"endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Fileformats
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Favorite filetypes
set ffs=unix,dos

nmap <leader>fd :se ff=dos<cr>
nmap <leader>fu :se ff=unix<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VIM userinterface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Set 7 lines to the curors - when moving vertical..
"set so=7

" Maximum window when GUI running
"M_xsyang
if has("gui_running")
	set lines=35 "40 45
	set columns=130 "130 130
endif

"Turn on WiLd menu
set wildmenu

"Always show current position
set ruler

"The commandbar is 2 high
set cmdheight=2

"Show line number
set nu

"Do not redraw, when running macros.. lazyredraw
set lz

"Change buffer - without saving
"set hid

"Set backspace
set backspace=eol,start,indent

"Bbackspace and cursor keys wrap to
"set whichwrap+=<,>,h,l
set whichwrap+=<,>

"Ignore case when searching
set ignorecase smartcase

"Include search
set incsearch

"Highlight search things
set hlsearch

"Set magic on
set magic

"No sound on errors.
set noerrorbells
set novisualbell
set t_vb=

"show matching bracets
"set showmatch

"How many tenths of a second to blink
"set mat=2

""""""""""""""""""""""""""""""
" Statusline
""""""""""""""""""""""""""""""
"Always hide the statusline
set laststatus=2


""""""""""""""""""""""""""""""
" Visual
""""""""""""""""""""""""""""""
" From an idea by Michael Naumann
function! VisualSearch(direction) range
	let l:saved_reg = @"
	execute "normal! vgvy"
	let l:pattern = escape(@", '\\/.*$^~[]')
	let l:pattern = substitute(l:pattern, "\n$", "", "")
	if a:direction == 'b'
		execute "normal ?" . l:pattern . "^M"
	else
		execute "normal /" . l:pattern . "^M"
	endif
	let @/ = l:pattern
	let @" = l:saved_reg
endfunction

"Basically you press * or # to search for the current selection !! Really useful
vnoremap <silent> * :call VisualSearch('f')<CR>
vnoremap <silent> # :call VisualSearch('b')<CR>

"vnoremap  *  y/<C-R>=escape(@", '\\/.*$^~[]')<CR><CR>
"vnoremap  #  y?<C-R>=escape(@", '\\/.*$^~[]')<CR><CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Moving around and tabs
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Map space to / and c-space to ?
"map <space> /
"map <c-space> ?

"Smart way to move btw. windows
nmap <C-j> <C-W>j
nmap <C-k> <C-W>k
nmap <C-h> <C-W>h
nmap <C-l> <C-W>l

"Actually, the tab does not switch buffers, but my arrows
"Bclose function can be found in "Buffer related" section
"map <down> <leader>bd

"Use the arrows to something usefull
"map <right> :bn<cr>
"map <left> :bp<cr>


"Switch to current dir
map <silent> <leader>cd :cd %:p:h<cr>



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General Abbrevs
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"My information
iab xdate <c-r>=strftime("%c")<cr>
"iab xname Xsyang


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Editing mappings etc.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

func! DeleteTrailingWS()
	exe "normal mz"
	%s/\s\+$//ge
	nohl
	exe "normal `z"
endfunc

" do not automaticlly remove trailing whitespace
"autocmd BufWrite *.[ch] :call DeleteTrailingWS()
"autocmd BufWrite *.cc :call DeleteTrailingWS()
"autocmd BufWrite *.txt :call DeleteTrailingWS()
nmap <silent> <leader>ws :call DeleteTrailingWS()<cr>:w<cr>
"nmap <silent> <leader>ws! :call DeleteTrailingWS()<cr>:w!<cr>


" vim -b : edit binary using xxd-format!
augroup Binary
  au!
  au BufReadPre  *.bin let &bin=1
  au BufReadPost *.bin if &bin | %!xxd -ps -c 16 -g 4
  au BufReadPost *.bin set ft=xxd | endif
  au BufWritePre *.bin if &bin | %!xxd -r -ps -c 16 -g 4
  au BufWritePre *.bin endif
  au BufWritePost *.bin if &bin | %!xxd -ps -c 16 -g 4
  au BufWritePost *.bin set nomod | endif
augroup END


"Restore cursor to file position in previous editing session
autocmd BufReadPost *
         \ if line("'\"") > 0 && line ("'\"") <= line("$") |
         \   exe "normal g'\"" |
         \ endif
    
"Restore cursor to file position in previous editing session
set viminfo='10,\"100,:20,n~/.viminfo
"au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

	" Don't close window, when deleting a buffer
	command! Bclose call <SID>BufcloseCloseIt()

	function! <SID>BufcloseCloseIt()
		let l:currentBufNum = bufnr("%")
		let l:alternateBufNum = bufnr("#")

		if buflisted(l:alternateBufNum)
			buffer #
		else
			bnext
		endif

		if bufnr("%") == l:currentBufNum
			new
		endif

		if buflisted(l:currentBufNum)
			execute("bdelete! ".l:currentBufNum)
		endif
	endfunction

	"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	" Session options
	"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	set sessionoptions-=curdir
	set sessionoptions+=sesdir

	"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	" Files and backups
	"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	"Turn backup off
	set nobackup
	set nowb
	"set noswapfile


	"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	" Folding
	"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	"Enable folding, I find it very useful
	"set fen
	"set fdl=0
	nmap <silent> <leader>zo zO
	vmap <silent> <leader>zo zO


	"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	" Text options
	"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	set expandtab
	set shiftwidth=4

	"set softtabstop=4
	set tabstop=8
	"map <leader>t2 :set shiftwidth=2<cr>
	"map <leader>t4 :set shiftwidth=4<cr>
	"au FileType html,python,vim,javascript setl shiftwidth=2
	"au FileType html,python,vim,javascript setl tabstop=2
	"au FileType java,c setl shiftwidth=4
	"au FileType java setl tabstop=4
	au FileType txt setl lbr
	au FileType txt setl tw=78

	set smarttab
	"set lbr
	"set tw=78

	""""""""""""""""""""""""""""""
	" Indent
	""""""""""""""""""""""""""""""
	"Auto indent
	set ai

	"Smart indet
	set si

	"C-style indeting
	set cindent

	"Wrap lines
	"   set nowrap


	"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	" Spell checking
	"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	map <leader>sn ]s
	map <leader>sp [s
	map <leader>sa zg
	map <leader>s? z=

	"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	" Complete
	"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	" options
	set completeopt=longest,preview,menu
	set complete-=u
	set complete-=i

	" mapping
	inoremap <expr> <CR>       pumvisible()?"\<C-Y>":"\<CR>"
	inoremap <expr> <C-J>      pumvisible()?"\<PageDown>\<C-N>\<C-P>":"\<C-X><C-O>"
	inoremap <expr> <C-K>      pumvisible()?"\<PageUp>\<C-P>\<C-N>":"\<C-K>"
	inoremap <expr> <C-U>      pumvisible()?"\<C-E>":"\<C-U>"
	inoremap <C-]>             <C-X><C-]>
	inoremap <C-F>             <C-X><C-F>
	inoremap <C-D>             <C-X><C-D>
	inoremap <C-L>             <C-X><C-L>

	" Enable syntax
	if has("autocmd") && exists("+omnifunc")
		autocmd Filetype *
					\if &omnifunc == "" |
					\  setlocal omnifunc=syntaxcomplete#Complete |
					\endif
	endif


	"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	" Plugin configuration
	"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	""""""""""""""""""""""""""""""
	" Super Tab
	""""""""""""""""""""""""""""""
	"let g:SuperTabDefaultCompletionType = "<C-X><C-O>"
	let g:SuperTabDefaultCompletionType = "<C-P>"

	""""""""""""""""""""""""""""""
	" yank ring setting
	""""""""""""""""""""""""""""""
	map <leader>yr :YRShow<cr>

	""""""""""""""""""""""""""""""
	" file explorer setting
	""""""""""""""""""""""""""""""
	"Split vertically
	let g:explVertical=1

	"Window size
	let g:explWinSize=35

	let g:explSplitLeft=1
	let g:explSplitBelow=1

	"Hide some files
	let g:explHideFiles='^\.,.*\.class$,.*\.swp$,.*\.pyc$,.*\.swo$,\.DS_Store$'

	"Hide the help thing..
	let g:explDetailedHelp=0


	""""""""""""""""""""""""""""""
	" minibuffer setting
	""""""""""""""""""""""""""""""
	let loaded_minibufexplorer = 1         " *** Disable minibuffer plugin
	let g:miniBufExplorerMoreThanOne = 2   " Display when more than 2 buffers
	let g:miniBufExplSplitToEdge = 1       " Always at top
	let g:miniBufExplMaxSize = 3           " The max height is 3 lines
	let g:miniBufExplMapWindowNavVim = 1   " map CTRL-[hjkl]
	let g:miniBufExplUseSingleClick = 1    " select by single click
	let g:miniBufExplModSelTarget = 1      " Dont change to unmodified buffer
	let g:miniBufExplForceSyntaxEnable = 1 " force syntax on
	"let g:miniBufExplVSplit = 25
	"let g:miniBufExplSplitBelow = 0

	autocmd BufRead,BufNew :call UMiniBufExplorer

	""""""""""""""""""""""""""""""
	" bufexplorer setting
	""""""""""""""""""""""""""""""
	let g:bufExplorerDefaultHelp=1       " Do not show default help.
	let g:bufExplorerShowRelativePath=1  " Show relative paths.
	let g:bufExplorerSortBy='mru'        " Sort by most recently used.
	let g:bufExplorerSplitRight=0        " Split left.
	let g:bufExplorerSplitVertical=1     " Split vertically.
	let g:bufExplorerSplitVertSize = 30  " Split width
	let g:bufExplorerUseCurrentWindow=1  " Open in new window.
	let g:bufExplorerMaxHeight=13        " Max height

	""""""""""""""""""""""""""""""
	" taglist setting
	""""""""""""""""""""""""""""""
	if MySys() == "windows"
		let Tlist_Ctags_Cmd = 'ctags'
	elseif MySys() == "linux"
		let Tlist_Ctags_Cmd = '/usr/bin/ctags'
	endif
	let Tlist_Show_One_File = 1
	let Tlist_Exit_OnlyWindow = 1
	let Tlist_Use_Right_Window = 1
	nmap <silent> <leader>tl :Tlist<cr>

	""""""""""""""""""""""""""""""
	" winmanager setting
	""""""""""""""""""""""""""""""
	"   let g:winManagerWindowLayout = "BufExplorer,FileExplorer|TagList"
	"   let g:winManagerWidth = 30
	"   let g:defaultExplorer = 0
	"   nmap <C-W><C-F> :FirstExplorerWindow<cr>
	"   nmap <C-W><C-B> :BottomExplorerWindow<cr>
	"   nmap <silent> <leader>wm :WMToggle<cr>
	"   autocmd BufWinEnter \[Buf\ List\] setl nonumber


	""""""""""""""""""""""""""""""
	" C/C++
	"""""""""""""""""""""""""""""""
	autocmd FileType c,cpp  map <buffer> <leader><space> :make<cr>
	"autocmd FileType c,cpp  setl foldmethod=syntax | setl fen

	"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	" MISC
	"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	"Quickfix
	nmap <leader>cn :cn<cr>
	nmap <leader>cp :cp<cr>
	nmap <leader>cw :cw 10<cr>
	"nmap <leader>cc :botright lw 10<cr>
	"map <c-u> <c-l><c-j>:q<cr>:botright cw 10<cr>

	""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	" Mark as loaded
	""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	let g:vimrc_loaded = 1


