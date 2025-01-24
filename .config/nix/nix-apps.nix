{
  pkgs,
  type ? "personal",
  ...
}:
{
  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages =
    with pkgs;
    if type == "work" then
      [
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
      ]
    else
      [
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

        # # It is sometimes useful to fine-tune packages, for example, by applying
        # # overrides. You can do that directly here, just don't forget the
        # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
        # # fonts?
        # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

        # # You can also create simple shell scripts directly inside your
        # # configuration. For example, this adds a command 'my-hello' to your
        # # environment:
        # (pkgs.writeShellScriptBin "my-hello" ''
        #   echo "Hello, ${config.home.username}!"
        # '')
      ];
}
