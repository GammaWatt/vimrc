" ############################################################################
" INTRO AND NOTES ON THIS FILE AND VIM DIRS
" ############################################################################
" This file is for making vim / nvim replicate many of the features in Sublime and Atom
" Atom is too fat and heavy for my taste, but it has some really nifty
" functions that I got used to, and Vim / Nvim are the only decent and lightweight
" editors I could find.
" 
" This file doesn't seem to work for Vim, though... no idea why...
" It might be some of my plugins...?
"
" Super useful website for vimrc / init.vim config
" https://medium.com/life-at-moka/step-up-your-game-with-neovim-62ba814166d7"

" To get ag (the silver searcher)
" (normally) https://github.com/ggreer/the_silver_searcher 
" (For windows) https://github.com/JFLarvoire/the_silver_searcher
"
" Ag will filter files and folders based on .gitignore or .hgignore files

" On XDG Desktops, it goes in ~/.config/nvim/init.vim 
" And plugins go in ~/.local/share/nvim/site/pack/*/start

" To install vim-plug (for plugins)
" (Vim)
" iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim |`
"    ni $HOME/vimfiles/autoload/plug.vim -Force
" (NeoVim)
" iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim |`
"    ni "$(@($env:XDG_DATA_HOME, $env:LOCALAPPDATA)[$null -eq $env:XDG_DATA_HOME])/nvim-data/site/autoload/plug.vim" -Force

" Automatically install Vim-plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif



" ############################################################################
" Notes on this vimrc and Vim usage
" ############################################################################
"
"   --------------------------------------------------------------------------
"   In mapping functions / instructions:
"   --------------------------------------------------------------------------
"   x is visual mode (default v)
"   v is visual and select mode (supposedly, but doesn't work for me)
"   i is insert mode (default i)
"   s is select mode (default <C-g> while in v mode to toggle s/v modes)
"   o is operator-pending mode
"   n is normal mode
"   l insert, and command mode
"   t terminal mode (:term) (<C-\>N exits to normal mode)
"   c is command mode (default :)
"
"   --------------------------------------------------------------------------
"   List of Vim Modes:
"   --------------------------------------------------------------------------
"   * Normal mode
"   * Insert mode
"   * Visual mode
"   * Select mode
"   * Command mode
"   * Operator-pending mode
"   * Ex mode
"   * Replace mode
"
"
" Note: 
"   Vim does not require multiple cursors, because visual block mode can be
"       used to achieve the same effects. Especially if mixed with :s which is
"       used for regex-based search and replace. Visual block mode makes
"       it possible to insert, delete, and edit in several places
"       simultaneously
"
" Notes:
"   * Vim has registers (:h registers). + and * are super useful. They
"       are accessed via "+ and "*.
"
" Safe Keys:
"   Keys that are commonly unused, or infrequently used in normal mode:
"       -, H, L, <Space>, <CR>, <BS>, <S-Space>, <S-BS>
"
" Vim Keys:
"   * <C-v> Visual block mode. Select in blocks. Does same as multi-cursors
"   * u undo
"   * <C-r> redo
"
" 
" Mapping Commands:
"   noremap (works for me)
"   vnoremap (doesn't work for me)
"   xnoremap (supposed to be only visual mode)
"   inoremap (supposed to be only insert mode)
"
" Default Command Notes:
"   * in insert mode <C-o> to use a normal mode command and resume insert mode
"   * To remove highlighting until next search :noh
"   * == auto-idents / formats text
"   * gg go to top of file
"   * G go to bottom of file
"   * gg=G go to top of file, and auto-indent everything from top to bottom
"   * [number]G go to line number
"   * [number]gg go to line number
"   * :term open default term. Told by env, or vimrc let &shell or set shell
"   * :! for calling an external command
"   * :!wc % calls external cmd wc on %, and % is short for the current file
"   * :x save and close (equivalent to :wq)
"   * :xa save and close all tabs (equivalent to :wqa)
"   * :mksession [filename] save current vim session
"   * :source [filename] load vimscript/vimrc file or load saved session file
"   * :messages view messages vim has givenm like warnings and errors
"   * :messages clear clear vim messages
"   * "+y copy to system clipboard (clipboard used by ctrl-c)
"   * "*y copy to system primary clipboard
"   * "+p paste from system clipboard (clipboard used by ctrl-c)
"   * "*p paste from system primary clipboard
"   * :map to list all current keyboard mappings (same for all permutations)
"   * :imap (permutation of :map) does the same thing, but for insert mode
"   * :vs **/*<partial filename><Tab> Basically vim's own fuzzy search


