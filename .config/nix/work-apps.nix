{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    raycast
    neovim
    git
    karabiner-elements
    tmux
    bun
    darwin.xcode_16_1
    scrcpy
    # fd and ripgrep are needed for telescope plugin in nvim
    fd
    ripgrep
    watchman
    zulu17
    cocoapods
    rustup
    delta
    jetbrains.webstorm
    gh
  ];
}
