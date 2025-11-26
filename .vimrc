set number " Show absolute line numbers on the left.
filetype plugin on " Auto-detect un-labeled filetypes
filetype detect " Detect filetypes
syntax on " Turn syntax highlighting on
set ai " Sets auto-indentation
set si " Sets smart-indentation
set noswapfile " Prevent vim from creating .swp files
set tabstop=2 " Tab equal 2 spaces (default 4)
set shiftwidth=4 " Number of spaces to use for auto-indentation
set smarttab " Be smart when using tabs
set wrap " Wrap overflowing lines
set hlsearch " When searching (/), highlights matches as you go
set incsearch " When searching (/), display results as you type (instead of only upon ENTER)
set ignorecase " When searching (/), ignore case entirely
set smartcase " When searching (/), automatically switch to a case-sensitive search if you use any capital letters
set shortmess-=S "When searching (/), count matches"
set cmdheight=1 " Set height of the command bar to 2
set showmatch " Show matching brackets when text indicator is over them
hi MatchParen cterm=bold ctermbg=none ctermfg=magenta " Set matching bracket color
set noerrorbells " Silence the error bell
set novisualbell " Visually hide the error bell
set encoding=utf8 " Set text encoding as utf8
set clipboard=unnamedplus " Use the OS clipboard by default
set noendofline " No end-of-line character
set mouse=a " Enable mouse support
set splitright " Open new splits to the right
set ttyfast " Faster redrawing
set showcmd " Show (partial) command in status line
set laststatus=2 " Always show the status line
set ruler " Show the cursor position all the time
set noshowmode " Do not show the current mode
autocmd ColorScheme * highlight CocFloating guibg=#333333 " Fix coc
autocmd ColorScheme * hi Normal guibg=NONE ctermbg=NONE " Fix background color

"clear /search
map <ESC> :let @/=''<cr>" clear search

"Control-Backspace to delete entire word for gvim
inoremap <C-BS> <C-W>

"Map Ctrl-Backspace to delete the previous word in insert mode."
noremap! <C-BS> <C-w>
noremap! <C-h> <C-w>
set backspace=indent,eol,start


"disable grey split bar between windows
highlight VertSplit cterm=NONE

call plug#begin('~/.vim/plugged')

Plug 'DanBradbury/copilot-chat.vim'
Plug 'preservim/nerdtree'
Plug 'junegunn/fzf', { 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'github/copilot.vim'
"Plug 'dense-analysis/ale'
Plug 'ryanoasis/vim-devicons' "Icons for NerdTree
Plug 'psliwka/vim-smoothie' "Smooth Scrolling
Plug 'jiangmiao/auto-pairs' "Autocomplete Pairs
Plug 'tpope/vim-surround' "Surround Text with Brackets
Plug 'lervag/vimtex' "LaTeX
Plug 'scrooloose/syntastic' "Syntax Checker
Plug 'frazrepo/vim-rainbow' "Rainbow Brackets
Plug 'neoclide/coc.nvim', {'branch': 'release'} "Intellisense Autocomplete
Plug 'ap/vim-css-color' "CSS Color Preview
Plug 'itchyny/lightline.vim' "Status Line
Plug 'Donaldttt/fuzzyy' "Search File + Preview, Keywords in Project
Plug 'Everblush/everblush.vim' "Colorscheme
Plug 'EdenEast/nightfox.nvim' "Colorscheme
Plug 'junegunn/seoul256.vim' "Colorscheme
Plug 'mechatroner/rainbow_csv' "Rainbow CSV
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npx --yes yarn install' } "Markdown Preview
Plug 'nanotee/zoxide.vim'
Plug 'prettier/vim-prettier', { 'do': 'npm install' }


call plug#end()

"for copilot chat:
filetype plugin indent on

"Open Terminal in current directory
map <C-k> :let $VIM_DIR=expand('%:p:h')<CR>:vert term<CR>cd $VIM_DIR<CR>
:vertical resize +25<CR><C-w>w
nnoremap <C-g> :vertical resize +5<CR>
nnoremap <C-f> :vertical resize -5<CR>

nnoremap ,b :NERDTreeToggle<CR>

"Colorscheme"
"let g:seoul256_background = 233    "233 (darkest) ~ 239 (lightest)
colorscheme nightfox
set background=dark
hi Comment  guifg=#80a0ff ctermfg=darkred "Comment color
"set termguicolors


"Toggle background transparency
let t:is_transparent = 0
function! Toggle_transparent_background()
  if t:is_transparent == 0
    hi Normal guibg=#111111 ctermbg=black
    let t:is_transparent = 1
  else
    hi Normal guibg=NONE ctermbg=NONE
    let t:is_transparent = 0
  endif
endfunction
nnoremap <F3> :call Toggle_transparent_background()<CR>



"Status bar (lightline)
set ttimeout ttimeoutlen=50 "lightline prevent del prevent delay
let g:sb_default_behavior = "always" "Always show status bar
let g:lightline = {
      \ 'colorscheme': 'one',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
     \ }


"COC settings
hi def link CocFloating Pmenu " Fixing stupid ass Coc

highlight link CocFloating markdown
hi Pmenu ctermbg=black ctermfg=white guibg=black guifg=white

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"


"gitgutter settings
highlight clear SignColumn
let g:rainbow_active = 1


"Fuzzy Finder alias
cnoreabbrev ff FuzzyFiles
cnoreabbrev fg FuzzyGitFiles

"stupid ass icon brackets nerdtree
let g:rainbow_active = 0
autocmd FileType * let g:rainbow_active=1


"LaTeX Plugin
let g:vimtex_compiler_latexmk = {
    \ 'options': [
        \ '-synctex=1',
        \ '-interaction=nonstopmode',
        \ '-file-line-error',
				\ '-xelatex'
    \ ],
\ }
let g:vimtex_compiler_continuous = 1
let g:vimtex_syntax_enabled=0
"let g:vimtex_view_general_viewer = 'okular'
"let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'
let g:tex_flavor = 'xelatex'
let g:vimtex_compiler_progname = 'nvr'
let g:Tex_DefaultTargetFormat='pdf'
let g:Tex_MultipleCompileFormats='pdf,bibtex,pdf'
let g:vimtex_quickfix_ignore_filters = [
      \ 'fancyhdr Warning',
      \ 'microtype',
      \ 'csquotes',
      \ 'Unable to apply patch',
      \ 'Underfull',
      \ 'Overfull',
      \ 'Package hyperref Warning',
      \ 'usenames',
      \]
" VimTeX Einstellungen
let g:vimtex_view_method = 'zathura'
let g:vimtex_compiler_method = 'latexmk'


" Latexmk Engine auf XeLaTeX setzen
let g:vimtex_compiler_latexmk_engines = {
      \ '_' : '-xelatex'
      \ }

function! CompleteNextWord()
  let dict = copilot#GetDisplayedSuggestion()
  let text = dict['text']
  let first = split(text, ' ')[0]
  return first . ' '
endfunction

inoremap <silent><expr> <C-l> CompleteNextWord()

cnoreabbrev vc VimtexCompile
