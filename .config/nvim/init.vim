"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
"  Python/Typescript Centric init.vim for neovim (https://neovim.io/)  
"
"  Brian Martin 2020
"  https://github.com/bmart
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ~> Vim Plug Auto Install hack from Fisa-dev  
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let vim_plug_just_installed = 0
let vim_plug_path = expand('~/.config/nvim/autoload/plug.vim')
if !filereadable(vim_plug_path)
    echo "Installing Vim-plug..."
    echo ""
    silent !mkdir -p ~/.config/nvim/autoload
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    let vim_plug_just_installed = 1
endif

" manually load vim-plug the first time
if vim_plug_just_installed
    :execute 'source '.fnameescape(vim_plug_path)
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ~> VimPlug plugin setup
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.config/nvim/plugged')



" Override configs by directory
Plug 'arielrossanigo/dir-configs-override.vim'

" Code commenter
Plug 'scrooloose/nerdcommenter'

" Better file browser
Plug 'scrooloose/nerdtree'

" Class/module browser
Plug 'majutsushi/tagbar'

" Search results counter
Plug 'vim-scripts/IndexedSearch'

" Airline
Plug 'vim-airline/vim-airline'

Plug 'vim-airline/vim-airline-themes'

" FZF
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Pending tasks list
Plug 'fisadev/FixedTaskList.vim'

" Jedi
Plug 'davidhalter/jedi-vim', { 'for': 'python' }

" Neomake
"Plug 'neomake/neomake'

" Surround
Plug 'tpope/vim-surround'

" Better language packs
Plug 'sheerun/vim-polyglot'

" Ack code search (requires ack installed in the system)
Plug 'mileszs/ack.vim'

" Paint css colors with the real color
Plug 'lilydjwg/colorizer'

" Window chooser
Plug 't9md/vim-choosewin'

" Automatically sort python imports
Plug 'fisadev/vim-isort'

" Generate html in a simple way
Plug 'mattn/emmet-vim'

" Git integration
Plug 'tpope/vim-fugitive'

" Git/mercurial/others diff icons on the side of the file lines
Plug 'mhinz/vim-signify'

" Icons for NERDTree
Plug 'ryanoasis/vim-devicons'

" Typescript / COC
Plug 'leafgarland/typescript-vim'
Plug 'neoclide/coc.nvim', {'branch' : 'release', 'do': 'yarn install --frozen-lockfile' }
"Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'ianks/vim-tsx'

" My Extras
Plug 'flazz/vim-colorschemes/'
Plug 'altercation/vim-colors-solarized'
Plug 'dikiaap/minimalist'
Plug 'skwp/greplace.vim'
Plug 'gruvbox-community/gruvbox'
Plug 'sainnhe/gruvbox-material'

" Tell vim-plug we finished declaring plugins, so it can load them
call plug#end()

" On first load ever, do this  ( fisa-dev ty) 
if vim_plug_just_installed
    echo "Installing Bundles, please ignore key map error messages"
    :PlugInstall
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ~> General Setup
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set noautoindent
let mapleader="\<Space>"
set nu

colorscheme delek
colorscheme monokai-phoenix
colorscheme gruvbox-material
set background=dark


" These two lines will allow nvim background to be transparent like the iterm
hi! Normal ctermbg=NONE guibg=NONE
hi! NonText ctermbg=NONE guibg=NONE guifg=NONE ctermfg=NONE


" Good outside colorscheme
"colorscheme srcery 

" split settings / note control-w c to close a split / also to resize  :resize
set splitbelow splitright
" Make adjusing split sizes a bit more friendly
noremap <silent> <C-Left> :vertical resize +3<CR>
noremap <silent> <C-Right> :vertical resize -3<CR>
noremap <silent> <C-Up> :resize +3<CR>
noremap <silent> <C-Down> :resize -3<CR>


nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

"tab navigation
map tt :tabnew 
map <Leader><Right> <ESC>:tabn<CR>
map <Leader><Left> <ESC>:tabp<CR>

" quickly close quick fix window
nnoremap <leader>c :cclose<CR>

"save current buffer
nnoremap <leader>w :w<cr>

" remove ugly vertical lines on window division
set fillchars+=vert:\ 

" needed so deoplete can auto select the first suggestion
set completeopt+=noinsert

" (displays documentation related to the selected completion option)
set completeopt-=preview

" autocompletion of files and commands behaves like shell
set wildmode=list:longest

