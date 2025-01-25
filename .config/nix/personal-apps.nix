{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    telegram-desktop
    raycast
    spotify
    neovim
    git
    karabiner-elements
    discord
    #does not start for some reason
    #synology-drive-client
    tmux
    yt-dlp
    go
    bun
    ansible
    darwin.xcode_16_1
    # blender
    keka
    iina
    nodejs_20
    ffmpeg-full
    obsidian
    scrcpy
    # fd and ripgrep are needed for telescope plugin in nvim
    fd
    ripgrep
    scrcpy
    watchman
    zulu17
    cocoapods
    rustup
    delta
    #monero-gui
    #sweethome3d.application
    signal-desktop
    gh
    # kicad
    # freecad
    #enpass
    #firefox
    #steam
    #vlc
    #the-unarchiver or unar (the one available in nix seems to be cli only)
  ];
}
