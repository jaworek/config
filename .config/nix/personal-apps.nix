{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    telegram-desktop
    spotify
    discord
    #does not start for some reason
    #synology-drive-client
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
    scrcpy
    watchman
    zulu17
    cocoapods
    rustup
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
