{
  pkgs,
  config,
  ...
}:
{
  home.packages = with pkgs; [
    neovim
    # fd and ripgrep are needed for telescope plugin in nvim
    fd
    ripgrep
    nixfmt-rfc-style
    lazygit
    # needed for nil-ls to install
    rustup
    # neeeded for gopls in nvim
    go
  ];

  home.file = {
    ".config/nvim".source = ./dotfiles/nvim;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

}
