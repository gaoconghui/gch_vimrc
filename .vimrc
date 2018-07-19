" 一些常规的配置{{{
    " 不需要适配vi
    set nocompatible
    " 缩进 
    set tabstop=4
    set autoindent             " Indent according to previous line.
    set expandtab              " Use spaces instead of tabs.
    set softtabstop =4         " Tab key indents by 4 spaces.
    set shiftwidth  =4         " >> indents by 4 spaces.
    set shiftround             " >> indents to next multiple of 'shiftwidth'.


    set backspace   =indent,eol,start  " Make backspace work as you would expect.
    set hidden                 " Switch between buffers without having to save first.
    set laststatus  =2         " Always show statusline.
    set display     =lastline  " Show as much as possible of the last line.

    set showmode               " Show current mode in command-line.
    set showcmd                " Show already typed keys when more are expected.

    set incsearch              " Highlight while searching with / or ?.
    set hlsearch               " Keep matches highlighted.

    set ttyfast                " Faster redrawing.
    set lazyredraw             " Only redraw when necessary.

    set splitbelow             " Open new windows below the current window.
    set splitright             " Open new windows right of the current window.

    set cursorline             " Find the current line quickly.
    set wrapscan               " Searches wrap around end-of-file.
    set report      =0         " Always report changed lines.
    set synmaxcol   =200       " Only highlight the first 200 columns.

    set mouse=a
    " 居中 
    set so=999
    " 显示行号
    set number
    " display completion matches in status line
    set wildmenu

    " 不同文件类型插件采用不同的缩进
    filetype plugin indent on

    if has('multi_byte') && &encoding ==# 'utf-8'
      let &listchars = 'tab:▸ ,extends:❯,precedes:❮,nbsp:±'
    else
      let &listchars = 'tab:> ,extends:>,precedes:<,nbsp:.'
    endif


    " 设置leader 为,
    let mapleader = ','
    " 折叠
    set foldmethod=indent
    set foldlevel=99
    " 语法高亮
    syntax on

    set lazyredraw
    set ttyfast
    set re=1
    let c_comment_strings=1
" }}}

" 保存折叠
"au BufWinLeave * silent  mkview
"au BufWinEnter * silent loadview
" 快捷键映射 {{{ 
    nnoremap <space> za
    " 补全<CR>确认
    inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" }}}

"
" 加载本地的bundle配置
" bundles config{{{
    if filereadable(expand("~/.vimrc.bundle"))
    	source ~/.vimrc.bundle
    endif	
" }}}

