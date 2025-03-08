{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    # fd and ripgrep are needed for telescope plugin in nvim
    fd
    ripgrep
    # fzf is needed for zsh
    fzf
    raycast
    neovim
    git
    karabiner-elements
    tmux
    delta
    nixfmt-rfc-style
    starship
    lazygit
    # needed for nil-ls to install
    rustup
    arc-browser
  ];
}
