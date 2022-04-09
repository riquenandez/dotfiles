call plug#begin('~/.vim/plugged')
" telescope
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'

" neovim lsp
Plug 'neovim/nvim-lspconfig'
" Plug 'nvim-lua/completion-nvim'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'tzachar/cmp-tabnine', { 'do': './install.sh' }
Plug 'nvim-lua/lsp_extensions.nvim'
Plug 'onsails/lspkind-nvim'

" cmp ui
Plug 'glepnir/lspsaga.nvim'
Plug 'simrat39/symbols-outline.nvim'

" Snippets
Plug 'L3MON4D3/LuaSnip'
Plug 'rafamadriz/friendly-snippets'

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


Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'gruvbox-community/gruvbox'

call plug#end()

lua require("rico")
lua require'nvim-treesitter.configs'.setup { highlight = { enable = true }, incremental_selection = { enable = true }, textobjects = { enable = true }}

colorscheme gruvbox
highlight Normal guibg=none

let mapleader = " "

if executable('rg')
    let g:rg_derive_root='true'
endif

imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'
inoremap <silent> <S-Tab> <cmd>lua require'luasnip'.jump(-1)<Cr>

snoremap <silent> <Tab> <cmd>lua require('luasnip').jump(1)<Cr>
snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<Cr>

imap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
smap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'

" I hate escape more than anything else
inoremap jk <Esc>
inoremap kj <Esc>

nnoremap <leader>ghw :h <C-R>=expand("<cword>")<CR><CR>
nnoremap <leader>bs /<C-R>=escape(expand("<cWORD>"), "/")<CR><CR>

nnoremap <leader>pv :Ex<CR>
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <leader>u :UndotreeShow<CR>
nnoremap <Leader><CR> :so ~/.config/nvim/init.vim<CR>
nnoremap <Leader>+ :vertical resize +5<CR>
nnoremap <Leader>- :vertical resize -5<CR>
nnoremap <Leader>rp :resize 100<CR>

" moving text
vnoremap K :m '<-2<CR>gv=gv
vnoremap J :m '>+1<CR>gv=gv
inoremap <C-j> <esc>:m .+1<CR>==
inoremap <C-k> <esc>:m .-2<CR>==

nnoremap Y y$

" keeping cursor centered
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z

" Undo break points
inoremap , ,<c-g>u
inoremap . .<c-g>u
inoremap ! !<c-g>u
inoremap ? ?<c-g>u

"jumplist mutations
nnoremap <expr> k (v:count > 5 ? "m'" . v:count : "") . 'k'
nnoremap <expr> j (v:count > 5 ? "m'" . v:count : "") . 'j'

fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

augroup RICO
    autocmd!
    autocmd BufWritePre * :call TrimWhitespace()
augroup END
