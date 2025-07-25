{
  config,
  type ? "personal",
  ...
}:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  imports = [
    ./apps/common.nix
    ./home-manager/ghostty.nix
    ./home-manager/git.nix
  ]
  ++ (
    if type == "work" then
      [
        ./apps/work.nix
      ]
    else
      [
        ./apps/personal.nix
      ]
  );

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
    ".config/karabiner".source = ./dotfiles/karabiner;
    ".config/tmux".source = config.lib.file.mkOutOfStoreSymlink ./dotfiles/tmux;
    ".zshrc".source = config.lib.file.mkOutOfStoreSymlink ./dotfiles/zsh/.zshrc;
    ".config/zed/settings.json".source = ./dotfiles/zed/settings.json;
  };

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/davish/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
    EDITOR = "nvim";
    # need to manually define it for tmux to find config correctly
    XDG_CONFIG_HOME = "$HOME/.config";
    JAVA_HOME = "/Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