" ############################################################################
" Vim-Plug NOTES
" ############################################################################
" Command Notes:
"   * :PlugInstall! to get/update plugins listed between plug#begin & Plug#end
"   * :PlugClean! to remove plugins remove from the list
"   * :PlugUpdate! to update installed plugins

echom "Starting Vim"
echom "Loading vimrc..."


" Check OS type
if !exists("g:os")
    echom "Detecting OS"
    if has("win64") || has("win32") || has("win16")
        let g:os = "Windows"
        echom "Windows detected"
    else
    	" I don't know nothing about OSes outside of *BSD, Linux, or Windows, since I don't use them...
        let g:os = substitute(system('uname'), '\n', '', '')
	let plugin_dir = fnamemodify("$MYVIMRC", ":p:h")."/home/".$USER."/.config/nvim/plugged"
	set rtp+=plugin_dir
    endif
endif


" If on Windows, PowerShell is useless as a terminal for vim.
" It does not correctly handle stdin, stdout, or stderr. It's just a black box.
" It excecutes the command and returns, returning no output whatsoever.
" If you insist or just want to launch it with :term and never use :! commands,
" then set shellcmdflag=-Command
"
" MinTTy doesn't work either. It just launches as a separate window
" and returns no output. So git-bash mintty doesn't work as
" a shell for vim, either.

" The only real option on Windows is CMD


" Get Nerd fonts for devicons (still only show as boxes for me, it don't work)
" https://github.com/ryanoasis/nerd-fonts
" https://www.nerdfonts.com/


" ############################################################################
" Vim Global Settings
" ############################################################################
"
" Required to avoid bugs when loading plugins
set nocompatible
filetype off
"
" Remove spacebar functionality in normal mode so we can make it useful
nnoremap <Space> <Nop>
" Remove backspace functionality in normal mode so we can make it useful
nnoremap <BS> <Nop> 
" Set map leader to spacebar
" let mapleader="\<Space>"
" let mapleader="\\"
let mapleader="\<F3>" 


" ------------------------------------------------------------
" Dependencies for some plugins in this file
" ------------------------------------------------------------
"
" * Vue-plug
" * Perl
" * Ack3              (https://github.com/beyondgrep/ack3)
" * Delta             (https://github.com/dandavison/delta)
" * Ag (not windows)  (https://github.com/ggreer/the_silver_searcher)
" * Ag (windows)      (https://github.com/k-takata/the_silver_searcher-win32)
" * Ripgrep           (https://github.com/BurntSushi/ripgrep)
" * Bat               (https://github.com/sharkdp/bat)
" * Nodejs
" * Yarn


" -----------------------------------------------------------
"  How to Install Perl modules
" -----------------------------------------------------------
"
" 1) tar-xzpvf module.tar.gz
" 2) cd module.18
" 3) perl Makefile.PL
" 4) make test        (or use gmake for strawberry perl in win)
" 5) make install
" 6) (sometimes necessary, usually not) perl -MCPAN -e install module
" 7) perl -Mmodule -E'say "all set!"'


" ------------------------------------------------------------
" Initialize plugins
" ------------------------------------------------------------
" =~# in vimscript does case-sensitive regex matching.
if $VIM =~# '[^a-zA-Z0-9-_:]n[vV]im$'
  " For nvim
  let nvimrc_home = fnamemodify($MYVIMRC, ':p:h')
  call plug#begin(nvimrc_home.'/plugged')
elseif $VIM =~# '[^a-zA-Z0-9-_:][vV]im$'
  " For vim
  let vimrc_home = fnamemodify($MYVIMRC, ':p:h') 
  call plug#begin(vimrc_home.'/plugin')
endif


" File explorer pane NERDTree (Usage: (t -> open in new tab, o -> new pane))
" Lazy load NERDTree
" Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }

" NERDTree caused session loading problems for me. And behaved slowerly.

" Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
" Plug 'Xuyuanp/nerdtree-git-plugin'

" use sign column to show added, modified or removed lines in vcs managed files
Plug 'mhinz/vim-signify'


Plug 'rafi/awesome-vim-colorschemes'

Plug 'sheerun/vim-polyglot'

" Show mark labels on left side of window
Plug 'kshenoy/vim-signature'

