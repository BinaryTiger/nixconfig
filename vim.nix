with import <nixpkgs> {};

vim_configurable.customize {
  name = "vim";
  vimrcConfig.customRC = ''
    set number
    set showmatch
    
    set showmode
    set ruler
    set cursorline
    set formatoptions+=o
    set expandtab
    set shiftwidth=2
    set colorcolumn=80,100,120
    syntax enable
    autocmd filetype go setlocal ts=4 sw=4 sts=0 noexpandtab
    colorscheme Monokai
    hi colorcolumn ctermbg=0

    nmap <f7> :TagbarToggle<cr>
    nmap <f6> :NERDTree<cr>

    nnoremap ; :
  '';
  vimrcConfig.vam.knownPlugins = pkgs.vimPlugins;
  vimrcConfig.vam.pluginDictionaries = [
    { names = [
        "surround"
        "The_NERD_tree"
        "vim-gitgutter"
        "Tagbar"
        "vim-nix"
        "vim-elixir"
        "youcompleteme"
        "The_NERD_Commenter"
        "alchemist-vim"
        "vim-colorschemes"
        "rust-vim"
      ]; 
    }
  ];
}
