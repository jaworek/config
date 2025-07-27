{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    bun
    darwin.xcode_16_1
    watchman
    zulu17
    cocoapods
    rustup
    jetbrains.webstorm
    _1password-gui
    eas-cli
  ];
}
