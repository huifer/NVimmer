"-----------------------vim-plug----------------------------
call plug#begin('~/.config/nvim/plugged')
" IDE启动界面
Plug 'mhinz/vim-startify'
" coc插件
Plug 'neoclide/coc.nvim', {'branch':'release'}
let g:coc_global_extensions=[
            \'coc-html',
            \'coc-eslint',
            \'coc-tsserver',
            \'coc-snippets',
            \'coc-emmet',
            \'coc-kotlin',
            \'coc-clangd',
            \'coc-java',
            \'coc-pairs',
            \'coc-json',
            \'coc-vimtex',
            \'coc-texlab',
            \'coc-lists',
            \'coc-highlight',
            \'coc-css',
            \'coc-git',
            \'coc-phpls',
            \'coc-prettier',
            \'coc-wxml',
            \'coc-vetur',
            \'coc-stylelint',
            \'coc-word',
            \'coc-python',
            \'coc-tabnine',
            \'coc-emoji',
            \'coc-floaterm',
            \'coc-markdownlint',
            \'coc-webview',
            \'coc-markdown-preview-enhanced'
            \]

" code syntax
Plug 'thesis/vim-solidity'
Plug 'pangloss/vim-javascript'
Plug 'posva/vim-vue'
Plug 'uiiaoo/java-syntax.vim', {'for':'java'}
Plug 'othree/html5.vim', {'for':['html','vue','php']}
Plug 'hail2u/vim-css3-syntax',{'for':['html','vue','php','css']}
" 颜色显示
Plug 'ap/vim-css-color',{'for':['html','vue','php','css']}
" themes
Plug 'flazz/vim-colorschemes'
Plug 'jacoborus/tender.vim'
Plug 'lervag/vimtex', {'for': 'tex'}
Plug 'xuhdev/vim-latex-live-preview', {'for': 'tex'}
Plug 'majutsushi/tagbar', {'on':'TagbarToggle'}
"let g:tagbar_ctags_bin='/opt/homebrew/Cellar/ctags/5.8_2/bin/ctags'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme='qwq'
" others
Plug 'honza/vim-snippets'
Plug 'Shougo/neco-vim'
Plug 'neoclide/coc-neco'
Plug 'voldikss/vim-floaterm'
let g:floaterm_position = 'center'
Plug 'Chiel92/vim-autoformat'
Plug 'sbdchd/neoformat'
Plug 'tpope/vim-fugitive'
Plug 'ryanoasis/vim-devicons'
Plug 'Yggdroot/indentLine'
Plug 'mattn/emmet-vim', {'for':['html','xml','vue','php','typescriptreact','javascriptreact']}
Plug 'junegunn/fzf', { 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-surround'
Plug 'maxmellon/vim-jsx-pretty', {'for':['typescriptreact','javascript','typescript','javascriptreact']}
Plug 'HerringtonDarkholme/yats.vim', {'for':['typescriptreact','javascript','typescript','javascriptreact']}
let g:vim_jsx_pretty_colorful_config = 1 " default 0
Plug 'vim-scripts/matchit.zip', {'for':['html','xml','vue','php','typescriptreact','javascript','typescript','javascriptreact']}
" CLang
Plug 'jackguo380/vim-lsp-cxx-highlight'
" json
Plug 'leshill/vim-json', {'for':'json'}
"kotlin
Plug 'udalov/kotlin-vim'
" markdown
"Plug 'godlygeek/tabular'
"Plug 'plasticboy/vim-markdown'
" nerdtree plugins
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
let NERDTreeShowHidden=1
Plug 'tiagofumo/vim-nerdtree-syntax-highlight', { 'on': 'NERDTreeToggle' }
Plug 'Xuyuanp/nerdtree-git-plugin', { 'on': 'NERDTreeToggle' }
" Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
            \ quit | endif
" Start NERDTree when Vim starts with a directory argument.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
            \ execute 'NERDTree' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | endif

let g:vue_pre_processors = []
call plug#end()

"------------------------------coc.nvim---------------------------------------
" Set internal encoding of vim, not needed on neovim, since coc.nvim using some
" unicode characters in the file autoload/float.vim
set encoding=utf-8

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
    " Recently vim can merge signcolumn and number column into one
    set signcolumn=number
else
    set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
    inoremap <silent><expr> <c-space> coc#refresh()
else
    inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
            \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    elseif (coc#rpc#ready())
        call CocActionAsync('doHover')
    else
        execute '!' . &keywordprg . " " . expand('<cword>')
    endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
    autocmd!
    " Setup formatexpr specified filetype(s).
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder.
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
    nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
    nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
    inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
    inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
    vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
    vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
"------------------------------coc.nvim---------------------------------------------

"vim基础设置-----------------------------------------------------------------------------
syntax on
set sw=4
set ts=4
set et
set smarttab
set smartindent
set lbr
set fo+=mB
set sm
set selection=inclusive
set wildmenu
set mousemodel=popup
color molokai
"--------------------------------------------显示相关---------------------------------------
set cul "高亮光标所在行
set cuc
set ruler           " 显示标尺
set showcmd         " 输入的命令显示出来，看的清楚些
set scrolloff=2     " 光标移动到buffer的顶部和底部时保持3行距离
set laststatus=2   " 启动显示状态行(1),总是显示状态行(2)
set foldenable      " 允许折叠
set foldmethod=manual   " 手动折叠
set cursorline              " 突出显示当前行
set magic                   " 设置魔术
" 自动缩进
set autoindent
set cindent
" Tab键的宽度
set tabstop=4
" 统一缩进为4
set softtabstop=4
set shiftwidth=4
" 使用空格代替制表符
set expandtab
" 在行和段开始处使用制表符
set smarttab
" 显示行号
set number
set showmode
" 历史记录数
set history=1000
"搜索逐字符高亮
set hlsearch
set incsearch
" 总是显示状态行
set cmdheight=1
" 保存全局变量
set viminfo+=!
" 带有如下符号的单词不要被换行分割
set iskeyword+=$,@,%,#,-,_
filetype plugin on
"tab, buffer快捷键配置----------------------------------------------------------------------------
map <S-H> :tabp<CR>
map <S-L> :tabn<CR>
map <S-Left> :tabp<CR>
map <S-Right> :tabn<CR>
map <C-H> :bn<CR>            "下一个缓冲区
map <C-L> :bp<CR>        "上一个缓冲区
map <C-Left> :bn<CR>            "下一个缓冲区
map <C-Right> :bp<CR>        "上一个缓冲区
"代码格式化---------------------------------------------------------------------------------------
command! -nargs=0 Prettier :CocCommand prettier.formatFile
noremap <F12> :Format<CR>
autocmd filetype vim noremap <buffer> <F12> :Autoformat<CR>
autocmd filetype markdown noremap <buffer> <F12> :Format<CR>:CocCommand markdownlint.fixAll<CR>
autocmd filetype vue,typescriptreact,javascriptreact nnoremap <buffer> <F12> :Prettier<CR>
let g:shfmt_opt="-ci"
autocmd filetype cs,c,cpp,kotlin,sh,zsh,tex noremap <buffer> <F12> :Neoformat<CR>
"常用快捷键---------------------------------------------------------------------------------------
"去空行，去行尾空格
nnoremap <F2> :g/^\s*$/d<CR>:g/\s\+$/s<CR>
"html标签自动补全
map! <C-O> <C-Y>,
"列出当前目录文件
nmap <F3> :NERDTreeToggle<CR>
"nmap <F4> :CocCommand floaterm.toggle<CR>
let g:floaterm_keymap_toggle = '<F4>'
"tagbar
nmap <F9> :TagbarToggle<CR>
"按F5保存
nmap <F5> :w<CR>

"实用配置------------------------------------------------------------------------------
" 只剩 NERDTree时自动关闭
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
" 设置当文件被改动时自动载入
set autoread
au FocusGained * :checktime
" quickfix模式
autocmd FileType c,cpp map <buffer> <leader><space> :w<cr>:make<cr>
"代码补全
set completeopt=longest,menu
"自动保存
set autowrite
" 去掉输入错误的提示声音
"set noeb
" 在处理未保存或只读文件的时候，弹出确认
set confirm
"禁止自动分行
set wrap
set linebreak
"禁止生成临时文件
set noundofile
set nobackup
set nowritebackup
set noswapfile
"搜索忽略大小写
set ignorecase
set smartcase
set linespace=0
"set spell spelllang=en_us
" 使回格键（backspace）正常处理indent, eol, start等
set listchars=tab:»■,trail:■
set list
set backspace=2
" 可以在buffer的任何地方使用鼠标（类似office中在工作区双击鼠标定位）
set mouse=a
set selection=exclusive
set selectmode=mouse,key
" 通过使用: commands命令，告诉我们文件的哪一行被改变过
set report=0
" 在被分割的窗口间显示空白，便于阅读
set fillchars=vert:\ ,stl:\ ,stlnc:\
" 高亮显示匹配的括号
set showmatch
" 匹配括号高亮的时间（单位是十分之一秒）
set matchtime=5
" 光标移动到buffer的顶部和底部时保持3行距离
set scrolloff=5
set autochdir "输出时只有文件名，不带./ ../等目录前缀(默认了执行％在当前的目录下)
set termencoding=UTF-8
set encoding=UTF-8
set fileencodings=utf-8,ucs-bom,gbk,cp936,gb2312,gb18030

"fzf-----------------------------------------------------------------------
function! s:fzf_statusline()
    " Override statusline as you like
    highlight fzf1 ctermfg=161 ctermbg=251
    highlight fzf2 ctermfg=23 ctermbg=251
    highlight fzf3 ctermfg=237 ctermbg=251
    setlocal statusline=%#fzf1#\ >\ %#fzf2#fz%#fzf3#f
endfunction

autocmd! User FzfStatusLine call <SID>fzf_statusline()
" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1
" [[B]Commits] Customize the options used by 'git log':
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'
" [Tags] Command to generate tags file
let g:fzf_tags_command = 'ctags -R'
" [Commands] --expect expression for directly executing the command
let g:fzf_commands_expect = 'alt-enter,ctrl-x'
" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion
imap <c-x><c-w> <plug>(fzf-complete-word)
imap <c-x><c-p> <plug>(fzf-complete-path)
imap <c-x><c-f> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)
nmap <C-F> :Files<CR>
nmap <C-P> :Files<CR>
nmap ff :Files<CR>
vmap <C-c> "+y
imap <C-V> <Esc>"+gpa
nmap <C-V> "+gp
imap <C-P> <Esc>:Files<CR>
nmap <C-B> :Buffers<CR>
nmap fb :Buffers<CR>
imap <C-B> <Esc>:Buffers<CR>
nmap <C-T> :Tags<CR>
nmap ft :Tags<CR>
let g:fzf_action = { 'ctrl-b': 'edit' }

" Advanced customization using Vim function
inoremap <expr> <c-x><c-w> fzf#vim#complete#word({'right': '20%'})

"闪烁光标------------------------------------------------------------------
set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
            \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
            \,sm:block-blinkwait175-blinkoff150-blinkon175