" CoC Intellisense Engine (Run :CocInstall coc-explorer to replace NERDTree)
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Git plugin for vim
Plug 'tpope/vim-fugitive'

Plug 'tpope/vim-git'

" Auto commenting
Plug 'preservim/nerdcommenter'

" Ripgrep. Display results in quickfix list (:Rg <pattern> and :Rgroot)
Plug 'jremmen/vim-ripgrep'


" cs"' == "Hi" to 'Hi'. cs"<p> == "Hi" to <p>Hi</p>. ds" "hi":hi. More at repo
Plug 'tpope/vim-surround'

" Insert or delete brackets, parens, quotes in pair
Plug 'jiangmiao/auto-pairs'

" Html tag matching
Plug 'adelarsq/vim-matchit'

" fuzzy file finder FZF
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

" Easy align stuff like a table
Plug 'junegunn/vim-easy-align'

" Async code search and view tool (never returned any results for me)
" Plug 'dyng/ctrlsf.vim'

" Autoclose html tags (e.g. write <html>, then press > again)
Plug 'alvan/vim-closetag'

" Vue syntax highlighting
Plug 'storyn26383/vim-vue'

" Better status bar
Plug 'vim-airline/vim-airline'

" Faster finding in active files (s{char}{char})
Plug 'justinmk/vim-sneak'

" Vim snippet engine
Plug 'garbas/vim-snipmate'

" Incremental search. Replaces default vim search.
Plug 'haya14busa/incsearch.vim' 

" Dependency for bootstrap-snippets (Autointerpret a file by func and cache file)
Plug 'MarcWeber/vim-addon-mw-utils' 

" Dependency for bootstrap-snippets (These are util funcs)
Plug 'tomtom/tlib_vim'

" HTML and Bootstap snippets for vim-snipmate
Plug 'bonsaiben/bootstrap-snippets' 

" Code Snippets for code boilerplate and such for vim-snipmate
Plug 'honza/vim-snippets'

" Common code snippets I used in Atom (requires vim-snipmate and vim-snippets)
Plug 'GammaWatt/vim-dribble-snips' 

" Must always be loaded last
" Plug 'ryanoasis/vim-devicons'

call plug#end() 



" ------------------------------------------------------------
" incsearch config
" ------------------------------------------------------------
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay) 



" ------------------------------------------------------------
" vim-signatures
" ------------------------------------------------------------
" Toggle vim-signature showing marks (this is buffer-specific)
nmap <leader><leader>m :SignatureToggle<CR>
" If marks desync, refresh them.
nmap <leader><leader>;; :SignatureRefresh<CR>



" ------------------------------------------------------------
" vim-snipmate configuration
" ------------------------------------------------------------
"
" Recursive map is necessary for this to work (i.e. imap, not inoremap)
" Press <C-Tab> to insert code snippets according to the prefix you typed
" This plugin activates with 
" <Plug>snipMateNextOrTrigger or
" <Plug>snipMateTrigger
imap <leader><leader><Tab> <Plug>snipMateNextOrTrigger
" SnipMate parse is deprecated. Use this instead (see :h SnipMate-deprecate)
let g:snipMate = { 'snippet_version': 1 }
" When loading scope 'ruby', load, instead, ruby-rails
" let g:snipMate.scope_aliases = {}
" let g:snipMate.scope_aliases['ruby'] = 'ruby,rails'



" ------------------------------------------------------------
" vim-closetag configuration
" ------------------------------------------------------------
"
" filenames like *.xml, *.html, *.xhtml, ...
" These are the file extensions where this plugin is enabled.
let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.vue'
" filenames like *.xml, *.xhtml, ...
" This will make the list of non-closing tags self-closing in the specified files.
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx'
" Shortcut for closing tags, default is '>'
let g:closetag_shortcut = '>'
" Add > at current position without closing the current tag, default is ''
let g:closetag_close_shortcut = '<leader>>'



" ------------------------------------------------------------
" auto-pairs configuration
" ------------------------------------------------------------
"
let g:AutoPairsShortcutToggle = '<C-P>'



