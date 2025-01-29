{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    # fd and ripgrep are needed for telescope plugin in nvim
    fd
    ripgrep
    raycast
    neovim
    git
    karabiner-elements
    tmux
    delta
    nixfmt-rfc-style
    starship
    lazygit
  ];
}