" when scrolling, keep cursor 3 lines away from screen border
set scrolloff=3

" clear empty spaces at the end of lines on save of python files
autocmd BufWritePre *.py :%s/\s\+$//e

" fix problems with uncommon shells (fish, xonsh) and plugins running commands
set shell=/bin/bash 


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ~> Language / Tool Setup
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" TYPESCRIPT
"let g:coc_global_extensions = ['coc-tslint-plugin', 'coc-tsserver', 'coc-emmet', 'coc-css', 'coc-html', 'coc-json', 'coc-yank', 'coc-prettier']
au BufNewFile,BufRead *.ts setlocal filetype=typescript
au BufNewFile,BufRead *.tsx setlocal filetype=typescript.tsx


" PYTHON
let g:python_highlight_all = 1
"au FileType python map <silent> <leader>d breakpoint()<esc>

" Git
map <c-g>f :2,$ s/^pick/f/<CR>
map <c-g>s :2,$ s/^pick/s/<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ~> Plugin Customizations
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" COC
nmap <leader>gd <Plug>(coc-definition)
nmap <leader>gy <Plug>(coc-type-definition)
nmap <leader>gi <Plug>(coc-implementation)
nmap <leader>gr <Plug>(coc-references)
nmap <leader>rr <Plug>(coc-rename)
nmap <leader>g[ <Plug>(coc-diagnostic-prev)
nmap <leader>g] <Plug>(coc-diagnostic-next)
nmap <silent> <leader>gp <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>gn <Plug>(coc-diagnostic-next)

let g:coc_global_extensions = [
  \ 'coc-snippets',
  \ 'coc-pairs',
  \ 'coc-tsserver',
  \ 'coc-eslint', 
  \ 'coc-prettier', 
  \ 'coc-json', 
  \ ]

"
" -- Control P --
"
"nmap <c-R> :CtrlPBufTag<cr>
"nmap <c-e> :CtrlPMRUFiles<cr>
"let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|.git\|\*.js'
"let g:ctrlp_match_window = 'top,order:ttb,min:1,max:30,results:20'

" 
" -- TagBar --
"
nmap <Leader>tb :TagbarToggle<CR>
let g:tagbar_autofocus = 1

" 
" -- NerdTree --
"
nmap <Leader>e :NERDTreeToggle<CR>
nmap ,e :NERDTreeFind<CR>
let NERDTreeIgnore = ['\.pyc$', '\.pyo$']

" 
" -- TaskList --
"
map <F2> :TaskList<CR>

" 
" -- FZF --
"
nmap <Leader>f :Files<CR>
" tags (symbols) in current file finder mapping
nmap <Leader>g :BTag<CR>
" tags (symbols) in all files finder mapping
nmap <Leader>G :Tags<CR>
" general code finder in all files mapping
nmap <Leader>F :Lines<CR>
" commands finder mapping
nmap ,c :Commands<CR>

" 
" -- Jedi-Vim --
"
" Go to definition
let g:jedi#goto_command = ',d'
" Find ocurrences
let g:jedi#usages_command = ',o'
" Find assignments
let g:jedi#goto_assignments_command = ',a'
" Go to definition in new tab
nmap ,D :tab split<CR>:call jedi#goto()<CR>

" need showmode off for call signatures in command line  no{option}
set noshowmode
let g:jedi#show_call_signatures = 2

"
" --  Airline --
"
let g:airline_powerline_fonts = 1
let g:airline_theme = 'solarized_flood'
let g:airline#extensions#whitespace#enabled = 0


"
" --  Fugitive --
"
nnoremap <leader>b :Gblame<CR>


"
" -- Neomake  --
"
"autocmd! BufWritePost * Neomake
"let g:neomake_python_python_maker = neomake#makers#ft#python#python()
"let g:neomake_python_flake8_maker = neomake#makers#ft#python#flake8()
"let g:neomake_python_python_maker.exe = 'python3 -m py_compile'
"let g:neomake_python_flake8_maker.exe = 'python3 -m flake8'

" Disable error messages inside the buffer, next to the problematic line
"let g:neomake_virtualtext_current_error = 0
"let g:neomake_python_enabled_makers = ['flake8']




"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ~> env related customizations (optional)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if filereadable(expand("~/.config/nvim/custom.vim"))
  source ~/.config/nvim/custom.vim
endif

if filereadable(expand("~/.config/nvim/ben.vim"))
  source ~/.config/nvim/ben.vim
endif