" ------------------------------------------------------------
" ctrlsf configuration
" ------------------------------------------------------------
"
" let g:ctrlsf_backend = 'ack'
" let g:ctrlsf_backend = 'ag'
" let g:ctrlsf_auto_close = { "normal": 0, "compact": 0 }
" let g:ctrlsf_auto_focus = { "at": "start" }
" let g:ctrlsf_auto_preview = 0
" let g:ctrlsf_case_sensitive = 'smart'
" let g:ctrlsf_default_view = 'normal'
" let g:ctrlsf_regex_pattern = 0
" let g:ctrlsf_position = 'right'
" let g:ctrlsf_winsize = '46'
" let g:ctrlsf_default_root = 'cwd'   " projcet

" Open for search
" nnoremap <leader><C-f>F :CtrlSF<Space>
" Toggle search pane (Does not close ctrlsf)
" nnoremap <leader><C-b>\ :CtrlSFToggle<CR>



" ------------------------------------------------------------
" Nerd Commenter
" ------------------------------------------------------------
"
"   ==================================================
"   Default bindings
"   ==================================================
"   <leader>cc comment 
"   <leader>cu uncomment
"   
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1
" Enable NERDCommenterToggle to check all selected lines is commented or not
let g:NERDToggleCheckAllLines = 1
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1


" " ------------------------------------------------------------
" " NERDTree Configuration (:h NERDTree)
" " ------------------------------------------------------------
" " If another buffer tries to replace NERDTree, put it in the other window, and
" " bring back NERDTree.
" " autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
  " " \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif
" " Enables folder icon highlighting using exact match
" let g:NERDTreeHighlightFolders = 1
" " Highlights the folder name
" let g:NERDTreeHighlightFoldersFullName = 1
" " Color customization
" let s:brown = "905532"
" let s:aqua =  "3AFFDB"
" let s:blue = "689FB6"
" let s:darkBlue = "44788E"
" let s:purple = "834F79"
" let s:lightPurple = "834F79"
" let s:red = "AE403F"
" let s:beige = "F5C06F"
" let s:yellow = "F09F17"
" let s:orange = "D4843E"
" let s:darkOrange = "F16529"
" let s:pink = "CB6F6F"
" let s:salmon = "EE6E73"
" let s:green = "8FAA54"
" let s:lightGreen = "31B53E"
" let s:white = "FFFFFF"
" let s:rspec_red = 'FE405F'
" let s:git_orange = 'F54D27'
" " " This line is needed to avoid error
" let g:NERDTreeExtensionHighlightColor = {}
" " " Sets the color of css files to blue
" let g:NERDTreeExtensionHighlightColor['css'] = s:blue
" " " This line is needed to avoid error
" let g:NERDTreeExactMatchHighlightColor = {}
" " " Sets the color for .gitignore files
" let g:NERDTreeExactMatchHighlightColor['.gitignore'] = s:git_orange
" " " This line is needed to avoid error
" let g:NERDTreePatternMatchHighlightColor = {}
" " " Sets the color for files ending with _spec.rb
" let g:NERDTreePatternMatchHighlightColor['.*_spec\.rb$'] = s:rspec_red
" " " Sets the color for folders that did not match any rule
" let g:WebDevIconsDefaultFolderSymbolColor = s:beige
" " " Sets the color for files that did not match any rule
" let g:WebDevIconsDefaultFileSymbolColor = s:blue
" " Sets the color for .gitignore files
" let g:NERDTreeExactMatchHighlightColor['.gitignore'] = s:git_orange
" " NERDTree Git Plugin
" let g:NERDTreeGitStatusIndicatorMapCustom = {
  " \ "Modified"  : "✹",
  " \ "Staged"    : "✚",
  " \ "Untracked" : "✭",
  " \ "Renamed"   : "➜",
  " \ "Unmerged"  : "═",
  " \ "Deleted"   : "✖",
  " \ "Dirty"     : "✗",
  " \ "Clean"     : "✔︎",
  " \ 'Ignored'   : '☒',
  " \ "Unknown"   : "?"
  " \ }
