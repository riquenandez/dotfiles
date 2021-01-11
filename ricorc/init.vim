" shoutout to awesome-streamerrc/ThePrimeagen/

call plug#begin('~/.vim/plugged')
" telescope
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" neovim lsp
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'tjdevries/nlua.nvim'
Plug 'tjdevries/lsp_extensions.nvim'

" treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

"Plug 'rust-lang/rust.vim'
Plug 'tweekmonster/gofmt.vim'
Plug 'tpope/vim-fugitive'
Plug 'vim-utils/vim-man'
Plug 'mbbill/undotree'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'stsewd/fzf-checkout.vim'

"todo manager
Plug 'vuciv/vim-bujo'

"run build & test suite async
"Plug 'tpope/vim-dispatch'
" Projections configuration
"Plug 'tpope/vim-projectionist'

" practice vim speed
"Plug 'theprimeagen/vim-be-good'

Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'gruvbox-community/gruvbox'
call plug#end()

lua require'nvim-treesitter.configs'.setup { highlight = { enable = true } }

colorscheme gruvbox
highlight Normal guibg=none

let mapleader = " "

if executable('rg')
    let g:rg_derive_root='true'
endif

" I hate escape more than anything else
inoremap jk <Esc>
inoremap kj <Esc>

nnoremap <leader>ghw :h <C-R>=expand("<cword>")<CR><CR>
nnoremap <leader>bs /<C-R>=escape(expand("<cWORD>"), "/")<CR><CR>

nnoremap <leader>pv :Sex!<CR>
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <leader>u :UndotreeShow<CR>
nnoremap <Leader><CR> :so ~/.config/nvim/init.vim<CR>
nnoremap <Leader>+ :vertical resize +5<CR>
nnoremap <Leader>- :vertical resize -5<CR>
nnoremap <Leader>rp :resize 100<CR>
vnoremap K :m '<-2<CR>gv=gv
vnoremap J :m '>+1<CR>gv=gv

fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

augroup RICO
    autocmd!
    autocmd BufWritePre * :call TrimWhitespace()
augroup END
