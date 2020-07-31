call plug#begin('~/.vim/plugged')

Plug 'francoiscabrol/ranger.vim'
Plug 'lifepillar/vim-solarized8'
Plug 'joshdick/onedark.vim'
Plug 'tomasiser/vim-code-dark'
Plug 'pangloss/vim-javascript'
" CONSIDER HYBRID THEME
Plug 'dense-analysis/ale'

call plug#end()


""""""""""""""""""""""""""""""""""""""
"           GENERAL SETTINGS
""""""""""""""""""""""""""""""""""""""
set tabstop=4       "number of spaces per tab
set softtabstop=4   "number of spaces a tab counts for while editing
set expandtab       "expand tabs to spaces

set number          "turn line numbers on
set showcmd         "show current command
set cursorline      "highlight current line

set wildmenu        "show command autocomplete thingy
set showmatch       "show matching braces

" SEARCHING
set incsearch       "show search while typing
set hlsearch        "highlight search matches
" turn off search highlight with \<space>
nnoremap <leader><space> :nohlsearch<CR>

" FOLDING
set foldenable          "enable folding
set foldlevelstart=10   "folding starts at 10
set foldnestmax=10      "10 nested folds max
"set foldmethod=indent  "fold based on indent

set conceallevel=1      "allow concealing
""""""""""""""""""""""""""""""""""""""
"             THEME SETTINGS
""""""""""""""""""""""""""""""""""""""

set termguicolors   "Set truecolor
syntax enable       "Enable Syntax processing
set background=light "use dark theme
set t_Co=256        "set 256 colors
colorscheme onedark


""""""""""""""""""""""""""""""""""""""
"            LANGUAGES
""""""""""""""""""""""""""""""""""""""

" JAVASCRIPT
let g:javascript_plugin_flow = 1