" " Change default arrows
" let g:NERDTreeDirArrowExpandable = '▸'
" let g:NERDTreeDirArrowCollapsible = '▾'
" " Change cwd to parent node
" let g:NERDTreeChDirMode = 3
" " Hide help text
" let g:NERDTreeMinimalUI = 1
" " Remove buffer when file renamed or deleted via NERDTree
" let g:NERDTreeAutoDeleteBuffer = 1
" " Show hidden files by default
" let g:NERDTreeShowHidden = 1
" " ignore node_modules to increase load speed
" let g:NERDTreeIgnore = ['^node_modules$']
" " set to empty to use lightline
" let g:NERDTreeStatusline = ''
" "    =============================================
" "    NERDTree Default Mappings
" "    =============================================
" "    gi     Preview file
" "    t      Open node in tab
" "    T      Open node in tab, without switching
" "    s      Open node in new vsplit
" "    gs     Open node in new vsplit, no switch
" "    O      Recursively open dir
" "    X      Recursively close dir
" "    e      Edit current dir
" "    P      Jump to root node
" "    C      Change tree root to selected dir
" "    u      Move tree root up one dir
" "    U      Same as u, but leave old root open
" "    r      Recursively refresh current dir
" "    cd     change cwd to dir of selected node
" "    CD     change root to cwd
" "    I      Toggle hidden files
" "    f      Toggle file filters
" "    F      Toggle files
" "    B      Toggle bookmark table
" "    q      Close NERDTree window
" "    A      Zoom (maximize/mnimize) NERDTree window
" "    ?      Toggle quick help
" "    =============================================
" "    NERDTree Key Mappings
" "    =============================================
" "    Remap key for context menu to fix conflict with vim-signature
   " let g:NERDTreeMapMenu=','
" "    Open NERDTree Nodes with l
   " let g:NERDTreeMapActivateNode='l'
" "    Close NERDTree Nodes with h
   " let g:NERDTreeMapCloseDir='h'
" "    Navigate NERDTree to [dir] (cwd is default)
   " nnoremap <leader>Nf :NERDTreeFind<Space>
" "    Refresh NERDTree root
   " nnoremap <leader>Nr :NERDTreeRefreshRoot<CR>
" "    Toggle NERDTree
   " nnoremap <leader>Nk :NERDTreeToggle<CR>
" "    Toggle NERDTreeVCS (for git, svn, hg, etc...)
   " nnoremap <leader>Nv :NERDTreeToggleVCS<CR>
" "    Mirror NERDTree to last buffer
   " nnoremap <leader>NK :NERDTreeMirror<CR>
" "    Change NERDTree context menu key. Avoids conflict with vim-signatures
"
       


" ------------------------------------------------------------
" Coc File Explorer
" ------------------------------------------------------------
nnoremap <leader>e :CocCommand explorer<CR>
nnoremap <leader>f :CocCommand explorer --preset floating<CR>
autocmd BufEnter * if (winnr("$") == 1 && &filetype == 'coc-explorer') | q | endi

" let g:coc_node_path = '/snap/bin/node'

" ------------------------------------------------------------
" FZF
" ------------------------------------------------------------
"
" Set FZF backend to Ag
let $FZF_DEFAULT_COMMAND = 'ag -g ""'
" Set ctrl-f as shortcut to search for files (putting <silent> removes the echo)
noremap <silent> <leader><C-f>F :Files<CR>
" Set ctrl-F as shortcut to search contents of files
noremap <leader><C-f>f :Ag<CR>



" https://gist.github.com/csswizardry/9a33342dace4786a9fee35c73fa5deeb
" 
" https://www.chiarulli.me/Neovim/06-file-explorer/

" https://engagor.github.io/blog/2018/02/21/why-vim-doesnt-need-multiple-cursors/

" https://github.com/danebulat/vim-config/tree/master/light-ide 

" https://www.xspdf.com/resolution/2141012.html 

" http://vim-wiki.mawercer.de/wiki/topic/text-snippets-skeletons-templates.html

" https://www.reddit.com/r/vim/comments/8h044y/vim_git_plugins/

" https://stackoverflow.com/questions/4226905/vim-nerdtree-not-recovered-in-session-restore
"
" https://github.com/thoughtbot/dotfiles/blob/master/vimrc
"
" https://thoughtbot.com/blog/vim-splits-move-faster-and-more-naturally
"
" https://www.reddit.com/r/vim/wiki/the_leader_mechanism
"
" https://www.reddit.com/r/vim/comments/9zzk6p/how_to_properlyeffectively_use_the_leader_key/
" 
" https://medium.com/@schtoeffel/you-don-t-need-more-than-one-cursor-in-vim-2c44117d51db
"
" https://opensource.com/article/19/2/getting-started-vim-visual-mode
"
" https://learn.perl.org/
" 
" https://wiki.nikitavoloboev.xyz/text-editors/vim/vim-plugins 
"
" https://learnvimscriptthehardway.stevelosh.com/chapters/06.html
" vim automatic boilerplate
" https://www.educba.com/perl-vs-php/
" https://vim.fandom.com/wiki/Backspace_and_delete_problems
" https://www.reddit.com/r/vim/comments/2xnbpo/how_do_you_guys_handle_boilerplate_code/
" https://jdhao.github.io/2019/06/26/movement_navigation_inside_nvim/