" 不同bundle或者是语言的配置 {{{
	" NertTree {{{
		if isdirectory(expand("~/.vim/bundle/nerdtree"))
			map <C-e> <plug>NERDTreeTabsToggle<CR>
			map <leader>e :NERDTreeFind<CR>
			nmap <leader>nt :NERDTreeFind<CR>
			
			let NERDTreeShowBookmarks=1
			let NERDTreeIgnore=['\.py[cd]$', '\~$', '\.swo$', '\.swp$', '^\.git$', '^\.hg$', '^\.svn$', '\.bzr$']
			let NERDTreeChDirMode=0
			let NERDTreeQuitOnOpen=1
			let NERDTreeMouseMode=2
			let NERDTreeShowHidden=1
			let NERDTreeKeepTreeInNewTab=1
			let g:nerdtree_tabs_open_on_gui_startup=0
	    endif
	" }}}	

	"  YouCompleteMe {{{
		if isdirectory(expand("~/.vim/bundle/YouCompleteMe")) 
			let g:acp_enableAtStartup = 0
			let g:ycm_collect_identifiers_from_tags_files = 1
			
			" Ultisnip的一些适配
			let g:UltiSnipsExpandTrigger = '<C-j>'
			let g:UltiSnipsJumpForwardTrigger = '<C-j>'
			let g:UltiSnipsJumpBackwardTrigger = '<C-k>'
 
			" Enable omni completion.
        	autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
        	autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
        	autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
        	autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
        	autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
		endif		

        " 补全完成 预览窗口关闭
        augroup complete
        autocmd!
        autocmd CompleteDone * pclose
        augroup end
	" }}}
	
	" Python {{{
	    if isdirectory(expand("~/.vim/bundle/python-mode"))
            let g:pymode = 1
             "使用python2
            let g:pymode_python = 'python'	
            let g:pymode_indent = 1

            let g:pymode_rope_goto_definition_bind = "<C-]>"

            " ,f设置为format
            au FileType python nmap <leader>f :PymodeLintAuto<CR>

    	endif
	" }}}

    " GoLang {{{
        if isdirectory(expand("~/.vim/bundle/vim-go")) 
            let g:go_highlight_functions = 1
            let g:go_highlight_methods = 1
            let g:go_highlight_structs = 1
            let g:go_highlight_operators = 1
            let g:go_highlight_build_constraints = 1
            let g:go_fmt_command = "goimports"
            let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
            let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }
            let g:go_def_reuse_buffer = 0
            let g:go_def_mode = "guru"

            augroup filetype_go
                au FileType go nmap <Leader>s <Plug>(go-implements)
                au FileType go nmap <Leader>i <Plug>(go-info)
                au FileType go nmap <Leader>e <Plug>(go-rename)
                au FileType go nmap <leader>r <Plug>(go-run)
                au FileType go nmap <leader>b <Plug>(go-build)
                au FileType go nmap <leader>t <Plug>(go-test)
                au FileType go nmap <Leader>gd <Plug>(go-doc)
                au FileType go nmap <Leader>gv <Plug>(go-doc-vertical)
                au FileType go nmap <leader>co <Plug>(go-coverage)
                
                " gd可以跳转到定义去 ,s跳转并切分
                au FileType go nmap gdv <Plug>(go-def-vertical)
                " ,f设置为format
                au FileType go nmap <leader>f :GoImports<CR>

                " 使用A 跳转到对应的测试文件
                au Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
                au Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
                au Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
                au Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')
                au FileType go set foldmethod=syntax
                au BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4
            augroup END 

            " bug fix
            map <C-n> :cnext<CR>
            map <C-m> :cprevious<CR>
            nnoremap <leader>a :cclose<CR>

            
        endif
    " }}}

    " vim {{{
        augroup filetype_vim
            autocmd!
            autocmd FileType vim setlocal foldmethod=marker
        augroup END
    " }}}
    
    " tagbar {{{
        if isdirectory(expand("~/.vim/bundle/tagbar/"))
            nnoremap <silent> <leader>tt :TagbarToggle<CR>
            " 在打开tagbar的情况下，跳转到tagbar下 
            nnoremap <silent> <leader>j :TagbarOpen j<CR>
         endif
    " }}}

    " nerd commenter {{{
        if isdirectory(expand("~/.vim/bundle/nerdcommenter")) 
            " Ctrl + / 注释当前行并移动到下一行
            nmap <C-_>   <Plug>NERDCommenterToggle<Down>
            vmap <C-_>   <Plug>NERDCommenterToggle<CR>gv
        endif
    " }}}

    " undotree{{{
        if isdirectory(expand("~/.vim/bundle/undotree"))
            nnoremap <leader>u :UndotreeToggle<cr>
        endif
    " }}}

" }}}

" 一些功能 需要额外函数辅助{{{
" 保存上次退出状态（光标位置，折叠等{{{
        "if exists("g:loaded_restore_view")
            "finish
    "endif
    "let g:loaded_restore_view = 1

    "if !exists("g:skipview_files")
        "let g:skipview_files = []
    "endif

    "function! MakeViewCheck()
        "if &l:diff | return 0 | endif
        "if &buftype != '' | return 0 | endif
        "if expand('%') =~ '\[.*\]' | return 0 | endif
        "if empty(glob(expand('%:p'))) | return 0 | endif
        "if &modifiable == 0 | return 0 | endif
        "if len($TEMP) && expand('%:p:h') == $TEMP | return 0 | endif
        "if len($TMP) && expand('%:p:h') == $TMP | return 0 | endif

        "let file_name = expand('%:p')
        "for ifiles in g:skipview_files
            "if file_name =~ ifiles
                "return 0
            "endif
        "endfor

        "return 1
    "endfunction

    "augroup AutoView
        "autocmd!
        "" Autosave & Load Views.
        "autocmd BufWritePre,BufWinLeave ?* if MakeViewCheck() | silent! mkview | endif
        "autocmd BufWinEnter ?* if MakeViewCheck() | silent! loadview | endif
    "augroup END

" }}}
" }}}


" 键位映射 {{{
" 	 切换窗口
	map <C-J> <C-W>j<C-W>_
    map <C-K> <C-W>k<C-W>_
    map <C-L> <C-W>l<C-W>_
    map <C-H> <C-W>h<C-W>_

    " insert mode {{{
        inoremap <c-d> <esc>dwi
        inoremap <c-a> <esc>^i
        inoremap <c-f> <esc>lwi
        inoremap <c-b> <esc>bi

        " move around in insert
        inoremap <C-k> <Up>
        inoremap <C-h> <Left>
        inoremap <C-l> <Right>
        inoremap <C-j> <Down>

        " 退出insert mode
        inoremap jk <esc>
        inoremap kj <esc>
    " }}}

    " 快速打开vimrc 以及快速生效
    nnoremap <leader>ev :vsplit $MYVIMRC<cr>
    nnoremap <leader>sv :source $MYVIMRC<cr>

" }}}

" 配色方案
let g:rehash256 = 1
let g:molokai_original = 1
colorscheme molokai