" https://techinscribed.com/91-vim-keyboard-shortcuts/
" https://www.maketecheasier.com/cheatsheet/vim-keyboard-shortcuts/
" http://www.allhotkeys.com/vim-hotkeys.html
" https://linuxhint.com/vim_modes/

" All of these commented options either didn't load or caused issues
" ****************************************************************************
" Autostart NERDTree on start vim and put the cursor back in the other window
" ****************************************************************************
" autocmd VimEnter * NERDTree | wincmd p

" ****************************************************************************
" Close window if NERDTree is the last one Only works when last buffer in
" window
" ****************************************************************************
" autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && 
"   \ exists('b:NERDTree') && b:NERDTree*isTabTree() |
"   \ quit | endif

" ****************************************************************************
" Close window/buffer if NERDTree is the last tab (Makes errors. just use :qa)
" ****************************************************************************
" autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && 
"   \ b:NERDTree*isTabTree()) | q | endif
" autocmd BufEnter * if (winnr("$") == 1
"    \ && exists("b:NERDTree")) |
"    \ q | endif

" ****************************************************************************
" Auto close NERDTree on vim close. Stop sess errs if NERDTree autostart w/vim
" ****************************************************************************
" autocmd VimLeave * NERDTreeTabsClose | quit

" ****************************************************************************
" Automatically save session upon closing vim
" ****************************************************************************
"autocmd VimLeave * mksession! last_session.vimsession




" set guifont=Liberation\ Mono:h7.1     " Set font (produces warning on neovim)
set encoding=UTF-8                    " Set encoding
set noerrorbells visualbell t_vb=     " Disable bell sounds 
set autochdir                         " Working dir is always sync with buffer
set background=dark                   " Set background 
set number                            " Enable line numbers
set relativenumber                    " Show row numbers relative to current
set nowritebackup                     " set to never save backup                                 
set noswapfile                        " set no swap file 
set nobackup                          " set no backup file
set wrap                              " Make lines wrap
set wildmenu                          " Show file options above cmd line
set autochdir                         " Automatically set cwd to dir of file
colo torte                            " Set colorscheme to torte
set bs=indent,eol,start              " :h backspace 

" Don't offer to open certain files/directories
set wildignore+=node_modules/*,bower_components/*


" Enable highlighting matching parenthesis
let loaded_matchparen = 1

" Autocompletion
filetype plugin indent on
set omnifunc=syntaxcomplete#Complete

" Make it so that mouse interacts with editor like normal stuff
" set mouse=a

" Prevent mouse interaction from triggering visual mode
set mouse-=a 
" Another possible option is supposedly `set mouse=nicr` if above doesn't
" work


" Line number, column number, and relative position of cursor as a percentage
set ruler

" Show the current static always.
set laststatus=2


" Prevent new line when wrapping
set textwidth=0

" Highlight characters that overflow the column limit
highlight OverLength ctermbg=darkred ctermfg=white guibg=#FFD9D9
match OverLength /\%>80v.\+/

" Set column limit for automatic hard break at 80 columns (or chars)
" Limits width of entire window in tty
" set columns=80

" Break by word instead of character. This automatically adds a newline when
" it adds a linebreak.
set linebreak

" No idea what this does
" filetype plugin on
" filetype indent on

" Syntax highlighting
syntax enable
syntax on

" Pastemode
" set paste
" Turn it off
" set nopaste


" To use system clipboard for cut and paste (works, but not the way I want it)
" set clipboard+=unnamedplus

" For autoindent
set autoindent smartindent

set breakindent " set every wrapped line will continue visually indented     

set smartcase " set to be case sensitive when there is capital letter, this need set incsearch to work
set incsearch " set search to be case insensitive

" Convert tabs into spaces automatically (2 spaces == 1 tab)
set shiftwidth=0 tabstop=2 softtabstop=0 expandtab smarttab

" Set where vim places new panes by default
set splitbelow
set splitright


" ############################################################################
" Vim Commands
" ############################################################################
" :ls       list buffers
" :ls!      list ALL buffers
" :bw       wipeout buffer [number], like really delete it
" :bd       delete buffer [number] (e.g. :bd 3). Default val is current buf
" :bd!      delete buffer [number] and discard unsaved changes

" ############################################################################
" Vim Keymapping Limitations
" ############################################################################
" * <C-f> and <C-S-f> will map to the same thing. So mapping to Ctrl-f and
"   Ctrl-F separately cannot be achieved without compromising compatibility
"   by modifying xterm settings on some terminals, or enabling features that
"   are disabled by default, or may not be available. (It IS possible, 
"   however, to map Alt-f and Alt-F separately. So <M-f> and <M-S-f> may
"   be used for separate mappings)


" ############################################################################
" Native Vim Maps (Just for reference, these are in vim by default)
" ############################################################################
" Normal Mode:
"   <C-w>v  open vertical pane (shares current buffer)
"   <C-w>s  open horizontal pane (shares current buffer)
"   <C-w><  decrease pane width
"   <C-w>>  increase pane width
"   <C-w>+  increase pane height
"   <C-w>-  decrease pane height
"   <C-w>=  reset panes to equal height and width
"   <C-w>L  move pane to far right
"   <C-w>H  move pane to far left
"   <C-w>J  move pane to very bottom
"   <C-w>K  move pane to very top
"   <C-w>r  rotate panes down/right
"   <C-w>R  rotate panes up/left
"   ZZ      (in normal mode) Save file and quit current window/pane (!kill buf)
"   ZQ      (in normal mode) Quit current window / pane without saving file
"   u       undo
"   <C-r>   redo
"   dG      delete to end of file
"   dgg     delete to beginning of file
"   i       enter insert mode at current char position
"   I       enter insert mode at beginning of line
"   o       enter insert mode after inserting a new line below
"   O       enter insert mode after inserting a new line above
"   a       enter insert mode after current char
"   A       enter insert mode at end of line
"   s       enter insert mode after clearing current char
"   S       enter insert mode after clearing current line
"   c
"   cc      enter insert mode after clearing current line
"   (       Go to previous line break
"   )       Go to next line break
"   0       Move to beginning of line
"   [       
"   ]
"   %       Go to matching bracket
"   {        
"   }
"   y       copy selected text
"   yy      copy line
"   yw      copy word
"   Q       enter Ex mode
"   v
"   V
"   r
"   R
"   w
"   W
"   e
"   E
"   b
"   B
"   #       Go to previous occurrence of current word
"   *       Go to nextoccurrence of current word
"   f
"   F
"   t
"   T
"   ~       Toggle case of current char
"   guu
"   gUU
"   ;       Repeat f, F, T, and t commands
"   ,       Same as ;, but in the other direction
"   .
"   <C-x><C-o>  Vim omnicompletion (insert mode only)
"   ma      Create mark named a (any a-z) (good for forgotten imports in py)
"   `a      Go to exact position mark a is
"   'a      Go to line mark a is on'
"   gf      Open file under cursor (unused in this vimrc. remapped below)
"   q[letter] Record actions as macro. (q to finish)
"   @[letter] Execute recorded macro.
"
" Visual Mode:
"   <C-v>   visual block mode
"   V       visual line mode
"   v       visual char mode
" Replace Mode:
"   R       Replace mode
" Insert Mode:
"   <C-u>   Delete text you typed in current line.
"   <C-w>   Delete word before cursor.


" ############################################################################
" Keyboard Mappings
" ############################################################################
" Remove match highlight
nnoremap <silent> <Esc> <Esc>:noh<CR> 
" Save file (without quitting)
" nnoremap <leader><M-s> :w<CR>
nnoremap ZS :w<CR> 
" Save all open files (without quitting)
nnoremap <leader><M-S-Z> :wa<CR>
" Quit  (ZQ)
nnoremap <leader><M-q> :q<CR>
" Quit all
nnoremap <leader><M-S-q> :qa<CR>
" Quit and save all tabs
nnoremap <leader>ZX :qwa<CR>
" Open new tab
nnoremap <leader><leader>t :tabnew<CR>
" Open vertical pane
nnoremap <leader><leader>v :vsp<CR>:wincmd p<CR>
" Open horizontal pane
nnoremap <leader><leader>h :sp<CR>:wincmd p<CR>
" Open terminal in new tab
nnoremap <leader><leader><M-t> :tabnew<CR>:terminal<CR>i
" Open terminal in new vertical pane
nnoremap <leader><leader><M-v> :vsp<CR>:wincmd p<CR>:terminal<CR>i
" Open terminal in new horizontal pane
nnoremap <leader><leader><M-s> :sp<CR>:wincmd p<CR>:terminal<CR>i
" Make it easy to navigate panes
noremap <C-J> <C-W>j
noremap <C-K> <C-W>k
noremap <C-H> <C-W>h
noremap <C-L> <C-W>l
" Make paste easy access in insert mode
inoremap <C-Space><C-v> <C-o>"+p
" remap gf to open file below cursor in vert split. Good for explor proj deps.
nnoremap gf :vertical wincmd f<CR>

nnoremap <leader>]b :bnext<CR>
nnoremap <leader>[b :bprevious<CR>
nnoremap <leader>]B :blast<CR>
nnoremap <leader>[B :bfirst<CR>
nnoremap <leader>!b :ls!<CR>

" Quickly switch to buffer by its number. [bufnum]<leader>gb
nnoremap <leader>gb :<C-U>exe ":buffer " . v:count1<CR>


" Toggle relative numbering
nnoremap yr :set<Space>relativenumber!<CR>

if g:os == "Windows"
	" (Windows only, for Cygwin) Open bash prompt at current dir (or run bash args
	" if any provided)
	command -nargs=* Cygwin execute '!'.$CYGWIN_HOME.'\bin\mintty.exe -i /Cygwin-Terminal.ico  '.$CYGWIN_HOME.'\bin\bash  -l -c "cd \"'.fnameescape(getcwd()).'\" ; exec bash"'.<q-args>

	" Git-bash
	command -nargs=* GBash execute '!start cmd /b /c "start '.$GIT_HOME.'\git-bash.exe'.<q-args>.'"'
endif


" Remap <C-x> key because vim uses it for stuff, and we want to use <C-x> for
" cutting
" I.e. <C-x><C-o> is the default key combo to activate omnicompletion
" inoremap <C-;> <C-x>

" For opening tabs
" nnoremap <silent> <C-b>c :tabnew<CR>:NERDTreeMirror<CR>:wincmd<Space>p<CR>
" inoremap <silent> <C-b>c <esc>:tabnew<CR>:NERDTreeMirror<CR>:wincmd<Space>p<CR>i


" Ctrl-y and Ctrl-v copy (yank) and paste to and from system clipboard
" \"* and \"+ are registers for the system's clipboard (:h registers) ("* is primary (mouse selection), and "+ is clipboard (ctrl+c))
" nnoremap <C-v> "+pl
" xnoremap <C-v> "+pl
" inoremap <C-v> <esc>"+pli
" nnoremap <C-c> "+y
" xnoremap <C-c> "+y
" inoremap <C-c> <esc>"+yi
" nnoremap <C-x> v"+d
" xnoremap <C-x> v"+d
" inoremap <C-x> <esc>v"+di
" Paste
" Copy
" Cut

" Shortcut to duplicate line
" nnoremap <C-D><C-D> Vyp
" inoremap <C-D><C-D> <esc>Vypi
" noremap <C-S-D><C-S-D> Vyp

" Move line up
" nnoremap <C-Up> VDkP==
" xnoremap <C-Up> DkP`[v`]==`[v`]
" inoremap <C-Up> <esc>VDkP==<esc>i

" Move line down
" nnoremap <C-Down> VDjP==
" xnoremap <C-Down> DjP`[v`]==`[v`]
" inoremap <C-Down> <esc>VDjP==<esc>i

" Indent selected blocks of text
" xnoremap <Tab> >gv
" xnoremap <S-Tab> <gv


" Undo
" nnoremap <C-z> u
" inoremap <C-z> <esc>ui

" Redo
" nnoremap <C-y> <C-r>
" inoremap <C-y> <esc><C-r>i

" Save
" nnoremap <C-s> :w<CR>
" inoremap <C-s> <esc>:w<CR>i


" Cycle tabs
" Forward
" nnoremap <C-PageUp> gt
" inoremap <C-PageUp> <esc>gti
" Backward
" nnoremap <C-PageDown> gT
" inoremap <C-PageDown> <esc>gTi

" Toggle Pastemode (paste! toggles paste option. 
" :paste? echoes the current state of paste mode
nnoremap <F2> :set paste! paste?<CR>

